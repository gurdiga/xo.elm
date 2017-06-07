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


type Folder
    = Folder ID Grounds


type alias ID =
    String


type Grounds
    = Grounds String


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { folders = []
    , openedFolder =
        Just (updatedFolder (Folder "I" (Grounds "YES")))
    }


newFolder : Maybe Folder
newFolder =
    Just
        (Folder
            "001"
            (Grounds "Something")
        )


updatedFolder : Folder -> Folder
updatedFolder folder =
    case folder of
        Folder id grounds ->
            Folder (id ++ "-updated") grounds



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
