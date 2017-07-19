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
        { document = ""
        , values = []
        }


view : Maybe ActPreluare -> (Maybe ActPreluare -> Sub msg -> Cmd msg -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just (ActPreluare actPreluare) ->
            fieldset []
                [ legend [] [ text "Act de preluare" ]
                , Editor.view actPreluare.document
                    (\v ->
                        callback
                            (Just (ActPreluare { actPreluare | document = v }))
                            (Editor.receiveFromEditor (\v -> callback (Just (ActPreluare { actPreluare | document = v })) Sub.none Cmd.none))
                            (Editor.sendToEditor "actPreluare.document")
                    )
                ]

        Nothing ->
            button [ onClick (callback (Just newValue) Sub.none Cmd.none) ] [ text "Formează act de preluare" ]
