module Dosar.Temei
    exposing
        ( Model
        , Msg
        , initialModel
        , update
        , view
        )

import Html exposing (Html, node, section, div, label, text)


-- import Html.Attributes exposing (style)

import Widgets.Select3 as Select3
import Dosar.Temei.CerereCreditor as CerereCreditor exposing (CerereCreditor)
import Dosar.Temei.DemersInstanta as DemersInstanta exposing (DemersInstanta)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat as PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat)


type Msg
    = Click (Cmd Msg) (Sub Msg)
    | Select3Msg (Select3.Model Temei)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Click cmd msg ->
            model

        Select3Msg select ->
            model
                |> setData (Debug.log "selectedValue" select.selectedValue)
                |> setUiSelect select


setData : Temei -> Model -> Model
setData temei (Model model) =
    Model { model | data = temei }


setUiSelect : Select3.Model Temei -> Model -> Model
setUiSelect select (Model model) =
    Model
        { model
            | ui = (\ui select -> { ui | select = select }) model.ui select
        }


type Model
    = Model
        { data : Temei
        , ui :
            { select : Select3.Model Temei
            }
        }


type Temei
    = CerereCreditor CerereCreditor
    | DemersInstanta DemersInstanta
    | PreluareDocumentExecutoriuStramutat PreluareDocumentExecutoriuStramutat


view : Model -> Html Msg
view (Model model) =
    section [] [ Select3.view "Temei:" model.ui.select Select3Msg ]



-- view1 : Model -> (Model -> Cmd msg -> Sub msg -> msg) -> Html msg
-- view1 model callback =
--     section []
--         [ sectionTitle model.ui.select
--             -- TODO:
--             --   - Clean this up, maybe extract it into an update-like function
--             --   - Also update model.data based on the new model.ui.select value
--             (\v ->
--                 let
--                     this =
--                         callback { model | ui = { ui | select = v } } Cmd.none Sub.none
--                     ui =
--                         model.ui
--                 in
--                     this
--             )
--         , fields model.data (\v -> callback { model | data = v })
--         ]
-- sectionTitle : Select3.Model Temei -> (Select3.Model Temei -> msg) -> Html msg
-- sectionTitle select3Model callback =
--     let
--         this =
--             node "hgroup"
--                 [ style styles ]
--                 [ Select3.view "Temei:" select3Model callback
--                 -- [ Select.view "Temei:"
--                 --     valuesWithLabels
--                 --     (defaultValue temei)
--                 --     (\v -> callback v Cmd.none Sub.none)
--                 ]
--         styles =
--             [ ( "padding", "8px" )
--             , ( "color", "white" )
--             , ( "background-color", "#666" )
--             , ( "font-size", "23px" )
--             , ( "font-weight", "bold" )
--             , ( "width", "400px" )
--             , ( "display", "flex" )
--             ]
--     in
--         this
-- fields : Temei -> (Temei -> Cmd msg -> Sub msg -> msg) -> Html msg
-- fields temei callback =
--     case temei of
--         CerereCreditor cerereCreditor ->
--             CerereCreditor.view cerereCreditor (\v -> callback (CerereCreditor v))
--         DemersInstanta demersInstanta ->
--             DemersInstanta.view demersInstanta (\v -> callback (DemersInstanta v) Cmd.none Sub.none)
--         PreluareDocumentExecutoriuStramutat preluareDocumentExecutoriuStramutat ->
--             PreluareDocumentExecutoriuStramutat.view preluareDocumentExecutoriuStramutat
--                 (\v -> callback (PreluareDocumentExecutoriuStramutat v))


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


initialModel : Model
initialModel =
    Model
        { data = initialTemei
        , ui =
            { select = Select3.initialModel initialTemei valuesWithLabels
            }
        }


initialTemei : Temei
initialTemei =
    CerereCreditor CerereCreditor.empty
