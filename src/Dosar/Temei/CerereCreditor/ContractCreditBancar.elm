module Dosar.Temei.CerereCreditor.ContractCreditBancar exposing (ContractCreditBancar, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, text)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (largeTextField)


type alias ContractCreditBancar =
    { copia : DocumentScanat
    , note : String
    }


newValue : ContractCreditBancar
newValue =
    { copia = DocumentScanat.newValue
    , note = ""
    }


view : ContractCreditBancar -> (ContractCreditBancar -> msg) -> Html msg
view contractCreditBancar callback =
    fieldset []
        [ legend [] [ text "ContractCreditBancar" ]
        , ul []
            [ li []
                [ DocumentScanat.view
                    { labelText = "Copia:"
                    , documentScanat = contractCreditBancar.copia
                    , callback = (\v -> callback { contractCreditBancar | copia = v })
                    }
                ]
            , li [] [ largeTextField "Note:" contractCreditBancar.note (\v -> callback { contractCreditBancar | note = v }) ]
            ]
        ]
