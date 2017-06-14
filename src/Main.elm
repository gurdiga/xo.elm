module Main exposing (..)

import Html exposing (..)
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
    { folders : List Folder
    , openedFolder : Maybe Folder
    }


type alias Folder =
    { id : ID
    , grounds : Grounds
    }


type alias ID =
    String


type Grounds
    = CreditorPetition CreditorPetitionValue
    | MortgageCreditorPetition MortgageCreditorPetitionValue
    | CourtRequest CourtRequestValue
    | Takeover TakeoverValue


type alias CreditorPetitionValue =
    { creditor : Person
    , petition : Petition
    }


type alias MortgageCreditorPetitionValue =
    { -- • originalul contractului de ipotecă învestit cu formulă executorie⁺
      mortgageContract : MortgageContract MortgageContractValue
    , -- • copia contractului de credit bancar sau de împrumut⁺
      creditAgreement : CreditAgreement CreditAgreementValue
    , -- • extrasele de evidenţă financiară⁺
      financialRecords : FinancialRecords FinancialRecordsValue
    , -- • copiile notificării şi preavizului expediate pe adresa debitorului
      notice : ScannedImage
    , intimation : ScannedImage
    , -- • declaraţia pe propria răspundere a creditorului că nu există un
      -- litigiu judiciar în legătură cu contractul dat de ipotecă
      -- (ăf′ĭ-dā′vĭt)
      affidavit : MortgageCreditorNoLitigationAffidavit
    }


type Person
    = Person


type Petition
    = Petition


type alias CourtRequestValue =
    { cause : Cause
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
    { folders = []
    , openedFolder =
        Just (updatedFolder newFolder)
    }


newFolder : Folder
newFolder =
    { id = "001"
    , grounds = Takeover {}
    }


updatedFolder : Folder -> Folder
updatedFolder ({ id, grounds } as folder) =
    { folder | id = id ++ "-updated" }



-- UPDATE


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello World!" ]
        , pre [] [ text (toString model) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
