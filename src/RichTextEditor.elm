port module RichTextEditor
    exposing
        ( view
        , TemplateId
            ( TemplateActPreluare
            , TemplateIncheiereIntentare
            )
        )

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, id)


type TemplateId
    = TemplateActPreluare
    | TemplateIncheiereIntentare


type alias Input msg =
    { labelText : String
    , templateId : TemplateId
    , compiledTemplate : List (Html msg)
    , onSend : Cmd msg -> Sub msg -> msg
    , onReceive : String -> msg
    }


view : Input msg -> Html msg
view { labelText, templateId, compiledTemplate, onSend, onReceive } =
    let
        contentPreparedForEditor =
            div
                [ style [ ( "display", "none" ) ]
                , id (toString templateId)
                ]
                compiledTemplate

        editorCmd =
            sendToEditor (toString templateId)

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
