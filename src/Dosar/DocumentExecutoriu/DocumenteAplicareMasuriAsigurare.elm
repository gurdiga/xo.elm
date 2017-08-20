module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare, newValue, view)

import Html exposing (Html, fieldset, legend, text)
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledTextField, unlabeledLargeTextField)
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare.DocumentAplicareMasuriAsigurare as DocumentAplicareMasuriAsigurare exposing (DocumentAplicareMasuriAsigurare(DocumentAplicareMasuriAsigurare))


type DocumenteAplicareMasuriAsigurare
    = DocumenteAplicareMasuriAsigurare (List DocumentAplicareMasuriAsigurare)


newValue : DocumenteAplicareMasuriAsigurare
newValue =
    DocumenteAplicareMasuriAsigurare []


view : DocumenteAplicareMasuriAsigurare -> (DocumenteAplicareMasuriAsigurare -> msg) -> Html msg
view documenteAplicareMasuriAsigurare callback =
    fieldset []
        [ legend [] [ text "DocumenteAplicareMasuriAsigurare" ]
        , Table.view
            { data = data documenteAplicareMasuriAsigurare
            , callback = callback << fromData
            , columns =
                [ ( "Denumire", (\r c -> unlabeledTextField r.denumire (\v -> c { r | denumire = v })) )
                , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
                ]
            , emptyView = text ""
            , newValue = DocumentAplicareMasuriAsigurare.data DocumentAplicareMasuriAsigurare.newValue
            }
        ]


data : DocumenteAplicareMasuriAsigurare -> List DocumentAplicareMasuriAsigurare.Data
data (DocumenteAplicareMasuriAsigurare list) =
    List.map DocumentAplicareMasuriAsigurare.data list


fromData : List DocumentAplicareMasuriAsigurare.Data -> DocumenteAplicareMasuriAsigurare
fromData =
    DocumenteAplicareMasuriAsigurare << List.map DocumentAplicareMasuriAsigurare
