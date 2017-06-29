module Dosar.Temei.CerereCreditor.DocumenteContractIpotecă exposing (DocumenteContractIpotecă, newValue, view)

import Html exposing (Html, div, text)
import Dosar.Temei.CerereCreditor.ContractIpotecă as ContractIpotecă exposing (ContractIpotecă)
import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditor.ExtraseEvidențăFinanciară as ExtraseEvidențăFinanciară exposing (ExtraseEvidențăFinanciară)
import Dosar.Temei.CerereCreditor.DeclarațieContractNonLitigios as DeclarațieContractNonLitigios exposing (DeclarațieContractNonLitigios)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (checkboxField)


type DocumenteContractIpotecă
    = DocumenteContractIpotecă
        ContractIpotecă
        { contractCreditBancar : ContractCreditBancar
        , extraseEvidențăFinanciară : ExtraseEvidențăFinanciară
        , notificare : DocumentScanat
        , preaviz : DocumentScanat
        , declarațieContractNonLitigios : DeclarațieContractNonLitigios ContractIpotecă
        }


newValue : ContractIpotecă -> DocumenteContractIpotecă
newValue contractIpotecă =
    DocumenteContractIpotecă contractIpotecă
        { contractCreditBancar = ContractCreditBancar.newValue
        , extraseEvidențăFinanciară = ExtraseEvidențăFinanciară.newValue
        , notificare = DocumentScanat.newValue
        , preaviz = DocumentScanat.newValue
        , declarațieContractNonLitigios = DeclarațieContractNonLitigios.newValue contractIpotecă
        }


view : Maybe DocumenteContractIpotecă -> (Maybe DocumenteContractIpotecă -> msg) -> Html msg
view maybeDocumenteContractIpotecă callback =
    div []
        [ checkboxField "în temeiul contractului de ipotecă"
            (maybeToBool maybeDocumenteContractIpotecă)
            (\v -> callback (maybeFromBool v))
        , fields maybeDocumenteContractIpotecă callback
        ]


fields : Maybe DocumenteContractIpotecă -> (Maybe DocumenteContractIpotecă -> msg) -> Html msg
fields maybeDocumenteContractIpotecă callback =
    case maybeDocumenteContractIpotecă of
        Just (DocumenteContractIpotecă contractIpotecă documenteContractIpotecă) ->
            div []
                [ text "DocumenteContractIpotecă"
                , ContractIpotecă.view
                    contractIpotecă
                    (\v -> callback (Just (DocumenteContractIpotecă v documenteContractIpotecă)))
                ]

        Nothing ->
            text ""


maybeFromBool : Bool -> Maybe DocumenteContractIpotecă
maybeFromBool v =
    case v of
        True ->
            Just (newValue ContractIpotecă.newValue)

        False ->
            Nothing


maybeToBool : Maybe DocumenteContractIpotecă -> Bool
maybeToBool v =
    case v of
        Just _ ->
            True

        Nothing ->
            False
