module Dosar.Actiune exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare
import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz
import Html exposing (Html, fieldset, label, legend, map, text)
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
    IncheiereRefuz IncheiereRefuz.initialModel


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
            , defaultValue = taggedInitialModelFor model
            , onInput = Set
            }


taggedInitialModelFor : Model -> Model
taggedInitialModelFor model =
    case model of
        IncheiereIntentare _ ->
            IncheiereIntentare IncheiereIntentare.initialModel

        IncheiereRefuz _ ->
            IncheiereRefuz IncheiereRefuz.initialModel


fields : Model -> Html Msg
fields model =
    case model of
        IncheiereIntentare v ->
            IncheiereIntentare.view v |> map (SetIncheiereIntentare v)

        IncheiereRefuz v ->
            IncheiereRefuz.view v |> map (SetIncheiereRefuz v)


type Msg
    = Set Model
    | SetIncheiereIntentare IncheiereIntentare.Model IncheiereIntentare.Msg
    | SetIncheiereRefuz IncheiereRefuz.Model IncheiereRefuz.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set v ->
            v

        SetIncheiereIntentare v m ->
            IncheiereIntentare (IncheiereIntentare.update m v)

        SetIncheiereRefuz v m ->
            IncheiereRefuz (IncheiereRefuz.update m v)
