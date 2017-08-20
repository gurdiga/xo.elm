module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare.DocumentAplicareMasuriAsigurare
    exposing
        ( DocumentAplicareMasuriAsigurare(DocumentAplicareMasuriAsigurare)
        , Data
        , empty
        , data
        )


type DocumentAplicareMasuriAsigurare
    = DocumentAplicareMasuriAsigurare Data


type alias Data =
    { denumire : String
    , note : String
    }


empty : DocumentAplicareMasuriAsigurare
empty =
    DocumentAplicareMasuriAsigurare { denumire = "", note = "" }


data : DocumentAplicareMasuriAsigurare -> Data
data (DocumentAplicareMasuriAsigurare data) =
    data
