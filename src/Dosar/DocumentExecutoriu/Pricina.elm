module Dosar.DocumentExecutoriu.Pricina exposing (Pricina, empty, view)

import Html exposing (Html, label, text)
import Widgets.Select as Select


type
    Pricina
    -- Articolul 145. Categoriile de creanţe
    -- (1) Se stabilesc 3 categorii de creanţe.
    -- (2) La categoria intii de creanţe sint atribuite creanţele privind:
    = -- a) plata pensiei de intreţinere;
      PensieIntretinere
    | -- b) plaţile ce decurg din raporturile de munca;
      PlatiRaporturiMunca
    | -- c) reparaţia prejudiciilor cauzate prin schilodire sau prin o alta
      -- vatamare a sanataţii, precum şi in legatura cu pierderea
      -- intreţinatorului;
      PrejudiciiSanatate
    | -- d) reparaţia prejudiciilor cauzate persoanelor fizice prin infracţiune
      -- sau contravenţie;
      PrejudiciiPersonale
    | -- e) contribuţiile obligatorii de asigurari sociale de stat.
      AsigurariSociale
      -- (3) La categoria a doua de creanţe sint atribuite creanţele privind:
    | -- a) impozitele, taxele şi alte plaţi aferente bugetului public naţional;
      PlatiBugetPublic
    | -- b) taxele de stat, amenzile şi penalitaţile aferente bugetului public
      -- naţional;
      PenalitatiBugetPublic
    | -- c) reparaţia prejudiciilor cauzate prin infracţiune sau contravenţie
      -- persoanelor juridice, precum şi asociaţiilor şi societaţilor care nu au
      -- personalitate juridica, dar care dispun de organe de conducere proprii;
      PrejudiciiOrganizatii
    | -- d) plaţile pentru drepturile de autor şi drepturile conexe;
      DrepturiAutor
    | -- e) cheltuielile de asistenţa juridica.
      AsistentaJuridica
    | -- (4) La categoria a treia de creanţe sint atribuite celelalte creanţe.
      Alte


valuesWithLabels : List ( Pricina, String )
valuesWithLabels =
    [ ( PensieIntretinere
      , "plata pensiei de intreţinere"
      )
    , ( PlatiRaporturiMunca
      , "plaţile ce decurg din raporturile de munca"
      )
    , ( PrejudiciiSanatate
      , "reparaţia prejudiciilor cauzate prin schilodire sau prin o alta"
            ++ " vatamare a sanataţii, precum şi in legatura cu pierderea"
            ++ " intreţinatorului"
      )
    , ( PrejudiciiPersonale
      , "reparaţia prejudiciilor cauzate persoanelor fizice prin infracţiune"
            ++ " sau contravenţie"
      )
    , ( AsigurariSociale
      , "contribuţiile obligatorii de asigurari sociale de stat"
      )

    -- (3) La categoria a doua de creanţe sint atribuite creanţele privind:
    , ( PlatiBugetPublic
      , "impozitele, taxele şi alte plaţi aferente bugetului public naţional"
      )
    , ( PenalitatiBugetPublic
      , "taxele de stat, amenzile şi penalitaţile aferente bugetului public"
            ++ " naţional"
      )
    , ( PrejudiciiOrganizatii
      , "reparaţia prejudiciilor cauzate prin infracţiune sau contravenţie"
            ++ " persoanelor juridice, precum şi asociaţiilor şi societaţilor care nu au"
            ++ " personalitate juridica, dar care dispun de organe de conducere proprii"
      )
    , ( DrepturiAutor
      , "plaţile pentru drepturile de autor şi drepturile conexe"
      )
    , ( AsistentaJuridica
      , "cheltuielile de asistenţa juridica"
      )

    -- (4) La categoria a treia de creanţe sint atribuite celelalte creanţe.
    , ( Alte
      , "altele"
      )
    ]


empty : Pricina
empty =
    PensieIntretinere


view : Pricina -> (Pricina -> msg) -> Html msg
view pricina callback =
    label []
        [ text "Pricina:"
        , Select.fromValuesWithLabels valuesWithLabels empty callback
        ]
