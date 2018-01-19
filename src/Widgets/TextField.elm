module Widgets.TextField exposing (Msg, update, view)

import Html.Styled exposing (Html, input, label, text)
import Html.Styled.Attributes exposing (css, value)
import Html.Styled.Events exposing (onInput)
import Widgets.TextField.Css as Css


type alias Model =
    String


view : String -> Model -> Html Msg
view labelText model =
    label []
        [ text labelText
        , input
            [ onInput SetValue
            , value model
            , css [ Css.input ]
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
