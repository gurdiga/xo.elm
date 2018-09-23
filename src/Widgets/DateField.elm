module Widgets.DateField exposing (view)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Utils.MyDate as MyDate


type alias Model =
    MyDate.Model


view : String -> Model -> (Model -> msg) -> Html msg
view labelText model toMsg =
    let
        ( inputText, validationMessage ) =
            case MyDate.format model of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( MyDate.string model, errorMessage )
    in
    label []
        [ text labelText
        , input
            [ value inputText
            , onInput (toMsg << MyDate.parse)
            ]
            []
        , text validationMessage
        ]
