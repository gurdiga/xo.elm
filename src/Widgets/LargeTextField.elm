module Widgets.LargeTextField exposing (Model, Msg, update, view)

import Html exposing (Html, label, text, textarea)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


type alias Model =
    String


view : String -> Model -> Html Msg
view labelText model =
    label []
        [ text labelText
        , textarea
            [ onInput SetValue
            , value model
            ]
            []
        ]


type Msg
    = SetValue Model


update : Msg -> Model -> String
update msg model =
    case msg of
        SetValue value ->
            value
