module Widgets.TextField exposing (Model, initialModel, view, update, Msg)

import Html exposing (Html)
import Html.Events exposing (onInput)
import Html.Attributes exposing (value)


type Model
    = Model String


initialModel : Model
initialModel =
    Model ""


type Msg
    = UpdateValue String


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateValue value ->
            Model value


view : String -> Model -> Html Msg
view labelText (Model model) =
    Html.label []
        [ Html.text labelText
        , Html.input [ onInput UpdateValue, value model ] []
        ]
