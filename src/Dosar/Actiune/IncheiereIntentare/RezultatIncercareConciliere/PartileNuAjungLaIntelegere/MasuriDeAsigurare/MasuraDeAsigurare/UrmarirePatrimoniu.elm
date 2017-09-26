module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu
    exposing
        ( UrmarirePatrimoniu
        , new
        , view
        )

import Html exposing (Html, fieldset, legend, div, p, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyHtml exposing (whenNonNothing, whenNothing, whenNonEmpty)
import Utils.Money as Money exposing (Money(Money), Currency(EUR, USD))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList as EditableList exposing (EditableList)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare as Sechestrare exposing (Sechestrare)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : List BunUrmarit
        , editableList : Maybe (EditableList BunUrmarit)
        , regim : Regim
        , sechestrare : Maybe Sechestrare
        }


type Regim
    = Listare
    | Adaugare
    | Sechestrare


new : UrmarirePatrimoniu
new =
    let
        this =
            UrmarirePatrimoniu
                { bunuriUrmarite = someItems
                , editableList = initialEditableList someItems inAddMode
                , sechestrare = Nothing
                , regim = Listare
                }

        inAddMode =
            False
    in
        this


initialEditableList : List BunUrmarit -> Bool -> Maybe (EditableList BunUrmarit)
initialEditableList items inAddMode =
    Just
        (EditableList.new
            { items = someItems
            , inAddMode = inAddMode
            , hasExternalAddTrigger = True
            }
        )


someItems : List BunUrmarit
someItems =
    []


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> Cmd msg -> Sub msg -> msg) -> Html msg
view (UrmarirePatrimoniu data) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "UrmarirePatrimoniu" ]
                , maybeHelpCopy data.bunuriUrmarite
                , whenNonNothing data.editableList
                    (\editableList ->
                        EditableList.view
                            { editableList = data.editableList
                            , editItemView = BunUrmarit.editForm
                            , displayItemView = BunUrmarit.view
                            , newItem = BunUrmarit.empty
                            , callback = (\v -> c { data | editableList = Just v } Cmd.none Sub.none)
                            }
                    )
                , whenNonNothing data.sechestrare
                    (\sechestrare ->
                        Sechestrare.view
                            { sechestrare = sechestrare
                            , submitCalllback = (\v -> c { data | sechestrare = Just v })
                            , cancelCallback =
                                (\v ->
                                    c
                                        { data
                                            | sechestrare = Nothing
                                            , editableList = initialEditableList data.bunuriUrmarite inAddMode
                                        }
                                )
                            }
                    )
                , actionButtons
                ]

        inAddMode =
            data.regim == Adaugare

        c data =
            callback (UrmarirePatrimoniu data)

        actionButtons =
            div [] [ butonAdaugareBun, butonAplicareSechestru ]

        butonAdaugareBun =
            if data.regim == Listare then
                button [ onClick (\_ -> c { data | regim = Adaugare } Cmd.none Sub.none) ] [ text "Adaugați bun" ]
            else
                text ""

        butonAplicareSechestru =
            if List.isEmpty data.bunuriUrmarite then
                text ""
            else
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


maybeHelpCopy : List BunUrmarit -> Html msg
maybeHelpCopy bunuriUrmarite =
    if List.isEmpty bunuriUrmarite then
        p [] [ text "Încă nu ați introdus bunuri urmărite." ]
    else
        text ""
