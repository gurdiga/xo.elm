module Main exposing (..)

import Html exposing (Html, div, pre, text)
import Html.Attributes exposing (value, selected, style)
import UI.Layout as Layout
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
    , dosarDeschis = Just Dosar.empty
    , subscription = Sub.none
    }


type Msg
    = Update Model (Cmd Msg) (Sub Msg)
    | DeschideDosar Dosar (Cmd Msg) (Sub Msg)
    | InchideDosarDeschis (Cmd Msg) (Sub Msg)
    | DosarMsg Dosar.Msg (Cmd Msg) (Sub Msg)


view : Model -> Html Msg
view model =
    Layout.view
        [ dosarView model
        , pre [ style [ ( "white-space", "normal" ), ( "margin-bottom", "5em" ) ] ] [ text (toString model) ]
        ]


dosarView : Model -> Html Msg
dosarView model =
    case model.dosarDeschis of
        Just dosar ->
            -- TODO: Begin again
            -- Inline Dosar.view and see what happens. Hold extraction until it’s obvious.
            Dosar.view dosar DosarMsg

        Nothing ->
            text ""


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update model cmd sub ->
            ( { model | subscription = sub }, cmd )

        DeschideDosar dosar cmd sub ->
            ( { model | dosarDeschis = Just dosar }, cmd )

        InchideDosarDeschis cmd sub ->
            ( { model | dosarDeschis = Nothing }, cmd )

        DosarMsg msg cmd sub ->
            case model.dosarDeschis of
                Just dosar ->
                    ( { model | dosarDeschis = Just (Dosar.update msg dosar) }, cmd )

                Nothing ->
                    ( { model | dosarDeschis = Nothing }, cmd )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ model.subscription ]
