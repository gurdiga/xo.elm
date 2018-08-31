module Main exposing (..)

import Browser
import Dosar
import Html exposing (Html, button, div, h1, map, node, option, section, select, text)
import Html.Events exposing (onClick)
import UI.Layout as Layout


type alias Flags =
    ()


main : Program Flags Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( initialModel, Cmd.none )


type Model
    = Model
        { dosarDeschis : Maybe Dosar.Model
        }


initialModel : Model
initialModel =
    Model
        { dosarDeschis = Just Dosar.initialModel
        }


type Msg
    = CreateDosar
    | SetDosar Dosar.Msg


view : Model -> Html Msg
view (Model model) =
    Layout.view
        [ model.dosarDeschis
            |> Maybe.map dosarView
            |> Maybe.withDefault createDosarButtonView
        ]


dosarView : Dosar.Model -> Html Msg
dosarView dosar =
    Dosar.view dosar |> map SetDosar


createDosarButtonView : Html Msg
createDosarButtonView =
    button [ onClick CreateDosar ] [ text "Crează dosar nou" ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
    case msg of
        CreateDosar ->
            ( Model { model | dosarDeschis = Just Dosar.initialModel }, Cmd.none )

        SetDosar dosarMsg ->
            case model.dosarDeschis of
                Just dosar ->
                    ( Model { model | dosarDeschis = Just (Dosar.update dosarMsg dosar) }, Cmd.none )

                Nothing ->
                    ( Model model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
