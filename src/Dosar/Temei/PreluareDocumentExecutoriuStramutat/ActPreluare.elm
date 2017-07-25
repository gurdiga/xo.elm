module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick, on)
import Html.Attributes exposing (id)
import RichTextEditor exposing (DocumentTemplate(TemplateActPreluare))


type ActPreluare
    = ActPreluare Data


type alias Data =
    { html : String
    , values : List String
    }


newValue : ActPreluare
newValue =
    ActPreluare
        { html = ""
        , values = []
        }


view : Maybe ActPreluare -> (Maybe ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just (ActPreluare actPreluare) ->
            fieldset []
                [ legend []
                    [ text "Act de preluare"
                    , button
                        [ onClick
                            (let
                                editorCmd =
                                    RichTextEditor.send templateId

                                editorSub =
                                    RichTextEditor.onResponse onEditorResponse

                                onEditorResponse v =
                                    callback (Just (ActPreluare { actPreluare | html = v })) Cmd.none Sub.none
                             in
                                callback maybeActPreluare editorCmd editorSub
                            )
                        ]
                        [ text "Edit" ]
                    ]
                , template { a = 1 }
                ]

        Nothing ->
            button [ onClick (callback (Just newValue) Cmd.none Sub.none) ] [ text "Formează act de preluare" ]


template : a -> Html msg
template data =
    div [ id templateId ]
        [ h1 [] [ text "ActPreluare" ]
        , p [] [ text <| toString <| data ]
        ]


templateId : String
templateId =
    toString TemplateActPreluare
