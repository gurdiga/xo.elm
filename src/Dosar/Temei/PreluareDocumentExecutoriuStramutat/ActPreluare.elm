module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, button, text)


type ActPreluare
    = ActPreluare


newValue : ActPreluare
newValue =
    ActPreluare


view : Maybe ActPreluare -> (Maybe ActPreluare -> msg) -> Html msg
view maybeActPreluare callback =
    case maybeActPreluare of
        Just actPreluare ->
            button [] [ text ("Editează act preluare: " ++ toString actPreluare) ]

        Nothing ->
            button [] [ text "Formează act de preluare" ]



-- TODO: What’s the job-to-be-done? What UX?
