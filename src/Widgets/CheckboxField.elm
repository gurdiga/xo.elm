module Widgets.CheckboxField exposing (Model, Msg, initialModel, isChecked, update, view)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (checked, type_, value)
import Html.Events exposing (onCheck)


type alias Model =
    Bool


initialModel : Bool -> Model
initialModel value =
    value


isChecked : Model -> Bool
isChecked model =
    model


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
