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


type alias Input a msg =
    { maybeValue : Maybe a
    , newValue : a
    , templateId : TemplateId
    , compiledTemplate : List (Html msg)
    , callback : Maybe a -> Cmd msg -> Sub msg -> msg
    , setter : a -> String -> a
    }


view : Input a msg -> Html msg
view { maybeValue, newValue, templateId, compiledTemplate, setter, callback } =
    let
        editButton label value =
            button
                [ onClick (edit value) ]
                [ text label
                , contentPreparedForEditor
                ]

        edit value =
            callback (Just value) editorCmd (editorSub value)

        contentPreparedForEditor =
            div
                [ style [ ( "display", "none" ) ]
                , id (toString templateId)
                ]
                compiledTemplate

        editorCmd =
            sendToEditor (toString templateId)

        editorSub value =
            onResponseFromEditor
                (\newContent ->
                    callback (Just (setter value newContent)) Cmd.none Sub.none
                )
    in
        case maybeValue of
            Just value ->
                editButton "Editează" value

            Nothing ->
                editButton "Formează" newValue


port sendToEditor : String -> Cmd msg


port onResponseFromEditor : (String -> msg) -> Sub msg
