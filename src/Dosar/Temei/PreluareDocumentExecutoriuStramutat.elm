module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat, newValue, view)

import Html exposing (Html, text)


type PreluareDocumentExecutoriuStramutat
    = PreluareDocumentExecutoriuStramutat


newValue : PreluareDocumentExecutoriuStramutat
newValue =
    PreluareDocumentExecutoriuStramutat


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> msg) -> Html msg
view preluareDocumentExecutoriuStramutat callback =
    text "PreluareDocumentExecutoriuStramutat"
