module Main exposing (..)

import Html exposing (Html, div, pre, text)
import Html.Attributes exposing (value, selected, style)
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
    }



-- UPDATE


type Msg
    = UpdateDosar Dosar


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateDosar dosar ->
            ( { model | dosarDeschis = Just dosar }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ dosarView model.dosarDeschis
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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
