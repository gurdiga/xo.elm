module Widgets.CheckboxField exposing (Msg, update, view)

import Html.Styled exposing (Html, input, label, text)
import Html.Styled.Attributes exposing (checked, type_, value)
import Html.Styled.Events exposing (onCheck)


type alias Model =
    Bool


view : String -> Model -> Html Msg
view labelText model =
    label []
        [ input
            [ type_ "checkbox"
            , checked model
            , onCheck SetValue
            ]
            []
        , text labelText
        ]


type Msg
    = SetValue Model


update : Msg -> Model -> Bool
update msg model =
    case msg of
        SetValue value ->
            value
