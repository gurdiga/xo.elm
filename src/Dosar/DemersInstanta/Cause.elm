module Dosar.DemersInstanta.Cause exposing (Type, Msg, newValue, field)

import Html exposing (Html, label, text)
import Widgets.Select as Select


type Msg
    = Change


type
    -- (2) Instanţa de judecata prezinta din oficiu titlul executoriu spre
    -- executare in pricinile ce ţin:
    Type
    = -- a) de confiscarea bunurilor;
      AssetConfiscation AssetConfiscationValue
    | -- b) de urmarirea sumelor ce urmeaza a fi facute venit la stat;
      MoneyCollectionForGovernment
    | -- c) urmarirea sumelor incasate din contul statului, din contul
      -- intreprinderilor de stat şi al celor municipale, al societaţilor
      -- comerciale cu capital majoritar de stat;
      MoneyCollectionFromGovernment
    | -- d) de urmarirea pensiei de intreţinere;
      AlimonyCollection
    | -- e) de incasarea sumelor pentru repararea prejudiciilor cauzate prin
      -- vatamarea integritaţii corporale, prin o alta vatamare a sanataţii sau
      -- prin deces, daca repararea s-a efectuat sub forma de prestaţii baneşti
      -- periodice;
      HealthDamagePaymentCollection
    | -- e1) de repararea prejudiciului cauzat prin incalcarea dreptului la
      -- judecarea in termen rezonabil a cauzei sau a dreptului la executarea in
      -- termen rezonabil a hotaririi judecatoreşti;
      RightInfringementRepair
    | -- e2) de repararea prejudiciului cauzat prin acţiunile ilicite ale
      -- organelor de urmarire penala, ale procuraturii şi ale instanţelor
      -- judecatoreşti;
      IllicitActionRepair
    | -- f) de restabilirea la locul de munca şi de incasarea salariului mediu
      -- pentru intreaga perioada de absenţa forţata de la munca;
      JobRestoration
    | -- g) incasarea indemnizaţiilor pentru incapacitate temporara de munca şi
      -- altor prestaţii de asigurari sociale prevazute de lege;
      SocialInsuranceCompensation
    | -- h) de incasarea cheltuielilor pentru acordarea asistenţei juridice
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
      , "urmarirea sumelor ce urmeaza a fi facute venit la stat"
      )
    , ( MoneyCollectionFromGovernment
      , """
        urmarirea sumelor incasate din contul statului, din contul
        intreprinderilor de stat şi al celor municipale, al societaţilor
        comerciale cu capital majoritar de stat
        """
      )
    , ( AlimonyCollection
      , "urmarirea pensiei de intreţinere"
      )
    , ( HealthDamagePaymentCollection
      , """
        incasarea sumelor pentru repararea prejudiciilor cauzate prin
        vatamarea integritaţii corporale, prin o alta vatamare a sanataţii sau
        prin deces, daca repararea s-a efectuat sub forma de prestaţii baneşti
        periodice
        """
      )
    , ( RightInfringementRepair
      , """
        repararea prejudiciului cauzat prin incalcarea dreptului la
        judecarea in termen rezonabil a cauzei sau a dreptului la executarea in
        termen rezonabil a hotaririi judecatoreşti
        """
      )
    , ( IllicitActionRepair
      , """
        repararea prejudiciului cauzat prin acţiunile ilicite ale
        organelor de urmarire penala, ale procuraturii şi ale instanţelor
        judecatoreşti
        """
      )
    , ( JobRestoration
      , """
        restabilirea la locul de munca şi de incasarea salariului mediu
        pentru intreaga perioada de absenţa forţata de la munca
        """
      )
    , ( SocialInsuranceCompensation
      , """
        incasarea indemnizaţiilor pentru incapacitate temporara de munca şi
        altor prestaţii de asigurari sociale prevazute de lege
        """
      )
    , ( LegalAssistancePaymentCollection
      , """
        incasarea cheltuielilor pentru acordarea asistenţei juridice
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
