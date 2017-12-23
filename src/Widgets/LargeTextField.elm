module Widgets.LargeTextField exposing (view, update, Msg)

import Html exposing (Html, label, textarea, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value, style)
import Widgets.LargeTextField.Css as Css


type alias Model =
    String


view : String -> Model -> Html Msg
view labelText model =
    label []
        [ text labelText
        , textarea
            [ onInput UpdateValue
            , value model
            , style Css.textarea
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
