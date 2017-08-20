module Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios, empty, view)

import Html exposing (Html, fieldset, legend, p, text)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca exposing (ContractIpoteca)


type DeclaratieContractNonLitigios
    = DeclaratieContractNonLitigios ContractIpoteca


empty : ContractIpoteca -> DeclaratieContractNonLitigios
empty contractIpoteca =
    DeclaratieContractNonLitigios contractIpoteca


view : DeclaratieContractNonLitigios -> (DeclaratieContractNonLitigios -> msg) -> Html msg
view declaratieContractNonLitigios callback =
    fieldset []
        [ legend [] [ text "DeclaratieContractNonLitigios" ]
        , p [] [ text "TODO: probably open an pre-filled editable template" ]
        , text (toString declaratieContractNonLitigios)
        ]
