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
    = None
    | ChangeGrounds Grounds
    | ChangeCourtDecision CourtDecision.Type


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeGrounds newGrounds ->
            let
                newOpenedProcedure =
                    Maybe.map (\openedProcedure -> { openedProcedure | grounds = newGrounds }) model.openedProcedure
            in
                ( { model | openedProcedure = newOpenedProcedure }, Cmd.none )

        ChangeCourtDecision decision ->
            let
                newOpenedProcedure =
                    Maybe.map (\openedProcedure -> { openedProcedure | grounds = CourtDecision decision }) model.openedProcedure
            in
                ( { model | openedProcedure = newOpenedProcedure }, Cmd.none )

        None ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        currentGrounds =
            case model.openedProcedure of
                Nothing ->
                    CourtDecision CourtDecision.newValue

                Just process ->
                    process.grounds
    in
        div []
            [ h1 [] [ text "Procedură nouă" ]
            , label []
                [ text "Temeiul:"
                , Select.fromValuesWithLabels groundsWithLabels ChangeGrounds currentGrounds
                , groundsFields currentGrounds
                ]
            , pre [ style [ ( "white-space", "normal" ) ] ] [ text (toString model) ]
            ]


groundsFields : Grounds -> Html Msg
groundsFields grounds =
    case grounds of
        CourtDecision decision ->
            CourtDecision.fields decision ChangeCourtDecision

        CreditorPetition creditorPetition ->
            creditorPetitionFields creditorPetition

        MortgageCreditorPetition mortgageCreditorPetition ->
            mortgageCreditorPetitionFields mortgageCreditorPetition

        Takeover takeover ->
            takeoverFields takeover


creditorPetitionFields : CreditorPetitionValue -> Html Msg
creditorPetitionFields creditorPetition =
    div [] [ text <| "CreditorPetition" ++ (toString creditorPetition) ]


mortgageCreditorPetitionFields : MortgageCreditorPetitionValue -> Html Msg
mortgageCreditorPetitionFields mortgageCreditorPetition =
    div [] [ text <| "MortgageCreditorPetition" ++ (toString mortgageCreditorPetition) ]


takeoverFields : TakeoverValue -> Html Msg
takeoverFields takeover =
    div [] [ text <| "Takeover" ++ (toString takeover) ]


groundsWithLabels : List ( Grounds, String )
groundsWithLabels =
    [ ( CreditorPetition newCreditorPetitionValue
      , "cerere a creditorului"
      )
    , ( MortgageCreditorPetition newMortgageCreditorPetitionValue
      , "cerere a creditorului în temeiul contractului de ipotecă"
      )
    , ( CourtDecision CourtDecision.newValue
      , "demersul instanţei de judecată"
      )
    , ( Takeover {}
      , "preluarea unui document executoriu strămutat"
      )
    ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []
