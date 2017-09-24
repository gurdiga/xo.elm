module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, div, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyHtml exposing (whenNonNothing, whenNothing)
import Utils.Money as Money exposing (Money(Money), Currency(EUR, USD))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList as EditableList exposing (EditableList(EditableList))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare as Sechestrare exposing (Sechestrare)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : List BunUrmarit
        , editare : Maybe EditableList
        , sechestrare : Maybe Sechestrare
        }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = someItems
        , editare = Just (EditableList.fromItems someItems)
        , sechestrare = Nothing
        }


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
                            (\v ->
                                { data | sechestrare = Just v }
                                    |> UrmarirePatrimoniu
                                    |> callback
                            )
                            (\v ->
                                { data | sechestrare = Nothing }
                                    |> UrmarirePatrimoniu
                                    |> callback
                            )
                    )
                , whenNonNothing data.editare
                    (\editare ->
                        EditableList.view editare
                            (\v ->
                                callback (UrmarirePatrimoniu { data | editare = Just v }) Cmd.none Sub.none
                            )
                    )
                , actionButtons
                ]

        actionButtons =
            div [] [ butonAplicareSechestru ]

        butonAplicareSechestru =
            button
                [ onClick
                    (\_ ->
                        callback
                            (UrmarirePatrimoniu
                                { data
                                    | sechestrare =
                                        data.bunuriUrmarite
                                            |> Sechestrare.fromItems
                                            |> Just
                                }
                            )
                            Cmd.none
                            Sub.none
                    )
                ]
                [ text "Aplică sechestru" ]
    in
        this
