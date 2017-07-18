module Main exposing (..)

import Html exposing (Html, div, pre, button, text)
import Html.Attributes exposing (value, selected, style)
import Dosar exposing (Dosar)
import Editor


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
    , text : String
    }


initialModel : Model
initialModel =
    { dosare = []
    , dosarDeschis = Just Dosar.newValue
    , text = "(initial text)"
    }


type Msg
    = UpdateDosar (Cmd Msg) Dosar
    | SendToEditor String
    | ReceiveFromEditor String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateDosar cmd dosar ->
            ( { model | dosarDeschis = Just dosar }, cmd )

        SendToEditor s ->
            ( model, Editor.sendToEditor s )

        ReceiveFromEditor s ->
            ( { model | text = s }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Editor.receiveFromEditor ReceiveFromEditor
        ]


view : Model -> Html Msg
view model =
    div []
        [ dosarView model.dosarDeschis
        , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
        , Editor.view model.text SendToEditor
        ]


dosarView : Maybe Dosar -> Html Msg
dosarView maybeDosar =
    case maybeDosar of
        Nothing ->
            text ""

        Just dosar ->
            Dosar.view UpdateDosar dosar
