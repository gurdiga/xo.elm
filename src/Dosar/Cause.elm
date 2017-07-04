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
    -- (2) La categoria intii de creanţe sint atribuite creanţele privind:
    Debt
    = -- a) plata pensiei de intreţinere;
      ChildSupportDebt
    | -- b) plaţile ce decurg din raporturile de munca;
      EmploymentRelatedDebt
    | -- c) reparaţia prejudiciilor cauzate prin schilodire sau prin o alta
      -- vatamare a sanataţii, precum şi in legatura cu pierderea
      -- intreţinatorului;
      HealthDamageDebt
    | -- d) reparaţia prejudiciilor cauzate persoanelor fizice prin infracţiune
      -- sau contravenţie;
      PersonalDamageDebt
    | -- e) contribuţiile obligatorii de asigurari sociale de stat.
      SocialSecurityDebt
      -- (3) La categoria a doua de creanţe sint atribuite creanţele privind:
    | -- a) impozitele, taxele şi alte plaţi aferente bugetului public naţional;
      TaxDebt
    | -- b) taxele de stat, amenzile şi penalitaţile aferente bugetului public
      -- naţional;
      PenaltiesDebt
    | -- c) reparaţia prejudiciilor cauzate prin infracţiune sau contravenţie
      -- persoanelor juridice, precum şi asociaţiilor şi societaţilor care nu au
      -- personalitate juridica, dar care dispun de organe de conducere proprii;
      CorporationDamageDebt
    | -- d) plaţile pentru drepturile de autor şi drepturile conexe;
      CopyrightPenaltiesDebt
    | -- e) cheltuielile de asistenţa juridica.
      JudicialAssistanceDebt
    | -- (4) La categoria a treia de creanţe sint atribuite celelalte creanţe.
      OtherDebt


newValue : Type
newValue =
    Cause DebtCategory1 ChildSupportDebt
