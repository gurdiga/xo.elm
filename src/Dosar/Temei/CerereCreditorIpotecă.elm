module Dosar.Temei.CerereCreditorIpotecă exposing (CerereCreditorIpotecă, newValue, view)

import Html exposing (Html, fieldset, legend, label, text)
import Dosar.Temei.CerereCreditorIpotecă.ContractIpotecă as ContractIpotecă exposing (ContractIpotecă)
import Dosar.Temei.CerereCreditorIpotecă.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditorIpotecă.ExtraseEvidențăFinanciară as ExtraseEvidențăFinanciară exposing (ExtraseEvidențăFinanciară)
import Dosar.Temei.CerereCreditorIpotecă.DeclarațieContractNonLitigios as DeclarațieContractNonLitigios exposing (DeclarațieContractNonLitigios)
import DocumentScanat exposing (DocumentScanat)


type CerereCreditorIpotecă
    = CerereCreditorIpotecă
        -- originalul contractului de ipotecă învestit cu formulă executorie⁺
        ContractIpotecă
        { -- copia contractului de credit bancar sau de împrumut⁺
          contractCreditBancar : ContractCreditBancar
        , -- extrasele de evidenţă financiară⁺
          extraseEvidențăFinanciară : ExtraseEvidențăFinanciară
        , -- copiile notificării şi preavizului expediate pe adresa debitorului
          notificare : DocumentScanat
        , preaviz : DocumentScanat
        , -- declaraţia pe propria răspundere a creditorului că nu există un
          -- litigiu judiciar în legătură cu contractul dat de ipotecă
          declarație : DeclarațieContractNonLitigios ContractIpotecă
        }


newValue : ContractIpotecă -> CerereCreditorIpotecă
newValue contractIpotecă =
    CerereCreditorIpotecă contractIpotecă
        { contractCreditBancar = ContractCreditBancar.newValue
        , extraseEvidențăFinanciară = ExtraseEvidențăFinanciară.newValue
        , notificare = DocumentScanat.newValue
        , preaviz = DocumentScanat.newValue
        , declarație = DeclarațieContractNonLitigios.newValue contractIpotecă
        }


view : CerereCreditorIpotecă -> (CerereCreditorIpotecă -> msg) -> Html msg
view cerereCreditorIpotecă callback =
    fieldset []
        [ legend [] [ text "CerereCreditorIpotecă" ]
        , text "TODO: add fields"
        ]
