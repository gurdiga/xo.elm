module Procedure exposing (Type, newValue)

import Procedure.Order as Order
import CourtDecision
import Procedure.Person as Person


type alias Type =
    { id : ID
    , grounds : Grounds
    , order : Order.Type
    }


type alias ID =
    String


type Grounds
    = CreditorPetition CreditorPetitionValue
    | CourtDecision CourtDecision.Type
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | Takeover TakeoverValue


newValue : Type
newValue =
    { id = "001"
    , grounds = CourtDecision CourtDecision.newValue
    , order = newOrder
    }


newOrder : Type
newOrder =
    { court = "The Court"
    , cause = OrderCause DebtCategory1 ChildSupportDebt
    , orderDate = Nothing
    , text = "You shall do this and that."
    , finalDate = Nothing
    , creditor = newPerson
    , debtors = [ newPerson ]
    , releaseDate = Nothing
    , warrants = [ newWarrant ]
    , addressForKeepingSeizedAssets = ""
    , notes = ""
    }


newCreditorPetitionValue : CreditorPetitionValue
newCreditorPetitionValue =
    { creditor = newPerson
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
