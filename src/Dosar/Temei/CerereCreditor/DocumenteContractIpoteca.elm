module Dosar.Temei.CerereCreditor.DocumenteContractIpoteca exposing (DocumenteContractIpoteca, empty, view)

import Html exposing (Html, fieldset, legend, div, ul, li, text)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca exposing (ContractIpoteca)
import Dosar.Temei.CerereCreditor.ContractCreditBancar as ContractCreditBancar exposing (ContractCreditBancar)
import Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara as ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara)
import Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios as DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (checkboxField)


type DocumenteContractIpoteca
    = DocumenteContractIpoteca
        ContractIpoteca
        { contractCreditBancar : ContractCreditBancar
        , extraseEvidentaFinanciara : ExtraseEvidentaFinanciara
        , notificare : DocumentScanat
        , preaviz : DocumentScanat
        , declaratieContractNonLitigios : DeclaratieContractNonLitigios
        }


empty : ContractIpoteca -> DocumenteContractIpoteca
empty contractIpoteca =
    DocumenteContractIpoteca contractIpoteca
        { contractCreditBancar = ContractCreditBancar.empty
        , extraseEvidentaFinanciara = ExtraseEvidentaFinanciara.empty
        , notificare = DocumentScanat.empty
        , preaviz = DocumentScanat.empty
        , declaratieContractNonLitigios = DeclaratieContractNonLitigios.empty contractIpoteca
        }


view : Maybe DocumenteContractIpoteca -> (Maybe DocumenteContractIpoteca -> msg) -> Html msg
view maybeDocumenteContractIpoteca callback =
    div []
        [ checkboxField "in temeiul contractului de ipoteca"
            (maybeToBool maybeDocumenteContractIpoteca)
            (\v -> callback (boolToMaybe v))
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
                    , ul []
                        [ li []
                            [ DocumentScanat.view
                                { labelText = "Notificare:"
                                , documentScanat = documenteContractIpoteca.notificare
                                , callback = (\v -> callback (just contractIpoteca { documenteContractIpoteca | notificare = v }))
                                }
                            ]
                        , li []
                            [ DocumentScanat.view
                                { labelText = "Preaviz:"
                                , documentScanat = documenteContractIpoteca.preaviz
                                , callback = (\v -> callback (just contractIpoteca { documenteContractIpoteca | preaviz = v }))
                                }
                            ]
                        ]
                    , DeclaratieContractNonLitigios.view
                        documenteContractIpoteca.declaratieContractNonLitigios
                        (\v -> callback (just contractIpoteca { documenteContractIpoteca | declaratieContractNonLitigios = v }))
                    ]

        Nothing ->
            text ""


boolToMaybe : Bool -> Maybe DocumenteContractIpoteca
boolToMaybe v =
    case v of
        True ->
            Just (empty ContractIpoteca.empty)

        False ->
            Nothing


maybeToBool : Maybe DocumenteContractIpoteca -> Bool
maybeToBool v =
    case v of
        Just _ ->
            True

        Nothing ->
            False
