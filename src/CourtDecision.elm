module CourtDecision exposing (Value, newValue, fields)

import Html exposing (Html, div, select, option, text)
import Select


type alias Value =
    { cause : CourtDecisionCause
    }


newValue : Value
newValue =
    { cause = AssetConfiscation newAssetConfiscationValue
    }


type
    -- (2) Instanţa de judecată prezintă din oficiu titlul executoriu spre
    -- executare în pricinile ce ţin:
    CourtDecisionCause
    = -- a) de confiscarea bunurilor;
      AssetConfiscation AssetConfiscationValue
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
      HealthDamagePaymentCollection
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


type alias AssetConfiscationValue =
    {}


courtDecisionCausesWithLabels : List ( CourtDecisionCause, String )
courtDecisionCausesWithLabels =
    [ ( AssetConfiscation newAssetConfiscationValue
      , "confiscarea bunurilor"
      )
    , ( MoneyCollectionForGovernment
      , "urmărirea sumelor ce urmează a fi făcute venit la stat"
      )
    , ( MoneyCollectionFromGovernment
      , """
        urmărirea sumelor încasate din contul statului, din contul
        întreprinderilor de stat şi al celor municipale, al societăţilor
        comerciale cu capital majoritar de stat
        """
      )
    , ( AlimonyCollection
      , "de urmărirea pensiei de întreţinere"
      )
    , ( HealthDamagePaymentCollection
      , """
        de încasarea sumelor pentru repararea prejudiciilor cauzate prin
        vătămarea integrităţii corporale, prin o altă vătămare a sănătăţii sau
        prin deces, dacă repararea s-a efectuat sub formă de prestaţii băneşti
        periodice
        """
      )
    , ( RightInfringementRepair
      , """
        de repararea prejudiciului cauzat prin încălcarea dreptului la
        judecarea în termen rezonabil a cauzei sau a dreptului la executarea în
        termen rezonabil a hotărîrii judecătoreşti;
        """
      )

    -- | -- e2) de repararea prejudiciului cauzat prin acţiunile ilicite ale
    --   -- organelor de urmărire penală, ale procuraturii şi ale instanţelor
    --   -- judecătoreşti;
    --   IllicitActionRepair
    -- | -- f) de restabilirea la locul de muncă şi de încasarea salariului mediu
    --   -- pentru întreaga perioadă de absenţă forţată de la muncă;
    --   JobRestoration
    -- | -- g) încasarea indemnizaţiilor pentru incapacitate temporară de muncă şi
    --   -- altor prestaţii de asigurări sociale prevăzute de lege;
    --   SocialInsuranceCompensation
    -- | -- h) de încasarea cheltuielilor pentru acordarea asistenţei juridice
    --   -- garantate de stat.
    --   LegalAssistancePaymentCollection
    ]


defaultCourtDecisionCause : CourtDecisionCause
defaultCourtDecisionCause =
    AssetConfiscation newAssetConfiscationValue


newAssetConfiscationValue : AssetConfiscationValue
newAssetConfiscationValue =
    {}


fields : Value -> msg -> Html msg
fields decision msg =
    div []
        [ text <| "CourtDecision" ++ (toString decision)
        , Select.fromValuesWithLabels
            courtDecisionCausesWithLabels
            (\courtDecisionCause -> msg)
            defaultCourtDecisionCause
        ]
