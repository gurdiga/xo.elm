module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)
-- import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara)
-- import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)


type Model
    = Model
        ContractIpoteca.Model
        { contractCreditBancar : ContractCreditBancar

        -- , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara
        -- , notificare : DocumentScanat
        -- , preaviz : DocumentScanat
        -- , declaratieContractNonLitigios : DeclaratieContractNonLitigios
        }


initialModel : Model
initialModel =
    Model ContractIpoteca.empty
        { contractCreditBancar = ContractCreditBancar.empty

        -- , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.empty
        -- , notificare = DocumentScanat.empty
        -- , preaviz = DocumentScanat.empty
        -- , declaratieContractNonLitigios = DeclaratieContractNonLitigios.empty contractIpoteca
        }


type Msg
    = SetContractIpoteca ContractIpoteca.Msg
    | SetContractCreditBancar


update : Msg -> Model -> Model
update msg (Model contractIpoteca model) =
    case Debug.log "DocumenteContractIpoteca msg" msg of
        SetContractIpoteca contractIpotecaMsg ->
            Model (ContractIpoteca.update contractIpotecaMsg contractIpoteca) model

        SetContractCreditBancar ->
            Model contractIpoteca model


view : Model -> Html Msg
view (Model contractIpoteca model) =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , ContractIpoteca.view contractIpoteca |> map SetContractIpoteca

        -- , ContractCreditBancar.view
        --     documenteContractIpoteca.contractCreditBancar
        --     (\v -> callback (just contractIpoteca { documenteContractIpoteca | contractCreditBancar = v }))
        -- , ExtraseEvidentaFinanciara.view
        --     documenteContractIpoteca.extraseEvidentaFinanciara
        --     (\v -> callback (just contractIpoteca { documenteContractIpoteca | extraseEvidentaFinanciara = v }))
        -- , ul []
        --     [ li []
        --         [ DocumentScanat.view
        --             { labelText = "Notificare:"
        --             , documentScanat = documenteContractIpoteca.notificare
        --             , callback = \v -> callback (just contractIpoteca { documenteContractIpoteca | notificare = v })
        --             }
        --         ]
        --     , li []
        --         [ DocumentScanat.view
        --             { labelText = "Preaviz:"
        --             , documentScanat = documenteContractIpoteca.preaviz
        --             , callback = \v -> callback (just contractIpoteca { documenteContractIpoteca | preaviz = v })
        --             }
        --         ]
        --     ]
        -- , DeclaratieContractNonLitigios.view
        --     documenteContractIpoteca.declaratieContractNonLitigios
        --     (\v -> callback (just contractIpoteca { documenteContractIpoteca | declaratieContractNonLitigios = v }))
        ]
