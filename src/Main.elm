module Main exposing (..)

import Html exposing (Html, h1, section, div, pre, text, select, option, node)
import Html.Attributes exposing (value, selected, style)
import Html.Events exposing (onInput)
import UI.Layout as Layout
import Dosar.Css


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dosar : Maybe Dosar
    }


type alias Dosar =
    { temei : Temei
    }


emptyDosar : Dosar
emptyDosar =
    { temei = defaultTemei
    }


type Temei
    = CerereCreditor
    | DemersInstanta
    | PreluareDocumentExecutoriuStramutat


defaultTemei : Temei
defaultTemei =
    CerereCreditor


initialModel : Model
initialModel =
    { dosar = Just emptyDosar
    }


type Msg
    = SetTemei String


view : Model -> Html Msg
view model =
    Layout.view
        [ model.dosar |> Maybe.map dosarView |> Maybe.withDefault (text "")
        , pre [ style [ ( "white-space", "normal" ), ( "margin-bottom", "5em" ) ] ] [ text (toString model) ]
        ]


dosarView : Dosar -> Html Msg
dosarView dosar =
    node "main"
        [ style Dosar.Css.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ node "hgroup"
                []
                [ text "Temei:"
                , temeiDropdown dosar.temei
                ]
            ]
        ]


temeiDropdown : Temei -> Html Msg
temeiDropdown temei =
    select [ onInput SetTemei ]
        (temeiValuesWithLabels |> List.map (temeiDropdownOption temei))


temeiDropdownOption : Temei -> ( Temei, String ) -> Html Msg
temeiDropdownOption selectedTemei ( temei, label ) =
    option [ selected (selectedTemei == temei) ] [ text label ]


temeiLabelFromValue : Temei -> String
temeiLabelFromValue temei =
    temeiValuesWithLabels
        |> List.filter (\( t, l ) -> t == temei)
        |> List.head
        |> Maybe.map Tuple.second
        |> Maybe.withDefault "cerere creditor"


temeiValueFromLabel : String -> Temei
temeiValueFromLabel temeiLabel =
    temeiValuesWithLabels
        |> List.filter (\( t, l ) -> l == temeiLabel)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault defaultTemei


temeiValuesWithLabels : List ( Temei, String )
temeiValuesWithLabels =
    [ ( CerereCreditor, "cerere creditor" )
    , ( DemersInstanta, "demers instanță" )
    , ( PreluareDocumentExecutoriuStramutat, "preluare document executoriu strămutat" )
    ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetTemei temeiLabel ->
            let
                dosar =
                    model.dosar

                newDosar =
                    case dosar of
                        Just d ->
                            Just { d | temei = temeiValueFromLabel temeiLabel }

                        Nothing ->
                            dosar
            in
                ( { model | dosar = newDosar }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
