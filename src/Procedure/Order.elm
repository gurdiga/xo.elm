module Procedure.Order exposing (Type, newValue)

import Date exposing (Date)
import Procedure.Person as Person
import Procedure.Cause as Cause
import Warrant


type alias
    -- https://workflowy.com/#/07d4c20e89a4
    Type
    =
    { -- • denumirea instanţei de judecată care l-a eliberat
      court : CourtValue
    , -- • pricina în a cărei bază a fost eliberat, categoria de creanță —
      -- https://workflowy.com/#/6e5a4774a675
      cause : Cause.Type
    , -- • data pronunţării hotărîrii
      orderDate : Maybe Date
    , -- • dispozitivul (textual)
      text : String
    , -- • data rămînerii definitive a hotărîrii — https://workflowy.com/#/a3557fcba688
      finalDate : Maybe Date
    , -- • date despre debitor(i) și creditor — https://workflowy.com/#/62b772bb8008
      creditor : Person.Type
    , debtors : List Person.Type
    , -- • data eliberării titlului executoriu
      releaseDate : Maybe Date
    , -- • dacă sunt, documentele executorii eliberate de instanţa de judecată
      -- prin care s-a dispus aplicarea măsurilor de asigurare a acţiunii sau de
      -- asigurare a probelor, sau de anulare a lor¹
      -- • dacă sunt, menţiunea privind autorizarea pătrunderii forţate a
      -- executorului judecătoresc în încăperile aflate în posesia sau în
      -- proprietatea debitorului, inclusiv în cele în care se află bunurile
      -- debitorului
      -- • dacă sunt, copia scanată a documentelor menționate la punctul
      -- precedent
      warrants : List Warrant.Type
    , -- • dacă e menționat, locul de păstrare [a bunurilor sechestrate] indicat
      -- de instanța de judecată — Articolul 27. (4¹)
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
    , creditor = Person.newValue
    , debtors = [ Person.newValue ]
    , releaseDate = Nothing
    , warrants = [ Warrant.newValue ]
    , addressForKeepingSeizedAssets = ""
    , notes = ""
    }
