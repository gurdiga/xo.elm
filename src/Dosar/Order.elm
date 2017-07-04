module Dosar.Order exposing (Type, newValue)

import Date exposing (Date)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.Cause as Cause
import Warrant


type alias
    -- https://workflowy.com/#/07d4c20e89a4
    Type
    =
    { -- • denumirea instanţei de judecata care l-a eliberat
      court : CourtValue
    , -- • pricina in a carei baza a fost eliberat, categoria de creanta —
      -- https://workflowy.com/#/6e5a4774a675
      cause : Cause.Type
    , -- • data pronunţarii hotaririi
      orderDate : Maybe Date
    , -- • dispozitivul (textual)
      text : String
    , -- • data raminerii definitive a hotaririi — https://workflowy.com/#/a3557fcba688
      finalDate : Maybe Date
    , -- • date despre debitor(i) si creditor — https://workflowy.com/#/62b772bb8008
      creditor : Persoana
    , debtors : List Persoana
    , -- • data eliberarii titlului executoriu
      releaseDate : Maybe Date
    , -- • daca sunt, documentele executorii eliberate de instanţa de judecata
      -- prin care s-a dispus aplicarea masurilor de asigurare a acţiunii sau de
      -- asigurare a probelor, sau de anulare a lor¹
      -- • daca sunt, menţiunea privind autorizarea patrunderii forţate a
      -- executorului judecatoresc in incaperile aflate in posesia sau in
      -- proprietatea debitorului, inclusiv in cele in care se afla bunurile
      -- debitorului
      -- • daca sunt, copia scanata a documentelor mentionate la punctul
      -- precedent
      warrants : List Warrant.Type
    , -- • daca e mentionat, locul de pastrare [a bunurilor sechestrate] indicat
      -- de instanta de judecata — Articolul 27. (4¹)
      addressForKeepingSeizedAssets : String
    , notes : String
    }


type alias CourtValue =
    String


newValue : Type
newValue =
    { court = "The Court"
    , cause = Cause.newValue
    , orderDate = Nothing
    , text = "You shall do this and that."
    , finalDate = Nothing
    , creditor = Persoana.newValue
    , debtors = [ Persoana.newValue ]
    , releaseDate = Nothing
    , warrants = [ Warrant.newValue ]
    , addressForKeepingSeizedAssets = ""
    , notes = ""
    }
