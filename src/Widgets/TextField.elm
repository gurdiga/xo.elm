module Widgets.TextField exposing (view, update, Msg)

import Html exposing (Html, label, input, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value, style)
import Widgets.TextField.Css as Css


type alias Model =
    String


view : String -> Model -> Html Msg
view labelText model =
    label []
        [ text labelText
        , input
            [ onInput UpdateValue
            , value model
            , style Css.input
            ]
            []
        ]


type Msg
    = UpdateValue Model


update : Msg -> Model -> String
update msg model =
    case msg of
        UpdateValue value ->
            value
