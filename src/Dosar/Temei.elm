module Dosar.Temei exposing (..)

import Html exposing (Html, fieldset, legend, label, text)
import Select
import Dosar.Person as Person
import CourtDecision


type Temei
    = CreditorPetition CreditorPetitionValue
    | CourtDecision CourtDecision.Type
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | Takeover TakeoverValue


newValue : Temei
newValue =
    CourtDecision CourtDecision.newValue


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
view temei msgConstructor =
    fieldset []
        [ legend [] [ text "Temeiul:" ]
        , Select.fromValuesWithLabels labels msgConstructor temei
        , fields temei
        ]


fields : Temei -> Html msg
fields temei =
    case temei of
        CourtDecision decision ->
            text "CourtDecision.fields decision ChangeCourtDecision"

        CreditorPetition creditorPetition ->
            creditorPetitionFields creditorPetition

        MortgageCreditorPetition mortgageCreditorPetition ->
            mortgageCreditorPetitionFields mortgageCreditorPetition

        Takeover takeover ->
            takeoverFields takeover


labels : List ( Temei, String )
labels =
    [ ( CreditorPetition newCreditorPetitionValue
      , "cerere a creditorului"
      )
    , ( MortgageCreditorPetition newMortgageCreditorPetitionValue
      , "cerere a creditorului în temeiul contractului de ipotecă"
      )
    , ( CourtDecision CourtDecision.newValue
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
