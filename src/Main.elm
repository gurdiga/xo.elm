module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    Int


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = 0
        , view = view
        , update = update
        }


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 2

        Decrement ->
            model - 2

        Reset ->
            0


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , text (toString model)
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Reset ] [ text "reset" ]
        ]
