module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara
import Html exposing (Html, fieldset, legend, li, map, pre, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea


type alias Model =
    { contractIpoteca : ContractIpoteca.Model
    , contractCreditBancar : ContractCreditBancar.Model
    , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara.Model
    , notificare : DocumentScanatTea.Model
    , preaviz : DocumentScanatTea.Model
    , declaratieContractNonLitigios : DeclaratieContractNonLitigios.Model
    }


initialModel : Model
initialModel =
    let
        contractIpoteca =
            ContractIpoteca.empty
    in
    { contractIpoteca = contractIpoteca
    , contractCreditBancar = ContractCreditBancar.initialModel
    , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.initialModel
    , notificare = DocumentScanatTea.initialModel
    , preaviz = DocumentScanatTea.initialModel
    , declaratieContractNonLitigios = DeclaratieContractNonLitigios.initialModel contractIpoteca
    }


type Msg
    = SetContractIpoteca ContractIpoteca.Msg
    | SetContractCreditBancar ContractCreditBancar.Msg
    | SetExtraseEvidentaFinanciara ExtraseEvidentaFinanciara.Msg
    | SetNotificare DocumentScanatTea.Msg
    | SetPreaviz DocumentScanatTea.Msg
    | SetDeclaratieContractNonLitigios DeclaratieContractNonLitigios.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetContractIpoteca contractIpotecaMsg ->
            { model | contractIpoteca = ContractIpoteca.update contractIpotecaMsg model.contractIpoteca }

        SetContractCreditBancar contractCreditBancarMsg ->
            { model | contractCreditBancar = ContractCreditBancar.update contractCreditBancarMsg model.contractCreditBancar }

        SetExtraseEvidentaFinanciara extraseEvidentaFinanciaraMsg ->
            { model | extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.update extraseEvidentaFinanciaraMsg model.extraseEvidentaFinanciara }

        SetNotificare documentScanatTeaMsg ->
            { model | notificare = DocumentScanatTea.update documentScanatTeaMsg model.notificare }

        SetPreaviz documentScanatTeaMsg ->
            { model | preaviz = DocumentScanatTea.update documentScanatTeaMsg model.preaviz }

        SetDeclaratieContractNonLitigios declaratieContractNonLitigiosMsg ->
            { model | declaratieContractNonLitigios = DeclaratieContractNonLitigios.update declaratieContractNonLitigiosMsg model.declaratieContractNonLitigios }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , ContractIpoteca.view model.contractIpoteca |> map SetContractIpoteca
        , ContractCreditBancar.view model.contractCreditBancar |> map SetContractCreditBancar
        , ExtraseEvidentaFinanciara.view model.extraseEvidentaFinanciara |> map SetExtraseEvidentaFinanciara
        , DocumentScanatTea.view { labelText = "Notificare:", documentScanat = model.notificare } |> map SetNotificare
        , DocumentScanatTea.view { labelText = "Preaviz:", documentScanat = model.preaviz } |> map SetPreaviz
        , DeclaratieContractNonLitigios.view model.declaratieContractNonLitigios |> map SetDeclaratieContractNonLitigios
        ]
