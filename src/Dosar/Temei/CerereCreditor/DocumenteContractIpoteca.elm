module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara
import Html.Styled exposing (Html, fieldset, legend, li, map, pre, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea


type Model
    = Model
        ContractIpoteca.Model
        { contractCreditBancar : ContractCreditBancar.Model
        , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara.Model
        , notificare : DocumentScanatTea.Model
        , preaviz : DocumentScanatTea.Model

        -- , declaratieContractNonLitigios : DeclaratieContractNonLitigios
        }


initialModel : Model
initialModel =
    Model ContractIpoteca.empty
        { contractCreditBancar = ContractCreditBancar.initialModel
        , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.initialModel
        , notificare = DocumentScanatTea.initialModel
        , preaviz = DocumentScanatTea.initialModel

        -- , declaratieContractNonLitigios = DeclaratieContractNonLitigios.empty contractIpoteca
        }


type Msg
    = SetContractIpoteca ContractIpoteca.Msg
    | SetContractCreditBancar ContractCreditBancar.Msg
    | SetExtraseEvidentaFinanciara ExtraseEvidentaFinanciara.Msg
    | SetNotificare DocumentScanatTea.Msg
    | SetPreaviz DocumentScanatTea.Msg


update : Msg -> Model -> Model
update msg (Model contractIpoteca model) =
    case msg of
        SetContractIpoteca contractIpotecaMsg ->
            Model (ContractIpoteca.update contractIpotecaMsg contractIpoteca) model

        SetContractCreditBancar contractCreditBancarMsg ->
            Model contractIpoteca { model | contractCreditBancar = ContractCreditBancar.update contractCreditBancarMsg model.contractCreditBancar }

        SetExtraseEvidentaFinanciara extraseEvidentaFinanciaraMsg ->
            Model contractIpoteca { model | extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.update extraseEvidentaFinanciaraMsg model.extraseEvidentaFinanciara }

        SetNotificare documentScanatTeaMsg ->
            Model contractIpoteca { model | notificare = DocumentScanatTea.update documentScanatTeaMsg model.notificare }

        SetPreaviz documentScanatTeaMsg ->
            Model contractIpoteca { model | preaviz = DocumentScanatTea.update documentScanatTeaMsg model.preaviz }


view : Model -> Html Msg
view (Model contractIpoteca model) =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , ContractIpoteca.view contractIpoteca |> map SetContractIpoteca
        , ContractCreditBancar.view model.contractCreditBancar |> map SetContractCreditBancar
        , ExtraseEvidentaFinanciara.view model.extraseEvidentaFinanciara |> map SetExtraseEvidentaFinanciara
        , DocumentScanatTea.view { labelText = "Notificare:", documentScanat = model.notificare } |> map SetNotificare
        , DocumentScanatTea.view { labelText = "Preaviz:", documentScanat = model.preaviz } |> map SetPreaviz

        -- TODO: continue here
        --
        -- , DeclaratieContractNonLitigios.view
        --     documenteContractIpoteca.declaratieContractNonLitigios
        --     (\v -> callback (just contractIpoteca { documenteContractIpoteca | declaratieContractNonLitigios = v }))
        ]
