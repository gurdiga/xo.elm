module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (value, selected, style)
import Html.Events exposing (..)
import Procedure
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
    { processes : List Procedure.Type
    , openedProcedure : Maybe Procedure.Type
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )


initialModel : Model
initialModel =
    { processes = []
    , openedProcedure = Just Procedure.newValue
    }



-- UPDATE


type Msg
    = ChangeOpenedProcedure Procedure.Type


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeOpenedProcedure newOpenedProcedure ->
            ( { model | openedProcedure = Just newOpenedProcedure }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ procedureFields model.openedProcedure
        , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
        ]


procedureFields : Maybe Procedure.Type -> Html Msg
procedureFields maybeProcedure =
    case maybeProcedure of
        Nothing ->
            text ""

        Just procedure ->
            Procedure.view procedure ChangeOpenedProcedure



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
