module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)
-- import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara)
-- import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca exposing (ContractIpoteca)
import Html.Styled exposing (Html, fieldset, legend, li, pre, text, ul)


type Model
    = Model
        ContractIpoteca
        { contractCreditBancar : ContractCreditBancar

        -- , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara
        -- , notificare : DocumentScanat
        -- , preaviz : DocumentScanat
        -- , declaratieContractNonLitigios : DeclaratieContractNonLitigios
        }


initialModel : ContractIpoteca -> Model
initialModel contractIpoteca =
    Model contractIpoteca
        { contractCreditBancar = ContractCreditBancar.empty

        -- , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.empty
        -- , notificare = DocumentScanat.empty
        -- , preaviz = DocumentScanat.empty
        -- , declaratieContractNonLitigios = DeclaratieContractNonLitigios.empty contractIpoteca
        }


type Msg
    = SetContractCreditBancar


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetContractCreditBancar ->
            model


view : Model -> Html Msg
view (Model contractIpoteca model) =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , pre [] [ model |> toString |> text ]

        -- , ContractIpoteca.view
        --     contractIpoteca
        --     (\v -> callback (just v documenteContractIpoteca))
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
