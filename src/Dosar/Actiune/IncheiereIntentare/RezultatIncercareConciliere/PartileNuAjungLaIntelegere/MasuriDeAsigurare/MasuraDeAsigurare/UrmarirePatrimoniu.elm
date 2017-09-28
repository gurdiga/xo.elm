module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, div, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.Money as Money exposing (Money(Money), Currency(EUR, USD))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList as EditableList exposing (EditableList)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru as Sechestru exposing (Sechestru)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : List BunUrmarit
        , regim : Regim
        }


type Regim
    = Editare (EditableList BunUrmarit)
    | Sechestrare Sechestru


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = someItems
        , regim = Editare (EditableList.fromItems someItems)
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
                , case data.regim of
                    Editare editableList ->
                        EditableList.view
                            { editableList = editableList
                            , editItemView = BunUrmarit.editForm
                            , displayItemView = BunUrmarit.view
                            , newItem = BunUrmarit.empty
                            , callback = (\v -> c { data | regim = Editare v } Cmd.none Sub.none)
                            }

                    Sechestrare sechestru ->
                        Sechestru.view
                            { sechestru = sechestru
                            , submitCalllback = (\v -> c { data | regim = Sechestrare v })
                            , cancelCallback = (\v -> c { data | regim = Editare (EditableList.fromItems data.bunuriUrmarite) })
                            }
                , actionButtons
                ]

        c data =
            callback (UrmarirePatrimoniu data)

        actionButtons =
            div [] [ butonAplicareSechestru ]

        butonAplicareSechestru =
            button
                [ onClick (\_ -> c { data | regim = Sechestrare (Sechestru.fromItems data.bunuriUrmarite) } Cmd.none Sub.none) ]
                [ text "Aplică sechestru" ]
    in
        this
