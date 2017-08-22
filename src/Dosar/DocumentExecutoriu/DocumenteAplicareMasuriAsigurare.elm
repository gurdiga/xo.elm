module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare, empty, view)

import Html exposing (Html, fieldset, legend, text)
import DocumentScanat
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledTextField, unlabeledLargeTextField)
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare.DocumentAplicareMasuriAsigurare as DocumentAplicareMasuriAsigurare exposing (DocumentAplicareMasuriAsigurare(DocumentAplicareMasuriAsigurare))


type DocumenteAplicareMasuriAsigurare
    = DocumenteAplicareMasuriAsigurare (List DocumentAplicareMasuriAsigurare)


empty : DocumenteAplicareMasuriAsigurare
empty =
    DocumenteAplicareMasuriAsigurare []


view : DocumenteAplicareMasuriAsigurare -> (DocumenteAplicareMasuriAsigurare -> msg) -> Html msg
view documenteAplicareMasuriAsigurare callback =
    fieldset []
        [ legend [] [ text "DocumenteAplicareMasuriAsigurare" ]
        , Table.view
            { recordList = data documenteAplicareMasuriAsigurare
            , callback = callback << fromData
            , columns =
                [ ( "Denumire", (\r c -> unlabeledTextField r.denumire (\v -> c { r | denumire = v })) )
                , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
                , ( "Copia scanată", (\r c -> [ DocumentScanat.unlabeledView r.copiaScanata (\v -> c { r | copiaScanata = v }) ]) )
                ]
            , emptyView = text ""
            , empty = DocumentAplicareMasuriAsigurare.data DocumentAplicareMasuriAsigurare.empty
            }
        ]


data : DocumenteAplicareMasuriAsigurare -> List DocumentAplicareMasuriAsigurare.Data
data (DocumenteAplicareMasuriAsigurare list) =
    List.map DocumentAplicareMasuriAsigurare.data list


fromData : List DocumentAplicareMasuriAsigurare.Data -> DocumenteAplicareMasuriAsigurare
fromData =
    DocumenteAplicareMasuriAsigurare << List.map DocumentAplicareMasuriAsigurare
