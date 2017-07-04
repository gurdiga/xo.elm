module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (DocumenteContractIpoteca, newValue, view)

import Html exposing (Html, fieldset, legend, div, text)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca exposing (ContractIpoteca)
import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara)
import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (checkboxField)


type DocumenteContractIpoteca
    = DocumenteContractIpoteca
        ContractIpoteca
        { contractCreditBancar : ContractCreditBancar
        , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara
        , notificare : DocumentScanat
        , preaviz : DocumentScanat
        , declaratieContractNonLitigios : DeclaratieContractNonLitigios ContractIpoteca
        }


newValue : ContractIpoteca -> DocumenteContractIpoteca
newValue contractIpoteca =
    DocumenteContractIpoteca contractIpoteca
        { contractCreditBancar = ContractCreditBancar.newValue
        , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.newValue
        , notificare = DocumentScanat.newValue
        , preaviz = DocumentScanat.newValue
        , declaratieContractNonLitigios = DeclaratieContractNonLitigios.newValue contractIpoteca
        }


view : Maybe DocumenteContractIpoteca -> (Maybe DocumenteContractIpoteca -> msg) -> Html msg
view maybeDocumenteContractIpoteca callback =
    div []
        [ checkboxField "in temeiul contractului de ipoteca"
            (maybeToBool maybeDocumenteContractIpoteca)
            (\v -> callback (maybeFromBool v))
        , fields maybeDocumenteContractIpoteca callback
        ]


fields : Maybe DocumenteContractIpoteca -> (Maybe DocumenteContractIpoteca -> msg) -> Html msg
fields maybeDocumenteContractIpoteca callback =
    case maybeDocumenteContractIpoteca of
        Just (DocumenteContractIpoteca contractIpoteca documenteContractIpoteca) ->
            let
                just c d =
                    Just (DocumenteContractIpoteca c d)
            in
                fieldset []
                    [ legend [] [ text "DocumenteContractIpoteca" ]
                    , ContractIpoteca.view
                        contractIpoteca
                        (\v -> callback (just v documenteContractIpoteca))
                    , ContractCreditBancar.view
                        documenteContractIpoteca.contractCreditBancar
                        (\v -> callback (just contractIpoteca { documenteContractIpoteca | contractCreditBancar = v }))
                    , ExtraseEvidentaFinanciara.view
                        documenteContractIpoteca.extraseEvidentaFinanciara
                        (\v -> callback (just contractIpoteca { documenteContractIpoteca | extraseEvidentaFinanciara = v }))
                    ]

        Nothing ->
            text ""


maybeFromBool : Bool -> Maybe DocumenteContractIpoteca
maybeFromBool v =
    case v of
        True ->
            Just (newValue ContractIpoteca.newValue)

        False ->
            Nothing


maybeToBool : Maybe DocumenteContractIpoteca -> Bool
maybeToBool v =
    case v of
        Just _ ->
            True

        Nothing ->
            False
