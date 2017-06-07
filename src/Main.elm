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
    { id : ID
    , grounds : Grounds
    }


type alias ID =
    String


type alias Grounds =
    String


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { folders = []
    , openedFolder =
        Just (updatedFolder newFolder)
    }


newFolder : Folder
newFolder =
    { id = "001"
    , grounds = "Something"
    }


updatedFolder : Folder -> Folder
updatedFolder ({ id, grounds } as folder) =
    { folder | id = id ++ "-updated" }



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
