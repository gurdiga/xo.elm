module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara
import Html exposing (Html, fieldset, legend, li, map, pre, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3


type alias Model =
    { contractIpoteca : ContractIpoteca.Model
    , contractCreditBancar : ContractCreditBancar.Model
    , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara.Model
    , notificare : DocumentScanat3.Model
    , preaviz : DocumentScanat3.Model
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
    , notificare = DocumentScanat3.initialModel
    , preaviz = DocumentScanat3.initialModel
    , declaratieContractNonLitigios = DeclaratieContractNonLitigios.initialModel contractIpoteca
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumenteContractIpoteca" ]
        , ContractIpoteca.view model.contractIpoteca |> map SetContractIpoteca
        , ContractCreditBancar.view model.contractCreditBancar |> map SetContractCreditBancar
        , ExtraseEvidentaFinanciara.view model.extraseEvidentaFinanciara |> map SetExtraseEvidentaFinanciara
        , DocumentScanat3.view "Notificare:" SetNotificare
        , DocumentScanat3.view "Preaviz:" SetPreaviz
        , DeclaratieContractNonLitigios.view model.declaratieContractNonLitigios |> map SetDeclaratieContractNonLitigios
        ]


type Msg
    = SetContractIpoteca ContractIpoteca.Msg
    | SetContractCreditBancar ContractCreditBancar.Msg
    | SetExtraseEvidentaFinanciara ExtraseEvidentaFinanciara.Msg
    | SetNotificare DocumentScanat3.Model
    | SetPreaviz DocumentScanat3.Model
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

        SetNotificare v ->
            { model | notificare = v }

        SetPreaviz v ->
            { model | preaviz = v }

        SetDeclaratieContractNonLitigios declaratieContractNonLitigiosMsg ->
            { model | declaratieContractNonLitigios = DeclaratieContractNonLitigios.update declaratieContractNonLitigiosMsg model.declaratieContractNonLitigios }
