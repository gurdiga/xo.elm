module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick, on)
import Editor


type ActPreluare
    = ActPreluare Data


type alias Data =
    { document : String
    , values : List String
    }


newValue : ActPreluare
newValue =
    ActPreluare
        { document = "yes"
        , values = []
        }


view : Maybe ActPreluare -> (Maybe ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just (ActPreluare actPreluare) ->
            fieldset []
                [ legend [] [ text "Act de preluare" ]
                , text actPreluare.document
                , button
                    [ onClick
                        (let
                            editorCmd =
                                Editor.send actPreluare.document

                            editorSub =
                                Editor.onResponse onEditorResponse

                            onEditorResponse v =
                                callback (Just (ActPreluare { actPreluare | document = v })) Cmd.none Sub.none
                         in
                            callback maybeActPreluare editorCmd editorSub
                        )
                    ]
                    [ text "Edit" ]
                ]

        Nothing ->
            button [ onClick (callback (Just newValue) Cmd.none Sub.none) ] [ text "Formează act de preluare" ]
