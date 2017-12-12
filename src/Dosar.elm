module Dosar exposing (Model, initialModel, update, Msg, view)

import Dosar.Css
import Html exposing (Html, h1, section, div, select, option, button, text, node)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- import Html.Events exposing (onInput)

import Dosar.Temei as Temei exposing (Model)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)


-- import UI.Styles as Styles


type Model
    = Model
        { id : String
        , temei : Temei.Model
        , documentExecutoriu : DocumentExecutoriu
        , actiune : Actiune
        }


initialModel : Model
initialModel =
    Model
        { id = "001"
        , temei = Temei.initialModel
        , documentExecutoriu = DocumentExecutoriu.empty
        , actiune = Actiune.empty
        }


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateTemei temei ->
            Model { model | temei = temei }


type Msg
    = UpdateTemei Temei.Model


view : Model -> Html Msg
view dosar =
    node "main"
        [ style Dosar.Css.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ node "hgroup"
                [ onClick (UpdateTemei Temei.initialModel) ]
                [ text "Temei:"

                -- , temeiDropdown dosar.temei
                ]
            ]
        ]



-- temeiDropdown : Temei.Model -> Html Msg
-- temeiDropdown temei =
--     select [ onInput UpdateTemei ]
--         (temeiValuesWithLabels |> List.map (temeiDropdownOption temei))
-- temeiDropdownOption : Temei -> ( Temei, String ) -> Html Msg
-- temeiDropdownOption selectedTemei ( temei, label ) =
--     option [ selected (selectedTemei == temei) ] [ text label ]
-- temeiLabelFromValue : Temei -> String
-- temeiLabelFromValue temei =
--     temeiValuesWithLabels
--         |> List.filter (\( t, l ) -> t == temei)
--         |> List.head
--         |> Maybe.map Tuple.second
--         |> Maybe.withDefault "cerere creditor"
-- temeiValueFromLabel : String -> Temei
-- temeiValueFromLabel temeiLabel =
--     temeiValuesWithLabels
--         |> List.filter (\( t, l ) -> l == temeiLabel)
--         |> List.head
--         |> Maybe.map Tuple.first
--         |> Maybe.withDefault defaultTemei
-- temeiValuesWithLabels : List ( Temei, String )
-- temeiValuesWithLabels =
--     [ ( CerereCreditor, "cerere creditor" )
--     , ( DemersInstanta, "demers instanță" )
--     , ( PreluareDocumentExecutoriuStramutat, "preluare document executoriu strămutat" )
--     ]
--view1 : Dosar -> (Msg -> Cmd msg -> Sub msg -> msg) -> Html msg
--view1 (Dosar data) tagger =
--    let
--        this =
--            section [ style (Styles.card ++ localStyle) ]
--                [ h1 [ style Styles.display1 ] [ text "Dosar nou" ]
--                , Temei.view data.temei TemeiMsg
--                    -- TODO: Figure this out.
--                    --
--                    -- This compiles, but there is one thing that’s bothering me about this solution:
--                    -- HTML.map docs say:
--                    --
--                    -- > This should not come in handy too often. Definitely
--                    -- > read this before deciding if this[1] is what you want.
--                    -- > [1] https://guide.elm-lang.org/reuse/
--                    --
--                    -- And I’d like to make this right.
--                    --
--                    -- I went this whole one-message-elm way not to have to map messages, and
--                    -- now I’m back to square one. :-\
--                    |> Html.map (\v -> tagger v Cmd.none Sub.none)
--                -- , DocumentExecutoriu.view data.documentExecutoriu (\v -> c { data | documentExecutoriu = v } Cmd.none Sub.none)
--                -- , Actiune.view data.actiune (\v -> c { data | actiune = v })
--                ]
--        localStyle =
--            [ ( "width", "800px" )
--            , ( "padding", "48px" )
--            ]
--    in
--        this
