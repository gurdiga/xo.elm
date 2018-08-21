module Dosar.Actiune exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare
import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz
import Html.Styled exposing (Html, fieldset, label, legend, map, text)
import Widgets.Select4 as Select4


type Model
    = IncheiereIntentare IncheiereIntentare.Model
    | IncheiereRefuz IncheiereRefuz.Model


valuesWithLabels : List ( Model, String )
valuesWithLabels =
    [ ( IncheiereIntentare IncheiereIntentare.initialModel, "intentare" )
    , ( IncheiereRefuz IncheiereRefuz.initialModel, "refuz" )
    ]


initialModel : Model
initialModel =
    IncheiereIntentare IncheiereIntentare.initialModel


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "Actiune" ]
        , dropdown model
        , fields model
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select4.view <|
        Select4.config
            { label = "Actiune:"
            , valuesWithLabels = valuesWithLabels
            , defaultValue = model
            , onInput = Set
            }


fields : Model -> Html Msg
fields actiune =
    case actiune of
        IncheiereIntentare modelIncheiereIntentare ->
            IncheiereIntentare.view modelIncheiereIntentare |> map SetIncheiereIntentare

        IncheiereRefuz modelIncheiereRefuz ->
            IncheiereRefuz.view modelIncheiereRefuz |> map SetIncheiereIntentare


type Msg
    = Set Model
    | SetIncheiereIntentare IncheiereIntentare.Msg
    | SetIncheiereRefuz IncheiereRefuz.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set v ->
            v

        SetIncheiereIntentare msgIncheiereIntentare ->
            case model of
                IncheiereIntentare modelIncheiereIntentare ->
                    IncheiereIntentare (IncheiereIntentare.update msgIncheiereIntentare modelIncheiereIntentare)

                IncheiereRefuz modelIncheiereRefuz ->
                    Debug.crash "SetIncheiereIntentare cant have a IncheiereRefuz"

        SetIncheiereRefuz msgIncheiereRefuz ->
            case model of
                IncheiereRefuz modelIncheiereRefuz ->
                    IncheiereRefuz (IncheiereRefuz.update msgIncheiereRefuz modelIncheiereRefuz)

                IncheiereIntentare modelIncheiereIntentare ->
                    Debug.crash "SetIncheiereRefuz cant have a IncheiereIntentare"
