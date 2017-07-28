module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id)
import RichTextEditor exposing (DocumentTemplate(TemplateIncheiereIntentare))


type IncheiereIntentare
    = IncheiereIntentare Data


type alias Data =
    { generatedHtml : String
    , templateData : TemplateData
    }


type TemplateData
    = TemplateData


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare
        { generatedHtml = ""
        , templateData = TemplateData
        }


view : Maybe IncheiereIntentare -> (Maybe IncheiereIntentare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeIncheiereIntentare callback =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , div []
            (case maybeIncheiereIntentare of
                Just (IncheiereIntentare data) ->
                    [ button
                        [ onClick
                            (let
                                editorCmd =
                                    RichTextEditor.send templateId

                                editorSub =
                                    RichTextEditor.onResponse onEditorResponse

                                onEditorResponse v =
                                    callback (Just (IncheiereIntentare { data | generatedHtml = v })) Cmd.none Sub.none
                             in
                                callback maybeIncheiereIntentare editorCmd editorSub
                            )
                        ]
                        [ text "Editează" ]
                    , template TemplateData
                    ]

                Nothing ->
                    [ button [ onClick (callback (Just newValue) Cmd.none Sub.none) ] [ text "Formează" ] ]
            )
        ]


template : TemplateData -> Html msg
template data =
    div [ id templateId ]
        [ h1 [] [ text "IncheiereIntentare" ]
        , p [] [ text <| toString <| data ]
        ]


templateId : String
templateId =
    toString TemplateIncheiereIntentare
