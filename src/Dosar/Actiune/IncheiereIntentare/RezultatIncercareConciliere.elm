module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (RezultatIncercareConciliere, newValue, view)

import Html exposing (Html, fieldset, legend, label, div, text)
import Widgets.Select as Select
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere exposing (PartileAjungLaIntelegere)


type RezultatIncercareConciliere
    = PartileAjungLaIntelegere PartileAjungLaIntelegere
    | PartileNuAjungLaIntelegere


newValue : RezultatIncercareConciliere
newValue =
    PartileAjungLaIntelegere PartileAjungLaIntelegere.newValue


view : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> Cmd msg -> Sub msg -> msg) -> Html msg
view rezultatIncercareConciliere callback =
    fieldset []
        [ legend [] [ dropdown rezultatIncercareConciliere (\v -> callback v Cmd.none Sub.none) ]
        , fields rezultatIncercareConciliere callback
        ]


dropdown : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> msg) -> Html msg
dropdown rezultatIncercareConciliere callback =
    label []
        [ text "RezultatIncercareConciliere:"
        , Select.fromValuesWithLabels valuesWithLabels (defaultValue rezultatIncercareConciliere) callback
        ]


fields : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> Cmd msg -> Sub msg -> msg) -> Html msg
fields rezultatIncercareConciliere callback =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere v ->
            PartileAjungLaIntelegere.view v (\v -> callback (PartileAjungLaIntelegere v))

        PartileNuAjungLaIntelegere ->
            div [] [ text <| toString rezultatIncercareConciliere ]


valuesWithLabels : List ( RezultatIncercareConciliere, String )
valuesWithLabels =
    [ ( PartileAjungLaIntelegere PartileAjungLaIntelegere.newValue
      , "părțile ajung la înțelegere"
      )
    , ( PartileNuAjungLaIntelegere
      , "părțile nu ajung la înțelegere"
      )
    ]


defaultValue : RezultatIncercareConciliere -> RezultatIncercareConciliere
defaultValue rezultatIncercareConciliere =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere _ ->
            PartileAjungLaIntelegere PartileAjungLaIntelegere.newValue

        PartileNuAjungLaIntelegere ->
            PartileNuAjungLaIntelegere
