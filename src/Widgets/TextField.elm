module Widgets.TextField exposing (view, update, Msg)

import Html exposing (Html)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)


type Msg
    = UpdateValue String


update : Msg -> String -> String
update msg model =
    case msg of
        UpdateValue value ->
            value


view : String -> String -> Html Msg
view labelText model =
    Html.label []
        [ Html.text labelText
        , Html.input [ onInput UpdateValue, value model ] []
        ]
