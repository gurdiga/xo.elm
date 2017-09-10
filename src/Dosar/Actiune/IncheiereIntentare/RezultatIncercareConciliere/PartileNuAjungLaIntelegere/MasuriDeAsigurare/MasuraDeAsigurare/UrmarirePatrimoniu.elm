module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, text)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu


view : UrmarirePatrimoniu -> Html msg
view v =
    text "UrmarirePatrimoniu"
