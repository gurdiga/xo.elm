module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, newValue)

import Date exposing (Date)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.Pricina as Pricina
import Warrant


type alias
    -- https://workflowy.com/#/07d4c20e89a4
    DocumentExecutoriu
    =
    { -- • denumirea instanţei de judecata care l-a eliberat
      instantaJudecata : InstantaJudecata
    , -- • pricina in a carei baza a fost eliberat, categoria de creanta —
      -- https://workflowy.com/#/6e5a4774a675
      pricina : Pricina.DocumentExecutoriu
    , -- • data pronunţarii hotaririi
      dataPronuntarii : Maybe Date
    , -- • dispozitivul (textual)
      dispozitivul : String
    , -- • data raminerii definitive a hotaririi — https://workflowy.com/#/a3557fcba688
      dataRamineriiDefinitive : Maybe Date
    , -- • date despre debitor(i) si creditor — https://workflowy.com/#/62b772bb8008
      creditor : Persoana
    , debitori : List Persoana
    , -- • data eliberarii titlului executoriu
      dataEliberarii : Maybe Date
    , -- • daca sunt, documentele executorii eliberate de instanţa de judecata
      -- prin care s-a dispus aplicarea masurilor de asigurare a acţiunii sau de
      -- asigurare a probelor, sau de anulare a lor¹
      -- • daca sunt, menţiunea privind autorizarea patrunderii forţate a
      -- executorului judecatoresc in incaperile aflate in posesia sau in
      -- proprietatea debitorului, inclusiv in cele in care se afla bunurile
      -- debitorului
      -- • daca sunt, copia scanata a documentelor mentionate la punctul
      -- precedent
      documenteAplicareMasuriAsigurare : List Warrant.DocumentExecutoriu
    , -- • daca e mentionat, locul de pastrare [a bunurilor sechestrate] indicat
      -- de instanta de judecata — Articolul 27. (4¹)
      locPastrareBunuriSechestrate : String
    , autorizariPatrudereFortata : List String
    , note : String
    }


type alias InstantaJudecata =
    String


newValue : DocumentExecutoriu
newValue =
    { instantaJudecata = "The Court"
    , pricina = Pricina.newValue
    , dataPronuntarii = Nothing
    , dispozitivul = "You shall do this and that."
    , dataRamineriiDefinitive = Nothing
    , creditor = Persoana.newValue
    , debitori = [ Persoana.newValue ]
    , dataEliberarii = Nothing
    , documenteAplicareMasuriAsigurare = []
    , locPastrareBunuriSechestrate = ""
    , autorizariPatrudereFortata = []
    , note = ""
    }
