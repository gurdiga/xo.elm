module Dosar.Temei exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor as CerereCreditor
import Dosar.Temei.DemersInstanta as DemersInstanta
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat
import Html exposing (Html, div, label, map, node, section, text)
import Widgets.Select4 as Select4


type Model
    = Model
        { temei : Temei
        }


type Temei
    = CerereCreditor CerereCreditor.Model
    | DemersInstanta DemersInstanta.Model
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Model


view : Model -> Html Msg
view (Model model) =
    section []
        [ sectionTitle
        , Select4.view <|
            Select4.config
                { label = "Temei:"
                , defaultValue = model.temei
                , valuesWithLabels = []
                , onInput = SetTemei
                }
        , fields model.temei
        ]


sectionTitle : Html Msg
sectionTitle =
    node "hgroup"
        []
        [ text "Temeiul" ]


fields : Temei -> Html Msg
fields temei =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor |> map SetCerereCreditor

        DemersInstanta demersInstanta ->
            DemersInstanta.view demersInstanta |> map SetDemersInstanta

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            PreluareDocumentExecutoriuStramutat.view preluareDocumentExecutoriuStramutat |> map SetPreluareDocumentExecutoriuStramutat


valuesWithLabels : List ( Temei, String )
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
    Model
        { temei = initialTemei
        }


initialTemei : Temei
initialTemei =
    CerereCreditor CerereCreditor.initialModel


type Msg
    = SetTemei Temei
    | SetCerereCreditor CerereCreditor.Msg
    | SetDemersInstanta DemersInstanta.Msg
    | SetPreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetTemei v ->
            Model { model | temei = v }

        SetCerereCreditor cerereCreditorMsg ->
            case model.temei of
                CerereCreditor c ->
                    Model { model | temei = CerereCreditor (CerereCreditor.update cerereCreditorMsg c) }

                _ ->
                    Model model

        SetDemersInstanta demersInstantaMsg ->
            case model.temei of
                DemersInstanta demersInstanta ->
                    Model { model | temei = DemersInstanta (DemersInstanta.update demersInstantaMsg demersInstanta) }

                _ ->
                    -- TODO??
                    Model model

        SetPreluareDocumentExecutoriuStramutat subMsg ->
            case model.temei of
                PreluareDocumentExecutoriuStramutat v ->
                    Model { model | temei = PreluareDocumentExecutoriuStramutat (PreluareDocumentExecutoriuStramutat.update subMsg v) }

                _ ->
                    -- TODO???
                    Model model
