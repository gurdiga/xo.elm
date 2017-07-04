module Dosar.Temei exposing (..)

import Html exposing (Html, fieldset, legend, label, text)
import Widgets.Select as Select
import Dosar.DemersInstanta as DemersInstanta
import Dosar.Temei.CerereCreditor as CerereCreditor exposing (CerereCreditor)


type Temei
    = CerereCreditor CerereCreditor
    | DemersInstanta DemersInstanta.Type
    | Takeover TakeoverValue


newValue : Temei
newValue =
    CerereCreditor CerereCreditor.newValue


view : Temei -> (Temei -> msg) -> Html msg
view temei callback =
    fieldset []
        [ legend [] [ text "Temei:" ]
        , dropdown temei callback
        , fields temei callback
        ]


dropdown : Temei -> (Temei -> msg) -> Html msg
dropdown defaultValue callback =
    Select.fromValuesWithLabels valuesWithLabels defaultValue callback


fields : Temei -> (Temei -> msg) -> Html msg
fields temei callback =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor (\v -> callback (CerereCreditor v))

        DemersInstanta decision ->
            DemersInstanta.view decision (\v -> callback (DemersInstanta v))

        Takeover takeover ->
            takeoverFields takeover


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.newValue
      , "cerere a creditorului"
      )
    , ( DemersInstanta DemersInstanta.newValue
      , "demersul instanţei de judecata"
      )
    , ( Takeover {}
      , "preluarea unui document executoriu stramutat"
      )
    ]


takeoverFields : TakeoverValue -> Html msg
takeoverFields takeover =
    text <| "Takeover" ++ (toString takeover)


type alias TakeoverValue =
    {}
