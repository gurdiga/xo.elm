module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (ActEfectuatAnterior, newValue, view)

import Html exposing (Html, tr, td, text)


type ActEfectuatAnterior
    = A -- TODO: enumerat possible kinds of documents
    | B
    | C


newValue : ActEfectuatAnterior
newValue =
    B


view : ActEfectuatAnterior -> (ActEfectuatAnterior -> msg) -> Html msg
view actEfectuatAnterior callback =
    tr [] [ td [] [ text (toString actEfectuatAnterior) ] ]
