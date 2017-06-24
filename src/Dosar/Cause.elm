module Dosar.Cause exposing (Type, newValue)


type Type
    = Cause DebtCategory Debt


type DebtCategory
    = DebtCategory1
    | DebtCategory2
    | DebtCategory3


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


newValue : Type
newValue =
    Cause DebtCategory1 ChildSupportDebt
