module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick)
import Html.Attributes exposing (id)
import RichTextEditor exposing (DocumentTemplate(TemplateActPreluare))


type ActPreluare
    = ActPreluare Data


type alias Data =
    { generatedHtml : String
    , templateData : TemplateData
    }


type TemplateData
    = TemplateData


newValue : ActPreluare
newValue =
    ActPreluare
        { generatedHtml = ""
        , templateData = TemplateData
        }


view : Maybe ActPreluare -> (Maybe ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeActPreluare callback =
    fieldset []
        [ legend [] [ text "Act de preluare" ]
        , div []
            (case maybeActPreluare of
                Just (ActPreluare actPreluare) ->
                    [ button
                        [ onClick
                            (let
                                editorCmd =
                                    RichTextEditor.send templateId

                                editorSub =
                                    RichTextEditor.onResponse onEditorResponse

                                onEditorResponse v =
                                    callback (Just (ActPreluare { actPreluare | generatedHtml = v })) Cmd.none Sub.none
                             in
                                callback maybeActPreluare editorCmd editorSub
                            )
                        ]
                        [ text "Editează" ]
                    , template TemplateData
                    ]

                Nothing ->
                    [ button [ onClick (callback (Just newValue) Cmd.none Sub.none) ] [ text "Formează act de preluare" ] ]
            )
        ]


template : TemplateData -> Html msg
template data =
    div [ id templateId ]
        [ h1 [] [ text "ActPreluare" ]
        , p [] [ text <| toString <| data ]
        ]


templateId : String
templateId =
    toString TemplateActPreluare
