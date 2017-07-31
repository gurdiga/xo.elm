port module RichTextEditor exposing (view)

-- This widget assumes that there will be at most one instance of RTE open at
-- any given time, and it will be closed before openeing another one.

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, id)
import FNV as HashingUtility


type alias Input msg =
    { buttonLabel : String
    , content : List (Html msg)

    -- This is an API leak: Idealy the client code should not be aware of this
    -- widget’s needs, but this is needed to send the content to the RTE.
    , onOpen : Cmd msg -> Sub msg -> msg
    , onResponse : String -> msg
    }


view : Input msg -> Html msg
view { buttonLabel, content, onOpen, onResponse } =
    let
        contentPreparedForEditor =
            div
                [ style [ ( "display", "none" ) ]
                , id contentUuid
                ]
                content

        contentUuid =
            content |> toString |> HashingUtility.hashString |> toString |> (++) "content-to-edit-"

        editorCmd =
            richTextEditorSendContent contentUuid

        editorSub =
            richTextEditorOnReceiveResponse onResponse
    in
        button
            [ onClick (onOpen editorCmd editorSub) ]
            [ text buttonLabel
            , contentPreparedForEditor
            ]


port richTextEditorSendContent : String -> Cmd msg


port richTextEditorOnReceiveResponse : (String -> msg) -> Sub msg
