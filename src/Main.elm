module Main exposing (..)

import Html exposing (Html, div, pre, text)
import Html.Attributes exposing (value, selected, style)
import Dosar


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { dosare : List Dosar.Model
    , dosarDeschis : Maybe Dosar.Model
    , subscription : Sub Msg
    }


initialModel : Model
initialModel =
    { dosare = []
    , dosarDeschis = Just Dosar.empty
    , subscription = Sub.none
    }


type Msg
    = Update Model (Cmd Msg) (Sub Msg)
    | SetDosar Dosar.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update model cmd sub ->
            ( { model | subscription = sub }, cmd )

        SetDosar dosarMsg ->
            case model.dosarDeschis of
                Just v ->
                    ( { model | dosarDeschis = Just (Dosar.update dosarMsg v) }, Cmd.none )

                Nothing ->
                    ( { model | dosarDeschis = Nothing }, Cmd.none )


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
            Dosar.view dosar SetDosar
