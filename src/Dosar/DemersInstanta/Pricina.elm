module Dosar.DemersInstanta.Pricina exposing (Pricina, empty, view)

import Html exposing (Html, div, label, p, text)
import Widgets.Select as Select


type
    -- (2) Instanţa de judecata prezinta din oficiu titlul executoriu spre
    -- executare in pricinile ce ţin:
    Pricina
    = -- a) de confiscarea bunurilor;
      ConfiscareBunuri
    | -- b) de urmarirea sumelor ce urmeaza a fi facute venit la stat;
      UrmarireSumeVenitLaStat
    | -- c) urmarirea sumelor incasate din contul statului, din contul
      -- intreprinderilor de stat şi al celor municipale, al societaţilor
      -- comerciale cu capital majoritar de stat;
      UrmarireSumeDeLaStat
    | -- d) de urmarirea pensiei de intreţinere;
      UrmarirePensieIntretinere
    | -- e) de incasarea sumelor pentru repararea prejudiciilor cauzate prin
      -- vatamarea integritaţii corporale, prin o alta vatamare a sanataţii sau
      -- prin deces, daca repararea s-a efectuat sub forma de prestaţii baneşti
      -- periodice;
      PrejudiciiSanatate
    | -- e1) de repararea prejudiciului cauzat prin incalcarea dreptului la
      -- judecarea in termen rezonabil a cauzei sau a dreptului la executarea in
      -- termen rezonabil a hotaririi judecatoreşti;
      IncalcareDrepturiJudecata
    | -- e2) de repararea prejudiciului cauzat prin acţiunile ilicite ale
      -- organelor de urmarire penala, ale procuraturii şi ale instanţelor
      -- judecatoreşti;
      ActiuniIliciteOrganePenale
    | -- f) de restabilirea la locul de munca şi de incasarea salariului mediu
      -- pentru intreaga perioada de absenţa forţata de la munca;
      RestabilireLocMunca
    | -- g) incasarea indemnizaţiilor pentru incapacitate temporara de munca şi
      -- altor prestaţii de asigurari sociale prevazute de lege;
      IncasareAsigurariSociale
    | -- h) de incasarea cheltuielilor pentru acordarea asistenţei juridice
      -- garantate de stat.
      IncasareCheltuieliAsistentaJuridica


valuesWithLabels : List ( Pricina, String )
valuesWithLabels =
    [ ( ConfiscareBunuri
      , "confiscarea bunurilor"
      )
    , ( UrmarireSumeVenitLaStat
      , "urmarirea sumelor ce urmeaza a fi facute venit la stat"
      )
    , ( UrmarireSumeDeLaStat
      , asOneLine """
        urmarirea sumelor incasate din contul statului, din contul
        intreprinderilor de stat şi al celor municipale, al societaţilor
        comerciale cu capital majoritar de stat
        """
      )
    , ( UrmarirePensieIntretinere
      , "urmarirea pensiei de intreţinere"
      )
    , ( PrejudiciiSanatate
      , asOneLine """
        incasarea sumelor pentru repararea prejudiciilor cauzate prin
        vatamarea integritaţii corporale, prin o alta vatamare a sanataţii sau
        prin deces, daca repararea s-a efectuat sub forma de prestaţii baneşti
        periodice
        """
      )
    , ( IncalcareDrepturiJudecata
      , asOneLine """
        repararea prejudiciului cauzat prin incalcarea dreptului la
        judecarea in termen rezonabil a cauzei sau a dreptului la executarea in
        termen rezonabil a hotaririi judecatoreşti
        """
      )
    , ( ActiuniIliciteOrganePenale
      , asOneLine """
        repararea prejudiciului cauzat prin acţiunile ilicite ale
        organelor de urmarire penala, ale procuraturii şi ale instanţelor
        judecatoreşti
        """
      )
    , ( RestabilireLocMunca
      , asOneLine """
        restabilirea la locul de munca şi de incasarea salariului mediu
        pentru intreaga perioada de absenţa forţata de la munca
        """
      )
    , ( IncasareAsigurariSociale
      , asOneLine """
        incasarea indemnizaţiilor pentru incapacitate temporara de munca şi
        altor prestaţii de asigurari sociale prevazute de lege
        """
      )
    , ( IncasareCheltuieliAsistentaJuridica
      , asOneLine """
        incasarea cheltuielilor pentru acordarea asistenţei juridice
        garantate de stat
        """
      )
    ]


empty : Pricina
empty =
    ConfiscareBunuri


view : Pricina -> (Pricina -> msg) -> Html msg
view pricina callback =
    div []
        [ label []
            [ text "Pricina:"
            , Select.fromValuesWithLabels valuesWithLabels pricina callback
            ]
        , p [] [ text ("TODO: collect details of " ++ toString pricina) ]
        ]


asOneLine : String -> String
asOneLine =
    String.join " " << String.words
