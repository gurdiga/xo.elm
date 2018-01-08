module Widgets.DateField exposing (Model, view, update, Msg)

import Html.Styled exposing (Html, label, input, text)
import Html.Styled.Events exposing (onInput)
import Html.Styled.Attributes exposing (value, css)
import Utils.MyDate as MyDate
import Widgets.DateField.Css as Css


type alias Model =
    MyDate.Model


view : String -> Model -> Html Msg
view labelText model =
    let
        this =
            label []
                [ text labelText
                , input
                    [ value inputText
                    , onInput UpdateString
                    , css [ Css.input ]
                    ]
                    []
                , text validationMessage
                ]

        ( inputText, validationMessage ) =
            case MyDate.format model of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( MyDate.string model, errorMessage )
    in
        this


type Msg
    = UpdateString String


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateString string ->
            MyDate.parse string
