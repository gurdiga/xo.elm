module Dosar.Pricina exposing (Type, newValue)


type Type
    = Pricina CategorieCreanta Creanta


type CategorieCreanta
    = CategorieCreanta1
    | CategorieCreanta2
    | CategorieCreanta3


type
    -- Articolul 145. Categoriile de creanţe
    -- (1) Se stabilesc 3 categorii de creanţe.
    -- (2) La categoria intii de creanţe sint atribuite creanţele privind:
    Creanta
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


newValue : Type
newValue =
    Pricina CategorieCreanta1 PensieIntretinere
