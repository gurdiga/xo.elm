module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, newValue, view)

import Html exposing (Html, text)


type DocumentExecutoriu
    = DocumentExecutoriu Data


type alias Data =
    {}


newValue : DocumentExecutoriu
newValue =
    DocumentExecutoriu {}


view : DocumentExecutoriu -> (DocumentExecutoriu -> msg) -> Html msg
view documentExecutoriu callback =
    text "TODO: DocumentExecutoriu.view"
