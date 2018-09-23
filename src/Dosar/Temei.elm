module Dosar.Temei exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor as CerereCreditor
import Dosar.Temei.DemersInstanta as DemersInstanta
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat
import Html exposing (Html, div, label, map, node, section, text)
import Widgets.Select as Select


type Model
    = CerereCreditor CerereCreditor.Model
    | DemersInstanta DemersInstanta.Model
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Model


view : Model -> Html Msg
view model =
    section []
        [ Select.view
            { label = "Temei:"
            , defaultValue = initialModel
            , valuesWithLabels = valuesWithLabels
            , onInput = SetTemei
            }
        , fields model
        ]


fields : Model -> Html Msg
fields model =
    case model of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor |> map SetCerereCreditor

        DemersInstanta demersInstanta ->
            DemersInstanta.view demersInstanta |> map SetDemersInstanta

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            PreluareDocumentExecutoriuStramutat.view preluareDocumentExecutoriuStramutat |> map SetPreluareDocumentExecutoriuStramutat


valuesWithLabels : List ( Model, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.initialModel
      , "cerere a creditorului"
      )
    , ( DemersInstanta DemersInstanta.initialModel
      , "demersul instanţei de judecată"
      )
    , ( PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.initialModel
      , "preluarea unui document executoriu strămutat"
      )
    ]


initialModel : Model
initialModel =
    DemersInstanta DemersInstanta.initialModel


type Msg
    = SetTemei Model
    | SetCerereCreditor CerereCreditor.Msg
    | SetDemersInstanta DemersInstanta.Msg
    | SetPreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTemei v ->
            v

        SetCerereCreditor cerereCreditorMsg ->
            case model of
                CerereCreditor c ->
                    CerereCreditor (CerereCreditor.update cerereCreditorMsg c)

                _ ->
                    model

        SetDemersInstanta demersInstantaMsg ->
            case model of
                DemersInstanta demersInstanta ->
                    DemersInstanta (DemersInstanta.update demersInstantaMsg demersInstanta)

                _ ->
                    -- TODO??
                    model

        SetPreluareDocumentExecutoriuStramutat subMsg ->
            case model of
                PreluareDocumentExecutoriuStramutat v ->
                    PreluareDocumentExecutoriuStramutat (PreluareDocumentExecutoriuStramutat.update subMsg v)

                _ ->
                    -- TODO???
                    model
