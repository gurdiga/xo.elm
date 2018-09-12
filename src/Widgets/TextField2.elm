module Widgets.TextField2 exposing (view)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


type alias Model =
    String


view : String -> Model -> (Model -> msg) -> Html msg
view labelText model toMsg =
    label []
        [ text labelText
        , input
            [ onInput toMsg
            , value model
            ]
            []
        ]
