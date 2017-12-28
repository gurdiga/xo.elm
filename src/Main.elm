module Main exposing (..)

import Html exposing (Html, h1, section, div, text, select, option, node, button)
import Html.Events exposing (onClick)
import UI.Layout as Layout
import Dosar


main : Program Never Model Msg
main =
    Html.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


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
            |> Maybe.withDefault createDosarButton
        ]


dosarView : Dosar.Model -> Html Msg
dosarView dosar =
    Dosar.view dosar |> Html.map SetDosar


createDosarButton : Html Msg
createDosarButton =
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
    Dosar.subscriptions
        |> List.map (Sub.map SetDosar)
        |> Sub.batch
