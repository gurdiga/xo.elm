module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick, on)
import Html.Attributes exposing (contenteditable, property)
import Json.Decode
import Json.Encode


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


view : Maybe ActPreluare -> (Maybe ActPreluare -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just (ActPreluare actPreluare) ->
            fieldset []
                [ legend [] [ text "Act de preluare" ]
                , template actPreluare (\v -> callback (Just (ActPreluare { actPreluare | document = v })))
                , button [] [ text "Imprimă" ]
                , button [] [ text "Formează din nou" ]
                ]

        Nothing ->
            button [ onClick (callback (Just newValue)) ] [ text "Formează act de preluare" ]


template : Data -> (String -> msg) -> Html msg
template data callback =
    let
        c : Json.Decode.Decoder msg
        c =
            Json.Decode.map callback <| Json.Decode.at [ "target", "innerHTML" ] Json.Decode.string
    in
        if data.document == "" then
            div
                [ contenteditable True
                , on "input" c
                ]
                [ h1 [] [ text "Act de preluare" ]
                , p [] [ text "TODO: find a sample document and populate it with values" ]
                ]
        else
            div
                [ contenteditable True
                , on "input" c
                , property "innerHTML" (Json.Encode.string data.document)
                ]
                []
