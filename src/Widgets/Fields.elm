module Widgets.Fields exposing (textField, largeTextField, dateField)

import Html exposing (Html, label, input, textarea, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import MyDate exposing (MyDate)


textField : String -> String -> (String -> msg) -> Html msg
textField labelText defaultValue callback =
    label []
        [ text labelText
        , input
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


largeTextField : String -> String -> (String -> msg) -> Html msg
largeTextField labelText defaultValue callback =
    label []
        [ text labelText
        , textarea
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


dateField : String -> MyDate -> (MyDate -> msg) -> Html msg
dateField labelText defaultValue callback =
    let
        ( inputText, validationMessage ) =
            case MyDate.format defaultValue of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( defaultValue.string, errorMessage )
    in
        label []
            [ text labelText
            , input
                [ value inputText
                , onInput (\v -> callback (MyDate.parse v))
                ]
                []
            , text validationMessage
            ]
