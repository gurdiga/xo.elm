module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (contenteditable)


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
                , template actPreluare.values (\v -> callback (Just (ActPreluare { actPreluare | document = v })))
                , button [] [ text "Imprimă" ]
                , button [] [ text "Formează din nou" ]
                ]

        Nothing ->
            button [ onClick (callback (Just newValue)) ] [ text "Formează act de preluare" ]


template : List String -> (String -> msg) -> Html msg
template values callback =
    div [ contenteditable True, onInput (\v -> callback (Debug.log "document" v)) ]
        [ h1 [] [ text "Act de preluare" ]
        , p [] [ text "TODO: find a sample document and populate it with values" ]
        ]



-- TODO: What’s the job-to-be-done? What UX?
