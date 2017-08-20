module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare.DocumentAplicareMasuriAsigurare
    exposing
        ( DocumentAplicareMasuriAsigurare(DocumentAplicareMasuriAsigurare)
        , Data
        , empty
        , data
        )

import DocumentScanat exposing (DocumentScanat)


type DocumentAplicareMasuriAsigurare
    = DocumentAplicareMasuriAsigurare Data


type alias Data =
    { denumire : String
    , note : String
    , copiaScanata : DocumentScanat
    }


empty : DocumentAplicareMasuriAsigurare
empty =
    DocumentAplicareMasuriAsigurare
        { denumire = ""
        , note = ""
        , copiaScanata = DocumentScanat.empty
        }


data : DocumentAplicareMasuriAsigurare -> Data
data (DocumentAplicareMasuriAsigurare data) =
    data
