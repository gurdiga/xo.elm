module Main exposing (..)

import Html exposing (Html, div, pre, text)
import Html.Attributes exposing (value, selected, style)
import Dosar exposing (Dosar)


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dosare : List Dosar
    , dosarDeschis : Maybe Dosar
    , subscription : Sub Msg
    }


initialModel : Model
initialModel =
    { dosare = []
    , dosarDeschis = Just Dosar.newValue
    , subscription = Sub.none
    }


type Msg
    = Update Model (Cmd Msg) (Sub Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update model cmd sub ->
            ( { model | subscription = sub }, cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ model.subscription ]


view : Model -> Html Msg
view model =
    div []
        [ dosarView model
        , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
        ]


dosarView : Model -> Html Msg
dosarView model =
    case model.dosarDeschis of
        Nothing ->
            text ""

        Just dosar ->
            Dosar.view dosar (\v -> Update { model | dosarDeschis = Just v })
