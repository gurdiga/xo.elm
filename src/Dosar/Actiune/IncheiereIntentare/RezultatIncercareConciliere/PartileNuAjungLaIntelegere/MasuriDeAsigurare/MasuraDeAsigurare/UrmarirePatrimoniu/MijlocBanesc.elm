module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc exposing (Model)

import Utils.Money as Money exposing (Currency(EUR, USD), Money(Money))


type alias Model =
    { value : Money }
