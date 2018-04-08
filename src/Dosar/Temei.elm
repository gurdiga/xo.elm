module Dosar.Temei exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor as CerereCreditor
import Dosar.Temei.Css as Css
import Dosar.Temei.DemersInstanta as DemersInstanta
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat
import Html.Styled exposing (Html, div, fromUnstyled, label, map, node, section, text, toUnstyled)
import Html.Styled.Attributes exposing (css)
import Widgets.Select3 as Select3


type Model
    = Model
        { temei : Temei
        , ui : Ui
        }


type alias Ui =
    { select : Select3.Model Temei
    }


type Temei
    = CerereCreditor CerereCreditor.Model
    | DemersInstanta DemersInstanta.Model
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Model


view : Model -> Html Msg
view (Model model) =
    section [ css [ Css.section ] ]
        [ sectionTitle
        , Select3.view "Temei:" model.ui.select |> map SetTemei
        , fields model.temei
        ]


sectionTitle : Html Msg
sectionTitle =
    node "hgroup"
        [ css [ Css.sectionTitle ] ]
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
        , ui =
            { select = Select3.initialModel initialTemei valuesWithLabels
            }
        }


initialTemei : Temei
initialTemei =
    PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.initialModel


type Msg
    = SetTemei (Select3.Msg Temei)
    | SetCerereCreditor CerereCreditor.Msg
    | SetDemersInstanta DemersInstanta.Msg
    | SetPreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetTemei select3Msg ->
            receiveTemei (Model model) (Select3.update select3Msg model.ui.select)

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
                    Model model

        SetPreluareDocumentExecutoriuStramutat subMsg ->
            case model.temei of
                PreluareDocumentExecutoriuStramutat v ->
                    Model { model | temei = PreluareDocumentExecutoriuStramutat (PreluareDocumentExecutoriuStramutat.update subMsg v) }

                _ ->
                    Model model


receiveTemei : Model -> Select3.Model Temei -> Model
receiveTemei (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | select = newSelect }
            , temei = Select3.selectedValue newSelect
        }
