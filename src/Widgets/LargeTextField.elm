module Widgets.LargeTextField exposing (view)

import Html exposing (Html, label, text, textarea)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


type alias Model =
    String


view : String -> Model -> (Model -> msg) -> Html msg
view labelText model toMsg =
    label []
        [ text labelText
        , textarea
            [ onInput toMsg
            , value model
            ]
            []
        ]
