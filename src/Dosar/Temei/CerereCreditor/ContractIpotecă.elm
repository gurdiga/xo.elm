module Dosar.Temei.CerereCreditor.ContractIpotecă exposing (ContractIpotecă, newValue, view)

import Html exposing (Html, fieldset, legend, text)


type alias ContractIpotecă =
    {}


newValue : ContractIpotecă
newValue =
    {}


view : ContractIpotecă -> (ContractIpotecă -> msg) -> Html msg
view contractIpotecă callback =
    fieldset []
        [ legend [] [ text "ContractIpotecă" ]
        , text (toString contractIpotecă)
        ]
