module Dosar.Temei exposing (Model, Msg, initialModel, update, view, subscriptions)

import Html exposing (Html, node, section, div, label, text)
import Html.Attributes exposing (style)
import Widgets.Select3 as Select3
import Dosar.Temei.Css as Css
import Dosar.Temei.CerereCreditor as CerereCreditor
import Dosar.Temei.DemersInstanta as DemersInstanta exposing (DemersInstanta)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat)


-- TODO: review and make a plan for housekeeping


type Model
    = Model
        { temei : Temei
        , ui :
            { select : Select3.Model Temei
            }
        }


type Temei
    = CerereCreditor CerereCreditor.Model
    | DemersInstanta DemersInstanta
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat


view : Model -> Html Msg
view (Model model) =
    section []
        [ sectionTitle model.ui.select
        , fields model.temei
        ]


sectionTitle : Select3.Model Temei -> Html Msg
sectionTitle select =
    node "hgroup"
        [ -- TODO: consider letting Css.sectionTitle contain the `style` call
          -- so that I don’t have to import Html.Attributes onmy for style?
          style Css.sectionTitle
        ]
        [ Select3.view "Temei:" select |> Html.map Select3Msg
        ]


fields : Temei -> Html Msg
fields temei =
    case temei of
        CerereCreditor cerereCreditor ->
            CerereCreditor.view cerereCreditor |> Html.map CerereCreditorMsg

        DemersInstanta demersInstanta ->
            text "DemersInstanta.view"

        PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
            text "PreluareDocumentExecutoriuStramutat.view"


valuesWithLabels : List ( Temei, String )
valuesWithLabels =
    [ ( CerereCreditor CerereCreditor.empty
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
    CerereCreditor CerereCreditor.empty


subscriptions : List (Sub Msg)
subscriptions =
    Select3.subscriptions
        |> List.map (Sub.map Select3Msg)


type Msg
    = UpdateTemei Temei
    | Select3Msg (Select3.Msg Temei)
    | CerereCreditorMsg CerereCreditor.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        Select3Msg select3Msg ->
            let
                this =
                    Model
                        { model
                            | ui = (\ui -> { ui | select = newSelect }) model.ui
                            , temei = Select3.selectedValue newSelect
                        }

                newSelect =
                    Select3.update select3Msg model.ui.select
            in
                this

        CerereCreditorMsg cerereCreditorMsg ->
            -- TODO: Figure out how to do this cleanly, without the need for another `case` here.
            case model.temei of
                CerereCreditor cerereCreditor ->
                    Model { model | temei = CerereCreditor (CerereCreditor.update cerereCreditorMsg cerereCreditor) }

                _ ->
                    Model model

        UpdateTemei temei ->
            Model { model | temei = temei }
