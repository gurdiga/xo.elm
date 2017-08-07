module Dosar.Temei.DemersInstanta exposing (DemersInstanta, newValue, view)

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
view demersInstanta callback =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li [] [ Pricina.view demersInstanta.pricina (\v -> callback { demersInstanta | pricina = v }) ]
            , li []
                [ DocumentScanat.view
                    { labelText = "Copia scanată:"
                    , documentScanat = demersInstanta.copia
                    , callback = (\v -> callback { demersInstanta | copia = v })
                    }
                ]
            ]
        ]
