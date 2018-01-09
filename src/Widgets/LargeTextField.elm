module Widgets.LargeTextField exposing (Msg, update, view)

import Html.Styled exposing (Html, label, text, textarea)
import Html.Styled.Attributes exposing (css, value)
import Html.Styled.Events exposing (onInput)
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
            , css [ Css.textarea ]
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
