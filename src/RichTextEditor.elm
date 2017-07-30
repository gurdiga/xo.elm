port module RichTextEditor exposing (view)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, id)
import FNV as HashUtility


type alias Input msg =
    { labelText : String
    , compiledTemplate : List (Html msg)
    , onSend : Cmd msg -> Sub msg -> msg
    , onReceive : String -> msg
    }


view : Input msg -> Html msg
view { labelText, compiledTemplate, onSend, onReceive } =
    let
        contentPreparedForEditor =
            div
                [ style [ ( "display", "none" ) ]
                , id contentUuid
                ]
                compiledTemplate

        contentUuid =
            compiledTemplate |> toString |> HashUtility.hashString |> toString |> (++) "content-to-edit-"

        editorCmd =
            sendToEditor contentUuid

        editorSub =
            onResponseFromEditor onReceive
    in
        button
            [ onClick (onSend editorCmd editorSub) ]
            [ text labelText
            , contentPreparedForEditor
            ]


port sendToEditor : String -> Cmd msg


port onResponseFromEditor : (String -> msg) -> Sub msg
