module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior
    exposing
        ( ActEfectuatAnterior(ActEfectuatAnterior)
        , Data
        , newValue
        , data
        )

import DocumentScanat exposing (DocumentScanat)


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
data (ActEfectuatAnterior data) =
    data
