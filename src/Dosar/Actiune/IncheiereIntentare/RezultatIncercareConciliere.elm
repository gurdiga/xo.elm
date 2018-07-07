module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere as PartileNuAjungLaIntelegere

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere as PartileAjungLaIntelegere
import Html.Styled exposing (Html, div, fieldset, label, legend, map, text)
import Widgets.Select3 as Select3


type RezultatIncercareConciliere
    = PartileAjungLaIntelegere PartileAjungLaIntelegere.Model



-- | PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.Model


type alias Model =
    { rezultatIncercareConciliere : RezultatIncercareConciliere
    , ui : Ui
    }


type alias Ui =
    { select : Select3.Model RezultatIncercareConciliere }


initialModel : Model
initialModel =
    { rezultatIncercareConciliere = initialRezultatIncercareConciliere
    , ui =
        { select = Select3.initialModel initialRezultatIncercareConciliere valuesWithLabels
        }
    }


initialRezultatIncercareConciliere : RezultatIncercareConciliere
initialRezultatIncercareConciliere =
    PartileAjungLaIntelegere PartileAjungLaIntelegere.initialModel


valuesWithLabels : List ( RezultatIncercareConciliere, String )
valuesWithLabels =
    [ ( PartileAjungLaIntelegere PartileAjungLaIntelegere.initialModel
      , "părțile ajung la înțelegere"
      )

    -- , ( PartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.empty
    --   , "părțile nu ajung la înțelegere"
    --   )
    ]


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ dropdown model ]
        , fields model.rezultatIncercareConciliere
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select3.view "RezultatIncercareConciliere:" model.ui.select |> map ResetRezultatIncercareConciliere


fields : RezultatIncercareConciliere -> Html Msg
fields rezultatIncercareConciliere =
    case rezultatIncercareConciliere of
        PartileAjungLaIntelegere modelPartileAjungLaIntelegere ->
            PartileAjungLaIntelegere.view modelPartileAjungLaIntelegere |> map SetPartileAjungLaIntelegere



-- PartileNuAjungLaIntelegere modelPartileNuAjungLaIntelegere ->
--     PartileNuAjungLaIntelegere.view modelPartileNuAjungLaIntelegere |> map SetPartileNuAjungLaIntelegere


type Msg
    = ResetRezultatIncercareConciliere (Select3.Msg RezultatIncercareConciliere)
    | SetPartileAjungLaIntelegere PartileAjungLaIntelegere.Msg



-- | SetPartileNuAjungLaIntelegere PartileNuAjungLaIntelegere.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ResetRezultatIncercareConciliere rezultatIncercareConciliereMsgSelect3 ->
            resetRezultatIncercareConciliere model (Select3.update rezultatIncercareConciliereMsgSelect3 model.ui.select)

        SetPartileAjungLaIntelegere msgPartileAjungLaIntelegere ->
            case model.rezultatIncercareConciliere of
                PartileAjungLaIntelegere modelPartileAjungLaIntelegere ->
                    { model | rezultatIncercareConciliere = PartileAjungLaIntelegere (PartileAjungLaIntelegere.update msgPartileAjungLaIntelegere modelPartileAjungLaIntelegere) }


resetRezultatIncercareConciliere : Model -> Select3.Model RezultatIncercareConciliere -> Model
resetRezultatIncercareConciliere ({ ui } as model) newSelect =
    { model
        | ui = { ui | select = newSelect }
        , rezultatIncercareConciliere = Select3.selectedValue newSelect
    }
