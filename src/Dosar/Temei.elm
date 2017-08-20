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


empty : Temei
empty =
    CerereCreditor CerereCreditor.empty


view : Temei -> (Temei -> Cmd msg -> Sub msg -> msg) -> Html msg
view temei callback =
    div []
        [ dropdown temei (\v -> callback v Cmd.none Sub.none)
        , fields temei callback
        ]


dropdown : Temei -> (Temei -> msg) -> Html msg
dropdown temei callback =
    label []
        [ text "Temei:"
        , Select.fromValuesWithLabels valuesWithLabels (defaultValue temei) callback
        ]


fields : Temei -> (Temei -> Cmd msg -> Sub msg -> msg) -> Html msg
fields temei callback =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor (\v -> callback (CerereCreditor v))

        DemersInstanta demersInstanta ->
            DemersInstanta.view demersInstanta (\v -> callback (DemersInstanta v) Cmd.none Sub.none)

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            PreluareDocumentExecutoriuStramutat.view preluareDocumentExecutoriuStramutat
                (\v -> callback (PreluareDocumentExecutoriuStramutat v))


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.empty
      , "cerere a creditorului"
      )
    , ( DemersInstanta DemersInstanta.empty
      , "demersul instanţei de judecata"
      )
    , ( PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.empty
      , "preluarea unui document executoriu stramutat"
      )
    ]


defaultValue : Temei -> Temei
defaultValue temei =
    case temei of
        CerereCreditor _ ->
            CerereCreditor CerereCreditor.empty

        DemersInstanta _ ->
            DemersInstanta DemersInstanta.empty

        PreluareDocumentExecutoriuStramutat _ ->
            PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.empty
