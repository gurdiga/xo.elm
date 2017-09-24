module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, div, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyHtml exposing (whenNonNothing, whenNothing)
import Utils.Money as Money exposing (Money(Money), Currency(EUR, USD))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList as EditableList exposing (EditableList)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare as Sechestrare exposing (Sechestrare)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : List BunUrmarit
        , editableList : Maybe (EditableList BunUrmarit)
        , sechestrare : Maybe Sechestrare
        }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = someItems
        , editableList = initialEditableList someItems
        , sechestrare = Nothing
        }


initialEditableList : List BunUrmarit -> Maybe (EditableList BunUrmarit)
initialEditableList items =
    Just (EditableList.fromItems someItems)


someItems : List BunUrmarit
someItems =
    [ BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
    , BunUrmarit { denumire = "Automobil Porche", valoare = Money 250000 USD, note = "Yeah!" }
    ]


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> Cmd msg -> Sub msg -> msg) -> Html msg
view (UrmarirePatrimoniu data) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "UrmarirePatrimoniu" ]
                , whenNonNothing data.sechestrare
                    (\sechestrare ->
                        Sechestrare.view sechestrare
                            (\v -> c { data | sechestrare = Just v })
                            (\v ->
                                c
                                    { data
                                        | sechestrare = Nothing
                                        , editableList = initialEditableList data.bunuriUrmarite
                                    }
                            )
                    )
                , whenNonNothing data.editableList
                    (\editableList ->
                        EditableList.view
                            { editableList = editableList
                            , editItemView = BunUrmarit.editForm
                            , displayItemView = BunUrmarit.view
                            , newItem = BunUrmarit.empty
                            , callback = (\v -> c { data | editableList = Just v } Cmd.none Sub.none)
                            }
                    )
                , actionButtons
                ]

        c data =
            callback (UrmarirePatrimoniu data)

        actionButtons =
            div [] [ butonAplicareSechestru ]

        butonAplicareSechestru =
            button
                [ onClick
                    (\_ ->
                        c
                            { data
                                | editableList = Nothing
                                , sechestrare = Just (Sechestrare.fromItems data.bunuriUrmarite)
                            }
                            Cmd.none
                            Sub.none
                    )
                ]
                [ text "Aplică sechestru" ]
    in
        this
