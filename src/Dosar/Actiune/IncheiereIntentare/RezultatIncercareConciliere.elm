module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (RezultatIncercareConciliere, newValue, view)

import Html exposing (Html, div, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere exposing (PartileAjungLaIntelegere)


-- TODO: Review Articolul 62.: it looks like there can be nuances worthy of
-- encoding as type options.


type RezultatIncercareConciliere
    = PartileAjungLaIntelegere PartileAjungLaIntelegere
    | PartileNuAjungLaIntelegere


newValue : RezultatIncercareConciliere
newValue =
    PartileAjungLaIntelegere PartileAjungLaIntelegere.newValue


view : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> msg) -> Html msg
view rezultatIncercareConciliere callback =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere rezultatIncercareConciliere ->
            PartileAjungLaIntelegere.view rezultatIncercareConciliere (\v -> callback (PartileAjungLaIntelegere v))

        PartileNuAjungLaIntelegere ->
            div [] [ text <| toString rezultatIncercareConciliere ]
