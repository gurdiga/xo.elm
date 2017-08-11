module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (RezultatIncercareConciliere, newValue, view)

import Html exposing (Html, div, text)


type RezultatIncercareConciliere
    = RezultatIncercareConciliere


newValue : RezultatIncercareConciliere
newValue =
    RezultatIncercareConciliere


view : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> msg) -> Html msg
view rezultatIncercareConciliere callback =
    div [] [ text <| toString rezultatIncercareConciliere ]
