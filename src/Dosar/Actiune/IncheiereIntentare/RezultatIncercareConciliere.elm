module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (RezultatIncercareConciliere, newValue, view)

import Html exposing (Html, fieldset, legend, div, label, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileConvinAsupraConditiilorExecutarii as PartileConvinAsupraConditiilorExecutarii exposing (PartileConvinAsupraConditiilorExecutarii)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileConvinAsupraUneiTranzactii as PartileConvinAsupraUneiTranzactii exposing (PartileConvinAsupraUneiTranzactii)
import Widgets.Select as Select


type RezultatIncercareConciliere
    = PartileConvinAsupraConditiilorExecutarii PartileConvinAsupraConditiilorExecutarii
    | PartileConvinAsupraUneiTranzactii PartileConvinAsupraUneiTranzactii
    | NeprezentareaUneiParti
    | PartileNuAjungLaIntelegere


newValue : RezultatIncercareConciliere
newValue =
    PartileConvinAsupraConditiilorExecutarii PartileConvinAsupraConditiilorExecutarii.newValue


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
        PartileConvinAsupraConditiilorExecutarii v ->
            PartileConvinAsupraConditiilorExecutarii.view v (callback << PartileConvinAsupraConditiilorExecutarii)

        PartileConvinAsupraUneiTranzactii v ->
            PartileConvinAsupraUneiTranzactii.view v (callback << PartileConvinAsupraUneiTranzactii)

        NeprezentareaUneiParti ->
            div [] [ text <| toString rezultatIncercareConciliere ]

        PartileNuAjungLaIntelegere ->
            div [] [ text <| toString rezultatIncercareConciliere ]


valuesWithLabels : List ( RezultatIncercareConciliere, String )
valuesWithLabels =
    [ ( PartileConvinAsupraConditiilorExecutarii PartileConvinAsupraConditiilorExecutarii.newValue
      , "părțile convin asupra condițiilor de executare"
      )
    , ( PartileConvinAsupraUneiTranzactii PartileConvinAsupraUneiTranzactii.newValue
      , "părțile convin asupra unei tranzacții"
      )
    , ( NeprezentareaUneiParti
      , "părţile sau una dintre părţi nu se prezintă"
      )
    , ( PartileNuAjungLaIntelegere
      , "părțile nu ajung la înțelegere"
      )
    ]


defaultValue : RezultatIncercareConciliere -> RezultatIncercareConciliere
defaultValue rezultatIncercareConciliere =
    case rezultatIncercareConciliere of
        PartileConvinAsupraConditiilorExecutarii _ ->
            PartileConvinAsupraConditiilorExecutarii PartileConvinAsupraConditiilorExecutarii.newValue

        PartileConvinAsupraUneiTranzactii _ ->
            PartileConvinAsupraUneiTranzactii PartileConvinAsupraUneiTranzactii.newValue

        NeprezentareaUneiParti ->
            NeprezentareaUneiParti

        PartileNuAjungLaIntelegere ->
            PartileNuAjungLaIntelegere
