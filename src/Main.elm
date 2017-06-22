module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value, selected, style)
import Html.Events exposing (..)
import Date exposing (Date)
import CourtDecision
import Select


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
    , order : OrderValue
    }


type alias
    -- https://workflowy.com/#/07d4c20e89a4
    OrderValue
    =
    { -- • denumirea instanţei de judecată care l-a eliberat
      court : CourtValue
    , -- • pricina în a cărei bază a fost eliberat, categoria de creanță —
      -- https://workflowy.com/#/6e5a4774a675
      cause : OrderCause
    , -- • data pronunţării hotărîrii
      orderDate : Maybe Date
    , -- • dispozitivul (textual)
      text : String
    , -- • data rămînerii definitive a hotărîrii — https://workflowy.com/#/a3557fcba688
      finalDate : Maybe Date
    , -- • date despre debitor(i) și creditor — https://workflowy.com/#/62b772bb8008
      creditor : Person
    , debtors : List Person
    , -- • data eliberării titlului executoriu
      releaseDate : Maybe Date
    , -- • dacă sunt, documentele executorii eliberate de instanţa de judecată
      -- prin care s-a dispus aplicarea măsurilor de asigurare a acţiunii sau de
      -- asigurare a probelor, sau de anulare a lor¹
      -- • dacă sunt, menţiunea privind autorizarea pătrunderii forţate a
      -- executorului judecătoresc în încăperile aflate în posesia sau în
      -- proprietatea debitorului, inclusiv în cele în care se află bunurile
      -- debitorului
      -- • dacă sunt, copia scanată a documentelor menționate la punctul
      -- precedent
      warrants : List Warrant
    , -- • dacă e menționat, locul de păstrare [a bunurilor sechestrate] indicat
      -- de instanța de judecată — Articolul 27. (4¹)
      addressForKeepingSeizedAssets : String
    , notes : String
    }


newOrder : OrderValue
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


type alias CourtValue =
    String


type OrderCause
    = OrderCause DebtCategory Debt


type
    -- Articolul 145. Categoriile de creanţe
    -- (1) Se stabilesc 3 categorii de creanţe.
    -- (2) La categoria întîi de creanţe sînt atribuite creanţele privind:
    Debt
    = -- a) plata pensiei de întreţinere;
      ChildSupportDebt
    | -- b) plăţile ce decurg din raporturile de muncă;
      EmploymentRelatedDebt
    | -- c) reparaţia prejudiciilor cauzate prin schilodire sau prin o altă
      -- vătămare a sănătăţii, precum şi în legătură cu pierderea
      -- întreţinătorului;
      HealthDamageDebt
    | -- d) reparaţia prejudiciilor cauzate persoanelor fizice prin infracţiune
      -- sau contravenţie;
      PersonalDamageDebt
    | -- e) contribuţiile obligatorii de asigurări sociale de stat.
      SocialSecurityDebt
      -- (3) La categoria a doua de creanţe sînt atribuite creanţele privind:
    | -- a) impozitele, taxele şi alte plăţi aferente bugetului public naţional;
      TaxDebt
    | -- b) taxele de stat, amenzile şi penalităţile aferente bugetului public
      -- naţional;
      PenaltiesDebt
    | -- c) reparaţia prejudiciilor cauzate prin infracţiune sau contravenţie
      -- persoanelor juridice, precum şi asociaţiilor şi societăţilor care nu au
      -- personalitate juridică, dar care dispun de organe de conducere proprii;
      CorporationDamageDebt
    | -- d) plăţile pentru drepturile de autor şi drepturile conexe;
      CopyrightPenaltiesDebt
    | -- e) cheltuielile de asistenţă juridică.
      JudicialAssistanceDebt
    | -- (4) La categoria a treia de creanţe sînt atribuite celelalte creanţe.
      OtherDebt


type DebtCategory
    = DebtCategory1
    | DebtCategory2
    | DebtCategory3


type Warrant
    = Warrant -- Fields + Maybe ScannedImageValue


newWarrant : Warrant
newWarrant =
    Warrant


type alias ID =
    String


type Grounds
    = CreditorPetition CreditorPetitionValue
    | CourtDecision CourtDecision.Value -- public policy, public interest
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
    , openedProcess = Just newProcess
    }


newProcess : Process
newProcess =
    { id = "001"
    , grounds = CourtDecision CourtDecision.newValue
    , order = newOrder
    }



-- UPDATE


type Msg
    = None
    | ChangeGrounds Grounds
    | ChangeCourtDecision CourtDecision.Msg


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
    let
        currentGrounds =
            case model.openedProcess of
                Nothing ->
                    CourtDecision CourtDecision.newValue

                Just process ->
                    process.grounds
    in
        div []
            [ h1 [] [ text "Procedură nouă" ]
            , label []
                [ text "Temeiul:"
                , Select.fromValuesWithLabels groundsWithLabels ChangeGrounds currentGrounds
                , groundsFields currentGrounds
                ]
            , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
            ]


groundsFields : Grounds -> Html Msg
groundsFields grounds =
    case grounds of
        CourtDecision decision ->
            CourtDecision.fields decision ChangeCourtDecision

        CreditorPetition creditorPetition ->
            creditorPetitionFields creditorPetition

        MortgageCreditorPetition mortgageCreditorPetition ->
            mortgageCreditorPetitionFields mortgageCreditorPetition

        Takeover takeover ->
            takeoverFields takeover


creditorPetitionFields : CreditorPetitionValue -> Html Msg
creditorPetitionFields creditorPetition =
    div [] [ text <| "CreditorPetition" ++ (toString creditorPetition) ]


mortgageCreditorPetitionFields : MortgageCreditorPetitionValue -> Html Msg
mortgageCreditorPetitionFields mortgageCreditorPetition =
    div [] [ text <| "MortgageCreditorPetition" ++ (toString mortgageCreditorPetition) ]


takeoverFields : TakeoverValue -> Html Msg
takeoverFields takeover =
    div [] [ text <| "Takeover" ++ (toString takeover) ]


groundsWithLabels : List ( Grounds, String )
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



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
