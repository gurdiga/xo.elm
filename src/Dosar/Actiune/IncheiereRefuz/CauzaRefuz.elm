module Dosar.Actiune.IncheiereRefuz.CauzaRefuz exposing (CauzaRefuz, empty, view)

import Html exposing (Html, div, label, text)
import Widgets.Select4 as Select4


-- Articolul 61. Refuzul de a intenta procedura de executare
-- (1) Executorul judecătoresc poate refuza intentarea procedurii de executare dacă:


type CauzaRefuz
    = -- a) documentul nu este de competenţa sa;
      NecorespondentaCompetenta
    | -- b) termenul de prezentare a documentului spre executare a expirat;
      DocumentExecutoriuExpirat
    | -- c) documentul nu este întocmit în conformitate cu prevederile art.14 din prezentul cod;
      DocumentExecutoriuIntocmitNecorespunzator
    | -- d) documentul este înaintat de persoana care nu are împuternicirile respective, stabilite în modul prevăzut de legislaţie;
      DocumentExecutoriuInaintatNecorespunzator
    | -- e) termenul de executare benevolă acordat prin lege sau indicat în documentul executoriu nu a expirat;
      TermenExecutareBenevolaNeexpirat
    | -- f) documentul a fost executat.
      DocumentExecutoriuDejaExecutat


valuesWithLabels : List ( CauzaRefuz, String )
valuesWithLabels =
    [ ( NecorespondentaCompetenta
      , "documentul nu este de competenţa sa"
      )
    , ( DocumentExecutoriuExpirat
      , "termenul de prezentare a documentului spre executare a expirat"
      )
    , ( DocumentExecutoriuIntocmitNecorespunzator
      , "documentul nu este întocmit în conformitate cu prevederile art.14 din prezentul cod"
      )
    , ( DocumentExecutoriuInaintatNecorespunzator
      , "documentul este înaintat de persoana care nu are împuternicirile respective, stabilite în modul prevăzut de legislaţie"
      )
    , ( TermenExecutareBenevolaNeexpirat
      , "termenul de executare benevolă acordat prin lege sau indicat în documentul executoriu nu a expirat"
      )
    , ( DocumentExecutoriuDejaExecutat
      , "documentul a fost executat"
      )
    ]


empty : CauzaRefuz
empty =
    NecorespondentaCompetenta


view : CauzaRefuz -> (CauzaRefuz -> msg) -> Html msg
view cauzaRefuz callback =
    div []
        [ Select4.view <|
            Select4.config
                { label = "Cauza refuzului:"
                , valuesWithLabels = valuesWithLabels
                , defaultValue = cauzaRefuz
                , onInput = callback
                }
        ]
