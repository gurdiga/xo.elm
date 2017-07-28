port module RichTextEditor exposing (view, send, onResponse, DocumentTemplate(TemplateActPreluare, TemplateIncheiereIntentare))

import Html exposing (Html, button, text)
import Html.Events exposing (onClick)
import Html.Attributes


type DocumentTemplate
    = TemplateActPreluare
    | TemplateIncheiereIntentare


type alias Input a =
    { value : Maybe a
    , newValue : a
    , documentTemplate : DocumentTemplate
    , valueConstructor : b -> a
    }


view : Maybe a -> a -> DocumentTemplate -> (t -> a) -> (Maybe ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view value newValue template constructor callback =
    case value of
        Just v ->
            button
                [ onClick
                    (let
                        editorCmd =
                            send (toString template)

                        editorSub =
                            onResponse onEditorResponse

                        onEditorResponse v =
                            callback (Just (constructor { data | generatedHtml = v })) Cmd.none Sub.none
                     in
                        callback value editorCmd editorSub
                    )
                ]
                [ text "Editează" ]

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
