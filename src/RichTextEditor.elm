port module RichTextEditor exposing (view)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, id)
import FNV as HashUtility


type alias Input msg =
    { buttonLabel : String
    , content : List (Html msg)
    , onEdit : Cmd msg -> Sub msg -> msg
    , onReceive : String -> msg
    }


view : Input msg -> Html msg
view { buttonLabel, content, onEdit, onReceive } =
    let
        contentPreparedForEditor =
            div
                [ style [ ( "display", "none" ) ]
                , id contentUuid
                ]
                content

        contentUuid =
            content |> toString |> HashUtility.hashString |> toString |> (++) "content-to-edit-"

        editorCmd =
            sendToEditor contentUuid

        editorSub =
            onResponseFromEditor onReceive
    in
        button
            [ onClick (onEdit editorCmd editorSub) ]
            [ text buttonLabel
            , contentPreparedForEditor
            ]


port sendToEditor : String -> Cmd msg


port onResponseFromEditor : (String -> msg) -> Sub msg
