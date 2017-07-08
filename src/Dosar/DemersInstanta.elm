module Dosar.DemersInstanta exposing (DemersInstanta, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, text)
import Dosar.DemersInstanta.Pricina as Pricina exposing (Pricina)
import DocumentScanat exposing (DocumentScanat)


type alias DemersInstanta =
    { pricina : Pricina
    , copia : DocumentScanat
    }


newValue : DemersInstanta
newValue =
    { pricina = Pricina.newValue
    , copia = DocumentScanat.newValue
    }


view : DemersInstanta -> (DemersInstanta -> msg) -> Html msg
view decision callback =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li [] [ Pricina.view decision.pricina (\v -> callback { decision | pricina = v }) ]
            , li [] [ DocumentScanat.view "Copia scanată:" decision.copia (\v -> callback { decision | copia = v }) ]
            ]
        ]
