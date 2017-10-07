module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (RezultatIncercareConciliere, empty, view)

import Html exposing (Html, fieldset, legend, label, div, text)
import MyMaterial.Select as Select
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere exposing (PartileAjungLaIntelegere)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere as PartileNuAjungLaIntelegere exposing (PartileNuAjungLaIntelegere)


type RezultatIncercareConciliere
    = PartileAjungLaIntelegere PartileAjungLaIntelegere
    | PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere


empty : RezultatIncercareConciliere
empty =
    PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.empty


view : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> Cmd msg -> Sub msg -> msg) -> Html msg
view rezultatIncercareConciliere callback =
    fieldset []
        [ legend [] [ dropdown rezultatIncercareConciliere (\v -> callback v Cmd.none Sub.none) ]
        , fields rezultatIncercareConciliere callback
        ]


dropdown : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> msg) -> Html msg
dropdown rezultatIncercareConciliere callback =
    Select.view
        { labelText = "RezultatIncercareConciliere:"
        , valuesWithLabels = valuesWithLabels
        , defaultValue = (defaultValue rezultatIncercareConciliere)
        , callback = callback
        }


fields : RezultatIncercareConciliere -> (RezultatIncercareConciliere -> Cmd msg -> Sub msg -> msg) -> Html msg
fields rezultatIncercareConciliere callback =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere v ->
            PartileAjungLaIntelegere.view v (\v -> callback (PartileAjungLaIntelegere v))

        PartileNuAjungLaIntelegere v ->
            PartileNuAjungLaIntelegere.view v (\v -> callback (PartileNuAjungLaIntelegere v))


valuesWithLabels : List ( RezultatIncercareConciliere, String )
valuesWithLabels =
    [ ( PartileAjungLaIntelegere PartileAjungLaIntelegere.empty
      , "părțile ajung la înțelegere"
      )
    , ( PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.empty
      , "părțile nu ajung la înțelegere"
      )
    ]


defaultValue : RezultatIncercareConciliere -> RezultatIncercareConciliere
defaultValue rezultatIncercareConciliere =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere _ ->
            PartileAjungLaIntelegere PartileAjungLaIntelegere.empty

        PartileNuAjungLaIntelegere _ ->
            PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.empty
