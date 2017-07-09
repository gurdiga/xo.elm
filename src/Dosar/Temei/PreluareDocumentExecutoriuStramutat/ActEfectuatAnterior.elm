module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (ActEfectuatAnterior(ActEfectuatAnterior), newValue, data, view)

import Html exposing (Html, tr, td, text)
import Html.Attributes exposing (style)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (unlabeledLargeTextField)


type ActEfectuatAnterior
    = ActEfectuatAnterior Data


type alias Data =
    { copie : DocumentScanat
    , note : String
    }


newValue : ActEfectuatAnterior
newValue =
    ActEfectuatAnterior
        { copie = DocumentScanat.newValue
        , note = ""
        }


data : ActEfectuatAnterior -> Data
data (ActEfectuatAnterior v) =
    v


view : ActEfectuatAnterior -> (ActEfectuatAnterior -> msg) -> Html msg
view (ActEfectuatAnterior data) callback =
    let
        tdStyle =
            style [ ( "border", "1px solid silver" ) ]
    in
        tr []
            [ td [ tdStyle ] [ DocumentScanat.unlabeledView data.copie (\v -> callback <| ActEfectuatAnterior { data | copie = v }) ]
            , td [ tdStyle ] [ unlabeledLargeTextField data.note (\v -> callback <| ActEfectuatAnterior { data | note = v }) ]
            ]
