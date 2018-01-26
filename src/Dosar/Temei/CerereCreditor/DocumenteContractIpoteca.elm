module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)
-- import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara
import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)


type Model
    = Model
        ContractIpoteca.Model
        { contractCreditBancar : ContractCreditBancar.Model
        , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara.Model

        -- , notificare : DocumentScanat
        -- , preaviz : DocumentScanat
        -- , declaratieContractNonLitigios : DeclaratieContractNonLitigios
        }


initialModel : Model
initialModel =
    Model ContractIpoteca.empty
        { contractCreditBancar = ContractCreditBancar.initialModel
        , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.initialModel

        -- , notificare = DocumentScanat.empty
        -- , preaviz = DocumentScanat.empty
        -- , declaratieContractNonLitigios = DeclaratieContractNonLitigios.empty contractIpoteca
        }


type Msg
    = SetContractIpoteca ContractIpoteca.Msg
    | SetContractCreditBancar ContractCreditBancar.Msg
    | SetExtraseEvidentaFinanciara ExtraseEvidentaFinanciara.Msg


update : Msg -> Model -> Model
update msg (Model contractIpoteca model) =
    case msg of
        SetContractIpoteca contractIpotecaMsg ->
            Model (ContractIpoteca.update contractIpotecaMsg contractIpoteca) model

        SetContractCreditBancar contractCreditBancarMsg ->
            Model contractIpoteca { model | contractCreditBancar = ContractCreditBancar.update contractCreditBancarMsg model.contractCreditBancar }

        SetExtraseEvidentaFinanciara msg ->
            Model contractIpoteca { model | extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.update msg model.extraseEvidentaFinanciara }


view : Model -> Html Msg
view (Model contractIpoteca model) =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , ContractIpoteca.view contractIpoteca |> map SetContractIpoteca
        , ContractCreditBancar.view model.contractCreditBancar |> map SetContractCreditBancar
        , ExtraseEvidentaFinanciara.view model.extraseEvidentaFinanciara |> map SetExtraseEvidentaFinanciara

        -- TODO: continue here
        --
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
