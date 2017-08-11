module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere
    exposing
        ( PartileAjungLaIntelegere
        , newValue
        , view
        )

import Html exposing (Html, div, text)


type PartileAjungLaIntelegere
    = PartileAjungLaIntelegere


newValue : PartileAjungLaIntelegere
newValue =
    PartileAjungLaIntelegere


view : PartileAjungLaIntelegere -> (PartileAjungLaIntelegere -> msg) -> Html msg
view partileAjungLaIntelegere callback =
    div [] [ text <| "TODO:" ++ toString partileAjungLaIntelegere ]
