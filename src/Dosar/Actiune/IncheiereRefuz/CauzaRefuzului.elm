module Dosar.Actiune.IncheiereRefuz.CauzaRefuzului exposing (CauzaRefuzului, newValue, view)

import Html exposing (Html, text)


-- Articolul 61. Refuzul de a intenta procedura de executare
-- (1) Executorul judecătoresc poate refuza intentarea procedurii de executare dacă:


type CauzaRefuzului
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


newValue : CauzaRefuzului
newValue =
    NecorespondentaCompetenta


view : Html msg
view =
    text "TODO: CauzaRefuzului.view"
