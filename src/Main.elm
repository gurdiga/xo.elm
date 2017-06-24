module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value, selected, style)
import Html.Events exposing (..)
import Dosar
import Select


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
    { dosare : List Dosar.Type
    , dosarDeschis : Maybe Dosar.Type
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
    = UpdateDosar Dosar.Type


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateDosar newOpenedProcedure ->
            ( { model | dosarDeschis = Just newOpenedProcedure }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ dosarView model.dosarDeschis
        , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
        ]


dosarView : Maybe Dosar.Type -> Html Msg
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
