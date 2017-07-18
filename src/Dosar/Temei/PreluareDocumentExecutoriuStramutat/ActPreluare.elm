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


view : Maybe ActPreluare -> (Cmd msg -> Maybe ActPreluare -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just (ActPreluare actPreluare) ->
            fieldset []
                [ legend [] [ text "Act de preluare" ]
                , text "****"
                , button [] [ text "Imprimă" ]
                , button [] [ text "Formează din nou" ]
                , Editor.view actPreluare.document (\v -> callback Cmd.none (Just (ActPreluare { actPreluare | document = v })))
                ]

        Nothing ->
            button [ onClick (callback Cmd.none (Just newValue)) ] [ text "Formează act de preluare" ]
