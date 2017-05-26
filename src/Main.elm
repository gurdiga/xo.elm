module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Regex


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    , showValidationResults : Bool
    }


model : Model
model =
    { name = ""
    , password = ""
    , passwordAgain = ""
    , age = ""
    , showValidationResults = False
    }



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Check


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | showValidationResults = False, name = name }

        Password password ->
            { model | showValidationResults = False, password = password }

        PasswordAgain password ->
            { model | showValidationResults = False, passwordAgain = password }

        Age age ->
            { model | showValidationResults = False, age = age }

        Check ->
            { model | showValidationResults = True }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , input [ type_ "text", placeholder "How old are you?", onInput Age ] []
        , button [ onClick Check ] [ text "Check!" ]
        , if model.showValidationResults then
            viewValidation model
          else
            div [] []
        ]


viewValidation : Model -> Html msg
viewValidation model =
    let
        hasAge =
            String.length model.age > 0

        hasPassword =
            String.length model.password > 0 || String.length model.passwordAgain > 0

        ( color, message ) =
            if hasAge && not (isNumber model.age) then
                ( "tomato", "Age should be a whole positive number" )
            else if hasPassword && not (isComplexEnough model.password) then
                ( "tomato", "Password is too simple" )
            else if hasPassword && String.length model.password < 8 then
                ( "brown", "Password too short!" )
            else if hasPassword && model.password /= model.passwordAgain then
                ( "red", "Passwords do not match!" )
            else
                ( "green", "OK" )
    in
        div [ style [ ( "color", color ) ] ] [ text message ]


isComplexEnough : String -> Bool
isComplexEnough string =
    Regex.contains (Regex.regex "[A-Z]") string
        && Regex.contains (Regex.regex "[a-z]") string
        && Regex.contains (Regex.regex "[0-9]") string


isNumber : String -> Bool
isNumber string =
    Regex.contains (Regex.regex "[0-9]") string
