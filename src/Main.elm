module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)


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
    { folders : List Folder
    , openedFolder : Maybe Folder
    }


type alias Folder =
    { id : String
    }


init : ( Model, Cmd Msg )
init =
    let
        initialModel =
            { folders = []
            , openedFolder = Nothing
            }
    in
        ( initialModel
        , Cmd.none
        )



-- UPDATE


type Msg
    = None


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        None ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Hello World!" ]
        , pre [] [ text (toString model) ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
