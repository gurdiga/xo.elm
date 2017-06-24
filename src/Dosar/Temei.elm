module Dosar.Temei exposing (..)

import Html exposing (Html, fieldset, legend, label, text)
import Select
import Dosar.Person as Person
import Dosar.DemersInstanță as DemersInstanță


type Temei
    = CreditorPetition CreditorPetitionValue
    | DemersInstanță DemersInstanță.Type
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | Takeover TakeoverValue


newValue : Temei
newValue =
    DemersInstanță DemersInstanță.newValue


type alias MortgageCreditorPetitionValue =
    { -- • originalul contractului de ipotecă învestit cu formulă executorie⁺
      mortgageContract : MortgageContractValue
    , -- • copia contractului de credit bancar sau de împrumut⁺
      creditAgreement : CreditAgreementValue
    , -- • extrasele de evidenţă financiară⁺
      financialRecords : FinancialRecordsValue
    , -- • copiile notificării şi preavizului expediate pe adresa debitorului
      notice : ScannedImageValue
    , intimation : ScannedImageValue
    , -- • declaraţia pe propria răspundere a creditorului că nu există un
      -- litigiu judiciar în legătură cu contractul dat de ipotecă
      -- (ăf′ĭ-dā′vĭt)
      affidavit : MortgageCreditorNoLitigationAffidavitValue
    }


view : Temei -> (Temei -> msg) -> Html msg
view temei callback =
    fieldset []
        [ legend [] [ text "Temei:" ]
        , dropdown temei callback
        , fields temei callback
        ]


dropdown : Temei -> (Temei -> msg) -> Html msg
dropdown defaultValue callback =
    Select.fromValuesWithLabels valuesWithLabels callback defaultValue


fields : Temei -> (Temei -> msg) -> Html msg
fields temei callback =
    case temei of
        CreditorPetition creditorPetition ->
            creditorPetitionFields creditorPetition

        MortgageCreditorPetition mortgageCreditorPetition ->
            mortgageCreditorPetitionFields mortgageCreditorPetition

        DemersInstanță decision ->
            DemersInstanță.view decision (\v -> callback (DemersInstanță v))

        Takeover takeover ->
            takeoverFields takeover


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CreditorPetition newCreditorPetitionValue
      , "cerere a creditorului"
      )
    , ( MortgageCreditorPetition newMortgageCreditorPetitionValue
      , "cerere a creditorului în temeiul contractului de ipotecă"
      )
    , ( DemersInstanță DemersInstanță.newValue
      , "demersul instanţei de judecată"
      )
    , ( Takeover {}
      , "preluarea unui document executoriu strămutat"
      )
    ]


newCreditorPetitionValue : CreditorPetitionValue
newCreditorPetitionValue =
    { creditor = Person.newValue
    , petition = newPetition
    }


creditorPetitionFields : CreditorPetitionValue -> Html msg
creditorPetitionFields creditorPetition =
    text <| "CreditorPetition" ++ (toString creditorPetition)


mortgageCreditorPetitionFields : MortgageCreditorPetitionValue -> Html msg
mortgageCreditorPetitionFields mortgageCreditorPetition =
    text <| "MortgageCreditorPetition" ++ (toString mortgageCreditorPetition)


takeoverFields : TakeoverValue -> Html msg
takeoverFields takeover =
    text <| "Takeover" ++ (toString takeover)


newMortgageCreditorPetitionValue : MortgageCreditorPetitionValue
newMortgageCreditorPetitionValue =
    { mortgageContract = newMortgageContractValue
    , creditAgreement = newCreditAgreementValue
    , financialRecords = newFinancialRecordsValue
    , notice = newScannedImageValue
    , intimation = newScannedImageValue
    , affidavit = newMortgageCreditorNoLitigationAffidavitValue
    }


type alias MortgageContractValue =
    {}


newMortgageContractValue : MortgageContractValue
newMortgageContractValue =
    {}


type alias CreditAgreementValue =
    {}


newCreditAgreementValue : CreditAgreementValue
newCreditAgreementValue =
    {}


type alias FinancialRecordsValue =
    {}


newFinancialRecordsValue : FinancialRecordsValue
newFinancialRecordsValue =
    {}


type alias ScannedImageValue =
    {}


newScannedImageValue : ScannedImageValue
newScannedImageValue =
    {}


type alias MortgageCreditorNoLitigationAffidavitValue =
    {}


newMortgageCreditorNoLitigationAffidavitValue : MortgageCreditorNoLitigationAffidavitValue
newMortgageCreditorNoLitigationAffidavitValue =
    {}


type Petition
    = Petition


newPetition : Petition
newPetition =
    Petition


type alias TakeoverValue =
    {}


type alias CreditorPetitionValue =
    { creditor : Person.Type
    , petition : Petition
    }
