module Dosar.Temei.DemersInstanta exposing (DemersInstanta, empty, view)

import Html exposing (Html, fieldset, legend, ul, li, text)
import Dosar.DemersInstanta.Pricina as Pricina exposing (Pricina)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)


type alias DemersInstanta =
    { pricina : Pricina
    , copia : DocumentScanat
    }


empty : DemersInstanta
empty =
    { pricina = Pricina.empty
    , copia = DocumentScanat.empty
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
