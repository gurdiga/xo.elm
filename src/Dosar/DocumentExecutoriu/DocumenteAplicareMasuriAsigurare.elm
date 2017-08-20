module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare, newValue, view)

import Html exposing (Html, fieldset, legend, text)


type DocumenteAplicareMasuriAsigurare
    = DocumenteAplicareMasuriAsigurare


newValue : DocumenteAplicareMasuriAsigurare
newValue =
    DocumenteAplicareMasuriAsigurare


view : DocumenteAplicareMasuriAsigurare -> (DocumenteAplicareMasuriAsigurare -> msg) -> Html msg
view documenteAplicareMasuriAsigurare callback =
    fieldset []
        [ legend [] [ text "DocumenteAplicareMasuriAsigurare" ]
        , text "TODO"
        ]
