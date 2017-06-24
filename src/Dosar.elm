module Dosar exposing (Dosar, newValue, view)

import Html exposing (Html, h1, div, pre, label, text)
import Html.Attributes exposing (style)
import Dosar.Order as Order
import CourtDecision
import Dosar.Person as Person
import Dosar.Cause as Cause
import Warrant
import Select


type alias Dosar =
    { id : ID
    , temei : Temei
    , order : Order.Type
    }


type alias ID =
    String


type Temei
    = CreditorPetition CreditorPetitionValue
    | CourtDecision CourtDecision.Type
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | Takeover TakeoverValue


newValue : Dosar
newValue =
    { id = "001"
    , temei = CourtDecision CourtDecision.newValue
    , order = Order.newValue
    }


newCreditorPetitionValue : CreditorPetitionValue
newCreditorPetitionValue =
    { creditor = Person.newValue
    , petition = newPetition
    }


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


type Msg
    = ChangeCourtDecision CourtDecision.Type


view : Dosar -> (Dosar -> msg) -> Html msg
view procedure msgConstructor =
    div []
        [ h1 [] [ text "Dosar nou" ]
        , label []
            [ text "Temeiul:"
            , Select.fromValuesWithLabels groundsWithLabels
                (\newTemei -> msgConstructor { procedure | temei = newTemei })
                procedure.temei
            , groundsFields procedure.temei
            ]
        ]


groundsFields : Temei -> Html msg
groundsFields temei =
    case temei of
        CourtDecision decision ->
            text "CourtDecision.fields decision ChangeCourtDecision"

        CreditorPetition creditorPetition ->
            creditorPetitionFields creditorPetition

        MortgageCreditorPetition mortgageCreditorPetition ->
            mortgageCreditorPetitionFields mortgageCreditorPetition

        Takeover takeover ->
            takeoverFields takeover


creditorPetitionFields : CreditorPetitionValue -> Html msg
creditorPetitionFields creditorPetition =
    text <| "CreditorPetition" ++ (toString creditorPetition)


mortgageCreditorPetitionFields : MortgageCreditorPetitionValue -> Html msg
mortgageCreditorPetitionFields mortgageCreditorPetition =
    text <| "MortgageCreditorPetition" ++ (toString mortgageCreditorPetition)


takeoverFields : TakeoverValue -> Html msg
takeoverFields takeover =
    text <| "Takeover" ++ (toString takeover)


groundsWithLabels : List ( Temei, String )
groundsWithLabels =
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
