module Dosar.Temei exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor as CerereCreditor
import Dosar.Temei.Css as Css
import Dosar.Temei.DemersInstanta as DemersInstanta exposing (DemersInstanta)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat)
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
    | DemersInstanta DemersInstanta
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat


view : Model -> Html Msg
view (Model model) =
    section [ css [ Css.section ] ]
        [ sectionTitle model.ui.select
        , fields model.temei
        ]


sectionTitle : Select3.Model Temei -> Html Msg
sectionTitle select =
    node "hgroup"
        [ css [ Css.sectionTitle ] ]
        [ Select3.view "Temei:" select |> map SetTemei ]


fields : Temei -> Html Msg
fields temei =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor |> map CerereCreditorMsg

        DemersInstanta demersInstanta ->
            text "DemersInstanta.view"

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            text "PreluareDocumentExecutoriuStramutat.view"


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.initialModel
      , "cerere a creditorului"
      )
    , ( DemersInstanta DemersInstanta.empty
      , "demersul instanţei de judecată"
      )
    , ( PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat.empty
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
    CerereCreditor CerereCreditor.initialModel


type Msg
    = SetTemei (Select3.Msg Temei)
    | CerereCreditorMsg CerereCreditor.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetTemei select3Msg ->
            receiveTemei (Model model) (Select3.update select3Msg model.ui.select)

        CerereCreditorMsg cerereCreditorMsg ->
            case model.temei of
                CerereCreditor c ->
                    Model { model | temei = CerereCreditor (CerereCreditor.update cerereCreditorMsg c) }

                _ ->
                    Model model


receiveTemei : Model -> Select3.Model Temei -> Model
receiveTemei (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | select = newSelect }
            , temei = Select3.selectedValue newSelect
        }
