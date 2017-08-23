module Main exposing (..)

import Html exposing (Html, h1, div, pre, text)
import Html.Attributes exposing (value, selected, style)
import Dosar exposing (Dosar)
import Material
import Material.Scheme as Scheme
import Material.Layout as Layout
import Material.Color as Color


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
    , mdl : Material.Model
    , selectedTab : Int
    }


initialModel : Model
initialModel =
    { dosare = []
    , dosarDeschis = Just Dosar.empty
    , subscription = Sub.none
    , mdl = Material.model
    , selectedTab = 0
    }


type Msg
    = Update Model (Cmd Msg) (Sub Msg)
    | Mdl (Material.Msg Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Update model cmd sub ->
            ( { model | subscription = sub }, cmd )

        Mdl msg ->
            Material.update msg model


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ model.subscription ]


view : Model -> Html Msg
view model =
    Scheme.topWithScheme Color.Teal Color.LightGreen <|
        Layout.render Mdl
            model.mdl
            [ Layout.fixedHeader
            , Layout.selectedTab model.selectedTab
            , Layout.onSelectTab (\v -> Update { model | selectedTab = v } Cmd.none Sub.none)
            ]
            { header = [ h1 [ style [ ( "padding", "2rem" ) ] ] [ text "Counter" ] ]
            , drawer = []
            , tabs = ( [ text "Milk", text "Oranges" ], [] )
            , main = [ viewBody model ]
            }


viewBody : Model -> Html Msg
viewBody model =
    div
        []
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
