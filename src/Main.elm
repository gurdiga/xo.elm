port module Main exposing (..)

import Html exposing (Html, div, pre, button, text)
import Html.Attributes exposing (value, selected, style)
import Html.Events exposing (onClick)
import Dosar exposing (Dosar)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { dosare : List Dosar
    , dosarDeschis : Maybe Dosar
    , text : String
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { dosare = []
    , dosarDeschis = Just Dosar.newValue
    , text = "(initial text)"
    }



-- UPDATE


type Msg
    = UpdateDosar Dosar
    | SendToEditor String
    | ReceiveFromEditor String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateDosar dosar ->
            ( { model | dosarDeschis = Just dosar }, Cmd.none )

        SendToEditor s ->
            ( model, sendToEditor s )

        ReceiveFromEditor s ->
            ( { model | text = s }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (SendToEditor "something to send to the editor") ] [ text "SendToEditor" ]
        , dosarView model.dosarDeschis
        , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
        ]


dosarView : Maybe Dosar -> Html Msg
dosarView maybeDosar =
    case maybeDosar of
        Nothing ->
            text ""

        Just dosar ->
            Dosar.view dosar UpdateDosar



-- SUBSCRIPTIONS


port sendToEditor : String -> Cmd msg


port receiveFromEditor : (String -> msg) -> Sub msg


subscriptions : Model -> Sub Msg
subscriptions model =
    receiveFromEditor ReceiveFromEditor
