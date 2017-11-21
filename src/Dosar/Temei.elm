module Dosar.Temei exposing (..)

import Html exposing (Html, node, section, div, label, text)
import Html.Attributes exposing (style)
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
    section []
        [ sectionTitle temei callback
        , fields temei callback
        ]


sectionTitle : Temei -> (Temei -> Cmd msg -> Sub msg -> msg) -> Html msg
sectionTitle temei callback =
    let
        this =
            node "hgroup"
                [ style styles ]
                [ Select.view "Temei:"
                    valuesWithLabels
                    (defaultValue temei)
                    (\v -> callback v Cmd.none Sub.none)
                ]

        styles =
            [ ( "padding", "8px" )
            , ( "color", "white" )
            , ( "background-color", "#666" )
            , ( "font-size", "23px" )
            , ( "font-weight", "bold" )
            , ( "width", "400px" )
            , ( "display", "flex" )
            ]
    in
        this


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
