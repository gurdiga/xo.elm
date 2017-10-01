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
        , sechestre : List Sechestru
        , regim : Regim
        }


type Regim
    = Editare (EditableList BunUrmarit)
    | Sechestrare Sechestru


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = someBunuriUrmarite
        , sechestre = someSechestre
        , regim = Editare (EditableList.fromItems someBunuriUrmarite)
        }


someBunuriUrmarite : List BunUrmarit
someBunuriUrmarite =
    [ BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
    , BunUrmarit { denumire = "Automobil Porche", valoare = Money 250000 USD, note = "Yeah!" }
    ]


someSechestre : List Sechestru
someSechestre =
    [ Sechestru.withItemsSelected someBunuriUrmarite ]


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> Cmd msg -> Sub msg -> msg) -> Html msg
view (UrmarirePatrimoniu data) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "UrmarirePatrimoniu" ]
                , case data.regim of
                    Editare editableList ->
                        listaBunuri editableList

                    Sechestrare sechestru ->
                        formularSechestru sechestru
                , listaSechestre
                , actionButtons
                ]

        c data =
            callback (UrmarirePatrimoniu data)

        listaBunuri editableList =
            fieldset []
                [ legend [] [ text "Lista bunurilor urmărite" ]
                , EditableList.view
                    { editableList = editableList
                    , editItemView = BunUrmarit.editForm
                    , displayItemView = BunUrmarit.view
                    , newItem = BunUrmarit.empty
                    , callback = (\v -> c { data | regim = Editare v } Cmd.none Sub.none)
                    }
                ]

        formularSechestru sechestru =
            Sechestru.editView
                { sechestru = sechestru
                , updateCallback = (\sechestru -> c { data | regim = Sechestrare sechestru })
                , submitCallback =
                    (\sechestru ->
                        c
                            { data
                                | regim = Editare (EditableList.fromItems data.bunuriUrmarite)
                                , sechestre = data.sechestre ++ [ sechestru ]
                            }
                    )
                , cancelCallback = (\_ -> c { data | regim = Editare (EditableList.fromItems data.bunuriUrmarite) })
                }

        listaSechestre =
            fieldset []
                [ legend [] [ text "Lista de sechestre" ]
                , EditableList.view
                    { editableList = EditableList.fromItems data.sechestre
                    , editItemView = (\sechestru updateCallback submitCallback cancelCallback -> toString sechestru |> text)
                    , displayItemView = Sechestru.view
                    , newItem = Sechestru.fromItems data.bunuriUrmarite
                    , callback = (\editableList -> c data Cmd.none Sub.none)
                    }
                ]

        actionButtons =
            div [] [ butonAplicareSechestru ]

        butonAplicareSechestru =
            button
                [ onClick (\_ -> c { data | regim = Sechestrare (Sechestru.fromItems data.bunuriUrmarite) } Cmd.none Sub.none) ]
                [ text "Aplică sechestru" ]
    in
        this
