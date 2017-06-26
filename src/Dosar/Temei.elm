module Dosar.Temei exposing (..)

import Html exposing (Html, fieldset, legend, label, text)
import Widgets.Select as Select
import Dosar.DemersInstanță as DemersInstanță
import Dosar.Temei.CerereCreditor as CerereCreditor exposing (CerereCreditor)
import Dosar.Temei.CerereCreditorIpotecă as CerereCreditorIpotecă exposing (CerereCreditorIpotecă)


type Temei
    = CerereCreditor CerereCreditor
    | CerereCreditorIpotecă CerereCreditorIpotecă
    | DemersInstanță DemersInstanță.Type
    | Takeover TakeoverValue


newValue : Temei
newValue =
    CerereCreditorIpotecă CerereCreditorIpotecă.newValue


view : Temei -> (Temei -> msg) -> Html msg
view temei callback =
    fieldset []
        [ legend [] [ text "Temei:" ]
        , dropdown temei callback
        , fields temei callback
        ]


dropdown : Temei -> (Temei -> msg) -> Html msg
dropdown defaultValue callback =
    Select.fromValuesWithLabels valuesWithLabels callback defaultValue


fields : Temei -> (Temei -> msg) -> Html msg
fields temei callback =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor (\v -> callback (CerereCreditor v))

        CerereCreditorIpotecă cerereCreditorIpotecă ->
            CerereCreditorIpotecă.view cerereCreditorIpotecă (\v -> callback (CerereCreditorIpotecă v))

        DemersInstanță decision ->
            DemersInstanță.view decision (\v -> callback (DemersInstanță v))

        Takeover takeover ->
            takeoverFields takeover


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.newValue
      , "cerere a creditorului"
      )
    , ( CerereCreditorIpotecă CerereCreditorIpotecă.newValue
      , "cerere a creditorului în temeiul contractului de ipotecă"
      )
    , ( DemersInstanță DemersInstanță.newValue
      , "demersul instanţei de judecată"
      )
    , ( Takeover {}
      , "preluarea unui document executoriu strămutat"
      )
    ]


takeoverFields : TakeoverValue -> Html msg
takeoverFields takeover =
    text <| "Takeover" ++ (toString takeover)


type alias TakeoverValue =
    {}
