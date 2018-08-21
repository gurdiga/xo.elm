module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere as PartileNuAjungLaIntelegere
import Html.Styled exposing (Html, div, fieldset, label, legend, map, text)
import Widgets.Select4 as Select4


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
    Select4.view <|
        Select4.config
            { label = "RezultatIncercareConciliere 4:"
            , defaultValue = model
            , valuesWithLabels = valuesWithLabels
            , onInput = Set
            }


fields : Model -> Html Msg
fields rezultatIncercareConciliere =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere modelPartileAjungLaIntelegere ->
            PartileAjungLaIntelegere.view modelPartileAjungLaIntelegere |> map SetPartileAjungLaIntelegere

        PartileNuAjungLaIntelegere modelPartileNuAjungLaIntelegere ->
            PartileNuAjungLaIntelegere.view modelPartileNuAjungLaIntelegere |> map SetPartileNuAjungLaIntelegere


type Msg
    = SetPartileAjungLaIntelegere PartileAjungLaIntelegere.Msg
    | SetPartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.Msg
    | Set Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set v ->
            v

        SetPartileAjungLaIntelegere msgPartileAjungLaIntelegere ->
            case model of
                PartileAjungLaIntelegere modelPartileAjungLaIntelegere ->
                    PartileAjungLaIntelegere (PartileAjungLaIntelegere.update msgPartileAjungLaIntelegere modelPartileAjungLaIntelegere)

                PartileNuAjungLaIntelegere modelPartileNuAjungLaIntelegere ->
                    Debug.crash "SetPartileAjungLaIntelegere can’t be emitted with a PartileNuAjungLaIntelegere"

        SetPartileNuAjungLaIntelegere msgPartileNuAjungLaIntelegere ->
            case model of
                PartileNuAjungLaIntelegere modelPartileNuAjungLaIntelegere ->
                    PartileNuAjungLaIntelegere (PartileNuAjungLaIntelegere.update msgPartileNuAjungLaIntelegere modelPartileNuAjungLaIntelegere)

                PartileAjungLaIntelegere modelPartileAjungLaIntelegere ->
                    Debug.crash "SetPartileNuAjungLaIntelegere can’t be emitted with a PartileAjungLaIntelegere"
