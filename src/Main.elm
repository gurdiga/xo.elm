module Main exposing (..)

import Html exposing (Html, div, pre, button, text)
import Html.Attributes exposing (value, selected, style)
import Dosar exposing (Dosar)


-- import Editor


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
    = Update Model (Sub Msg) (Cmd Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update model sub cmd ->
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
            Dosar.view (\v -> Update { model | dosarDeschis = Just v }) dosar
