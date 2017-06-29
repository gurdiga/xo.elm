module Dosar.DemersInstanță.Cause exposing (Type, Msg, newValue, field)

import Html exposing (Html, label, text)
import Widgets.Select as Select


type Msg
    = Change


type
    -- (2) Instanţa de judecată prezintă din oficiu titlul executoriu spre
    -- executare în pricinile ce ţin:
    Type
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


valuesWithLabels : List ( Type, String )
valuesWithLabels =
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
      , "urmărirea pensiei de întreţinere"
      )
    , ( HealthDamagePaymentCollection
      , """
        încasarea sumelor pentru repararea prejudiciilor cauzate prin
        vătămarea integrităţii corporale, prin o altă vătămare a sănătăţii sau
        prin deces, dacă repararea s-a efectuat sub formă de prestaţii băneşti
        periodice
        """
      )
    , ( RightInfringementRepair
      , """
        repararea prejudiciului cauzat prin încălcarea dreptului la
        judecarea în termen rezonabil a cauzei sau a dreptului la executarea în
        termen rezonabil a hotărîrii judecătoreşti
        """
      )
    , ( IllicitActionRepair
      , """
        repararea prejudiciului cauzat prin acţiunile ilicite ale
        organelor de urmărire penală, ale procuraturii şi ale instanţelor
        judecătoreşti
        """
      )
    , ( JobRestoration
      , """
        restabilirea la locul de muncă şi de încasarea salariului mediu
        pentru întreaga perioadă de absenţă forţată de la muncă
        """
      )
    , ( SocialInsuranceCompensation
      , """
        încasarea indemnizaţiilor pentru incapacitate temporară de muncă şi
        altor prestaţii de asigurări sociale prevăzute de lege
        """
      )
    , ( LegalAssistancePaymentCollection
      , """
        încasarea cheltuielilor pentru acordarea asistenţei juridice
        garantate de stat
        """
      )
    ]


newValue : Type
newValue =
    AssetConfiscation newAssetConfiscationValue


newAssetConfiscationValue : AssetConfiscationValue
newAssetConfiscationValue =
    {}


field : Type -> (Type -> msg) -> Html msg
field cause callback =
    label []
        [ text "Decision cause:"
        , Select.fromValuesWithLabels valuesWithLabels cause callback
        ]
