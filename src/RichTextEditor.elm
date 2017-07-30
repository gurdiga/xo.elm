port module RichTextEditor exposing (view, send, onResponse, TemplateId(TemplateActPreluare, TemplateIncheiereIntentare))

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, id)


type TemplateId
    = TemplateActPreluare
    | TemplateIncheiereIntentare


type alias Input a msg =
    { maybeValue : Maybe a
    , newValue : a
    , templateId : TemplateId -- TODO: consider reusing the same div to hold the content to edit
    , compiledTemplate : List (Html msg)
    , callback : Maybe a -> Cmd msg -> Sub msg -> msg
    , valueConstructor : a -> String -> a
    }


view : Input a msg -> Html msg
view { maybeValue, newValue, templateId, compiledTemplate, valueConstructor, callback } =
    case maybeValue of
        Just value ->
            button
                [ onClick
                    (let
                        editorCmd =
                            send (toString templateId)

                        editorSub =
                            onResponse onEditorResponse

                        onEditorResponse s =
                            callback (Just (valueConstructor value s)) Cmd.none Sub.none
                     in
                        callback (Just value) editorCmd editorSub
                    )
                ]
                [ text "Editează"
                , div [ style [ ( "display", "none" ) ], id (toString templateId) ] compiledTemplate
                ]

        Nothing ->
            button [ onClick (callback (Just newValue) Cmd.none Sub.none) ] [ text "Formează" ]


send : String -> Cmd msg
send =
    sendToEditor


onResponse : (String -> msg) -> Sub msg
onResponse =
    onResponseFromEditor


port sendToEditor : String -> Cmd msg


port onResponseFromEditor : (String -> msg) -> Sub msg
