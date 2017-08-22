module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior
    exposing
        ( ActEfectuatAnterior(ActEfectuatAnterior)
        , Data
        , empty
        , data
        )

import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)


type ActEfectuatAnterior
    = ActEfectuatAnterior Data


type alias Data =
    { copie : DocumentScanat
    , note : String
    }


empty : ActEfectuatAnterior
empty =
    ActEfectuatAnterior
        { copie = DocumentScanat.empty
        , note = ""
        }


data : ActEfectuatAnterior -> Data
data (ActEfectuatAnterior data) =
    data
