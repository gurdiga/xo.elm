module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru
    exposing
        ( Sechestru
        , editView
        , fromItems
        , view
        , withItemsSelected
        )

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selection as Selection exposing (Selection)
import Html exposing (Html, button, fieldset, h1, legend, li, text, ul)
import Utils.MyHtml exposing (whenTrue)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.RichTextEditor as RichTextEditor


type Sechestru
    = Sechestru
        { bunuri : List BunUrmarit
        , procesVerbal : String
        , selection : Selection BunUrmarit
        }


fromItems : List BunUrmarit -> Sechestru
fromItems bunuri =
    Sechestru
        { bunuri = bunuri
        , procesVerbal = ""
        , selection = Selection.fromItems bunuri
        }



-- for coding convenience only


withItemsSelected : List BunUrmarit -> Sechestru
withItemsSelected bunuri =
    Sechestru
        { bunuri = bunuri
        , procesVerbal = ""
        , selection = Selection.withItemsSelected bunuri
        }


type alias Input msg =
    { sechestru : Sechestru
    , updateCallback : Callback msg
    , submitCallback : Callback msg
    , cancelCallback : Callback msg
    }


type alias Callback msg =
    Sechestru -> Cmd msg -> Sub msg -> msg


editView : Input msg -> Html msg
editView { sechestru, updateCallback, submitCallback, cancelCallback } =
    let
        this =
            fieldset []
                [ legend []
                    [ text "Selecteză bunurile de sechestrat"
                    , button [ onClick (\_ -> cancelCallback sechestru Cmd.none Sub.none) ] [ text "×" ]
                    ]
                , Selection.view
                    { selection = data.selection
                    , itemDisplayView = BunUrmarit.view
                    , callback = \v -> updateCallback (Sechestru { data | selection = v }) Cmd.none Sub.none
                    }
                , whenTrue anyItemSelected genereazaProcesVerbal
                ]

        (Sechestru data) =
            sechestru

        anyItemSelected =
            Selection.anyItemSelected data.selection

        genereazaProcesVerbal _ =
            RichTextEditor.view
                { buttonLabel = "Genereaza proces verbal"
                , content = templateProcesVerbal (Selection.selectedItems data.selection)
                , onOpen = updateCallback sechestru
                , onResponse = \s -> submitCallback (Sechestru { data | procesVerbal = s }) Cmd.none Sub.none
                }
    in
    this


templateProcesVerbal : List BunUrmarit -> List (Html msg)
templateProcesVerbal items =
    -- TODO: template?
    [ h1 [] [ text "Proces verbal de sechestru" ]
    , items |> toString |> text
    ]


view : Sechestru -> Html msg
view (Sechestru { selection }) =
    Selection.selectedItems selection
        |> List.map BunUrmarit.view
        |> List.map (\itemView -> li [] [ itemView ])
        |> ul []
