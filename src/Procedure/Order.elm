module Procedure.Order exposing (Type)

import Date exposing (Date)
import Procedure.Person as Person
import Procedure.Order.Cause as Cause


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
      warrants : List Warrant
    , -- • dacă e menționat, locul de păstrare [a bunurilor sechestrate] indicat
      -- de instanța de judecată — Articolul 27. (4¹)
      addressForKeepingSeizedAssets : String
    , notes : String
    }


type alias CourtValue =
    String


type Warrant
    = Warrant -- Fields + Maybe ScannedImageValue


newWarrant : Warrant
newWarrant =
    Warrant


type
    -- Articolul 145. Categoriile de creanţe
    -- (1) Se stabilesc 3 categorii de creanţe.
    -- (2) La categoria întîi de creanţe sînt atribuite creanţele privind:
    Debt
    = -- a) plata pensiei de întreţinere;
      ChildSupportDebt
    | -- b) plăţile ce decurg din raporturile de muncă;
      EmploymentRelatedDebt
    | -- c) reparaţia prejudiciilor cauzate prin schilodire sau prin o altă
      -- vătămare a sănătăţii, precum şi în legătură cu pierderea
      -- întreţinătorului;
      HealthDamageDebt
    | -- d) reparaţia prejudiciilor cauzate persoanelor fizice prin infracţiune
      -- sau contravenţie;
      PersonalDamageDebt
    | -- e) contribuţiile obligatorii de asigurări sociale de stat.
      SocialSecurityDebt
      -- (3) La categoria a doua de creanţe sînt atribuite creanţele privind:
    | -- a) impozitele, taxele şi alte plăţi aferente bugetului public naţional;
      TaxDebt
    | -- b) taxele de stat, amenzile şi penalităţile aferente bugetului public
      -- naţional;
      PenaltiesDebt
    | -- c) reparaţia prejudiciilor cauzate prin infracţiune sau contravenţie
      -- persoanelor juridice, precum şi asociaţiilor şi societăţilor care nu au
      -- personalitate juridică, dar care dispun de organe de conducere proprii;
      CorporationDamageDebt
    | -- d) plăţile pentru drepturile de autor şi drepturile conexe;
      CopyrightPenaltiesDebt
    | -- e) cheltuielile de asistenţă juridică.
      JudicialAssistanceDebt
    | -- (4) La categoria a treia de creanţe sînt atribuite celelalte creanţe.
      OtherDebt
