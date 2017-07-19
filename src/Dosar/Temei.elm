module Dosar.Temei exposing (..)

import Html exposing (Html, div, label, text)
import Widgets.Select as Select
import Dosar.Temei.CerereCreditor as CerereCreditor exposing (CerereCreditor)
import Dosar.Temei.DemersInstanta as DemersInstanta exposing (DemersInstanta)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat)


type Temei
    = CerereCreditor CerereCreditor
    | DemersInstanta DemersInstanta
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat


newValue : Temei
newValue =
    PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.newValue


view : (Temei -> Cmd msg -> Sub msg -> msg) -> Temei -> Html msg
view callback temei =
    div []
        [ dropdown (\v -> callback v Cmd.none Sub.none) temei
        , fields callback temei
        ]


dropdown : (Temei -> msg) -> Temei -> Html msg
dropdown callback temei =
    label []
        [ text "Temei:"
        , Select.fromValuesWithLabels valuesWithLabels (defaultValue temei) callback
        ]


fields : (Temei -> Cmd msg -> Sub msg -> msg) -> Temei -> Html msg
fields callback temei =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor (\v -> callback (CerereCreditor v) Cmd.none Sub.none)

        DemersInstanta demersInstanta ->
            DemersInstanta.view demersInstanta (\v -> callback (DemersInstanta v) Cmd.none Sub.none)

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            PreluareDocumentExecutoriuStramutat.view preluareDocumentExecutoriuStramutat
                (\v -> callback (PreluareDocumentExecutoriuStramutat v))


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.newValue
      , "cerere a creditorului"
      )
    , ( DemersInstanta DemersInstanta.newValue
      , "demersul instanţei de judecata"
      )
    , ( PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.newValue
      , "preluarea unui document executoriu stramutat"
      )
    ]


defaultValue : Temei -> Temei
defaultValue temei =
    case temei of
        CerereCreditor _ ->
            CerereCreditor CerereCreditor.newValue

        DemersInstanta _ ->
            DemersInstanta DemersInstanta.newValue

        PreluareDocumentExecutoriuStramutat _ ->
            PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.newValue
