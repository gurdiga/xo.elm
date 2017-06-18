module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { processes : List Process
    , openedProcess : Maybe Process
    }


type alias Process =
    { id : ID
    , grounds : Grounds
    }


type alias ID =
    String


type Grounds
    = CourtDecision CourtDecisionValue -- public policy, public interest
    | CreditorPetition CreditorPetitionValue
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | Takeover TakeoverValue


type alias CreditorPetitionValue =
    { creditor : Person
    , petition : Petition
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


type Person
    = Person


newPerson : Person
newPerson =
    Person


type Petition
    = Petition


newPetition : Petition
newPetition =
    Petition


type alias CourtDecisionValue =
    { cause : Cause
    }


newCourtDecisionValue : CourtDecisionValue
newCourtDecisionValue =
    { cause = AssetConfiscation
    }


type
    -- (2) Instanţa de judecată prezintă din oficiu titlul executoriu spre
    -- executare în pricinile ce ţin:
    Cause
    = -- a) de confiscarea bunurilor;
      AssetConfiscation
    | -- b) de urmărirea sumelor ce urmează a fi făcute venit la stat;
      MoneyCollectionForGovernment
    | -- c) urmărirea sumelor încasate din contul statului, din contul
      -- întreprinderilor de stat şi al celor municipale, al societăţilor
      -- comerciale cu capital majoritar de stat;
      MoneyCollectionFromGovernment
    | -- d) de urmărirea pensiei de întreţinere;
      AlimonyCollection
    | -- e) de încasarea sumelor pentru repararea prejudiciilor cauzate prin
      -- vătămarea integrităţii corporale, prin o altă vătămare a sănătăţii sau
      -- prin deces, dacă repararea s-a efectuat sub formă de prestaţii băneşti
      -- periodice;
      DamagePaymentCollection
    | -- e1) de repararea prejudiciului cauzat prin încălcarea dreptului la
      -- judecarea în termen rezonabil a cauzei sau a dreptului la executarea în
      -- termen rezonabil a hotărîrii judecătoreşti;
      RightInfringementRepair
    | -- e2) de repararea prejudiciului cauzat prin acţiunile ilicite ale
      -- organelor de urmărire penală, ale procuraturii şi ale instanţelor
      -- judecătoreşti;
      IllicitActionRepair
    | -- f) de restabilirea la locul de muncă şi de încasarea salariului mediu
      -- pentru întreaga perioadă de absenţă forţată de la muncă;
      JobRestoration
    | -- g) încasarea indemnizaţiilor pentru incapacitate temporară de muncă şi
      -- altor prestaţii de asigurări sociale prevăzute de lege;
      SocialInsuranceCompensation
    | -- h) de încasarea cheltuielilor pentru acordarea asistenţei juridice
      -- garantate de stat.
      LegalAssistancePaymentCollection


type alias TakeoverValue =
    {}


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { processes = []
    , openedProcess =
        Just (updatedProcess newProcess)
    }


newProcess : Process
newProcess =
    { id = "001"
    , grounds = Takeover {}
    }


updatedProcess : Process -> Process
updatedProcess ({ id, grounds } as process) =
    { process | id = id ++ "-updated" }



-- UPDATE


type Msg
    = None
    | ChangeGrounds Grounds


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeGrounds newGrounds ->
            let
                newOpenedProcess =
                    Maybe.map (\openedProcess -> { openedProcess | grounds = newGrounds }) model.openedProcess
            in
                ( { model | openedProcess = newOpenedProcess }, Cmd.none )

        None ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Procedură nouă" ]
        , label []
            [ text "Temeiul:"
            , select [ onInput (\v -> ChangeGrounds (groundsFromString v)) ]
                [ option [ value "a" ] [ text "cerere a creditorului" ]
                , option [ value "b" ] [ text "cerere a creditorului în temeiul contractului de ipotecă" ]
                , option [ value "c" ] [ text "demersul instanţei de judecată" ]
                , option [ value "d" ] [ text "preluarea unui document executoriu strămutat" ]
                ]
            ]
        , pre [] [ text (toString model) ]
        ]


groundsFromString : String -> Grounds
groundsFromString s =
    if s == "a" then
        CreditorPetition newCreditorPetitionValue
    else if s == "b" then
        MortgageCreditorPetition newMortgageCreditorPetitionValue
    else if s == "c" then
        CourtDecision newCourtDecisionValue
    else
        Takeover {}



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
