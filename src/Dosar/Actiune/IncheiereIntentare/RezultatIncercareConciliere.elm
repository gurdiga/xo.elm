module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere as PartileNuAjungLaIntelegere
import Html exposing (Html, div, fieldset, label, legend, map, text)
import Widgets.Select as Select


type Model
    = PartileAjungLaIntelegere PartileAjungLaIntelegere.Model
    | PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.Model


initialModel : Model
initialModel =
    PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.initialModel


valuesWithLabels : List ( Model, String )
valuesWithLabels =
    [ ( PartileAjungLaIntelegere PartileAjungLaIntelegere.initialModel
      , "părțile ajung la înțelegere"
      )
    , ( PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.initialModel
      , "părțile nu ajung la înțelegere"
      )
    ]


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ dropdown model ]
        , fields model
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select.view
        { label = "RezultatIncercareConciliere:"
        , defaultValue = taggedInitialModelFor model
        , valuesWithLabels = valuesWithLabels
        , onInput = Set
        }


taggedInitialModelFor : Model -> Model
taggedInitialModelFor model =
    case model of
        PartileAjungLaIntelegere _ ->
            PartileAjungLaIntelegere PartileAjungLaIntelegere.initialModel

        PartileNuAjungLaIntelegere _ ->
            PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.initialModel


fields : Model -> Html Msg
fields model =
    case model of
        PartileAjungLaIntelegere v ->
            PartileAjungLaIntelegere.view v |> map (SetPartileAjungLaIntelegere v)

        PartileNuAjungLaIntelegere v ->
            PartileNuAjungLaIntelegere.view v |> map (SetPartileNuAjungLaIntelegere v)


type Msg
    = Set Model
    | SetPartileAjungLaIntelegere PartileAjungLaIntelegere.Model PartileAjungLaIntelegere.Msg
    | SetPartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.Model PartileNuAjungLaIntelegere.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set v ->
            v

        SetPartileAjungLaIntelegere v m ->
            PartileAjungLaIntelegere (PartileAjungLaIntelegere.update m v)

        SetPartileNuAjungLaIntelegere v m ->
            PartileNuAjungLaIntelegere (PartileNuAjungLaIntelegere.update m v)
