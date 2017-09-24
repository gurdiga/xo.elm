module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare
    exposing
        ( Sechestrare
        , fromItems
        , view
        )

import Html exposing (Html, h1, fieldset, legend, ul, li, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyHtml exposing (whenTrue)
import Utils.RichTextEditor as RichTextEditor
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selection as Selection exposing (Selection)


type Sechestrare
    = Sechestrare
        { bunuri : List BunUrmarit
        , procesVerbal : String
        , selection : Selection BunUrmarit
        }


fromItems : List BunUrmarit -> Sechestrare
fromItems bunuri =
    Sechestrare
        { bunuri = bunuri
        , procesVerbal = ""
        , selection = Selection.fromItems bunuri
        }


type alias Input msg =
    { sechestrare : Sechestrare
    , submitCalllback : Callback msg
    , cancelCallback : Callback msg
    }


type alias Callback msg =
    Sechestrare -> Cmd msg -> Sub msg -> msg


view : Input msg -> Html msg
view { sechestrare, submitCalllback, cancelCallback } =
    let
        this =
            fieldset []
                [ legend []
                    [ text "Selecteză bunurile de sechestrat"
                    , button [ onClick (\_ -> cancelCallback sechestrare Cmd.none Sub.none) ] [ text "×" ]
                    ]
                , Selection.view
                    { selection = data.selection
                    , itemDisplayView = BunUrmarit.view
                    , callback = (\v -> submitCalllback (Sechestrare { data | selection = v }) Cmd.none Sub.none)
                    }
                , whenTrue anyItemSelected genereazaProcesVerbal
                ]

        (Sechestrare data) =
            sechestrare

        anyItemSelected =
            Selection.anyItemSelected data.selection

        genereazaProcesVerbal _ =
            RichTextEditor.view
                { buttonLabel = "Genereaza proces verbal"
                , content = templateProcesVerbal (Selection.selectedItems data.selection)
                , onOpen = submitCalllback sechestrare
                , onResponse = (\s -> submitCalllback (Sechestrare { data | procesVerbal = s }) Cmd.none Sub.none)
                }
    in
        this


templateProcesVerbal : List BunUrmarit -> List (Html msg)
templateProcesVerbal items =
    -- TODO: template?
    [ h1 [] [ text "Proces verbal de sechestrare" ]
    , items |> toString |> text
    ]
