module Widgets.DateField exposing (Model, Msg, update, view)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Utils.MyDate as MyDate


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
                    , onInput SetString
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
    = SetString String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetString string ->
            MyDate.parse string
