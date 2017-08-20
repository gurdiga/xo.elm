module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare.DocumentAplicareMasuriAsigurare
    exposing
        ( DocumentAplicareMasuriAsigurare(DocumentAplicareMasuriAsigurare)
        , Data
        , newValue
        , data
        )


type DocumentAplicareMasuriAsigurare
    = DocumentAplicareMasuriAsigurare Data


type alias Data =
    { denumire : String
    , note : String
    }


newValue : DocumentAplicareMasuriAsigurare
newValue =
    DocumentAplicareMasuriAsigurare { denumire = "", note = "" }


data : DocumentAplicareMasuriAsigurare -> Data
data (DocumentAplicareMasuriAsigurare data) =
    data
