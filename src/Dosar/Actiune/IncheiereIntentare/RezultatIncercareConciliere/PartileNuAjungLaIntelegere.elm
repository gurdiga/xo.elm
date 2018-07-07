module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare as MasuriDeAsigurare exposing (MasuriDeAsigurare)

import Html.Styled exposing (Html, fieldset, legend, map, p, text)
import Utils.MyDate as MyDate
import Utils.RichTextEditor2 as RichTextEditor2
import Widgets.DateField as DateField


type alias Model =
    { procesVerbalContinuare : RichTextEditor2.Model
    , incheiereContinuare : RichTextEditor2.Model
    , borderouDeCalcul : RichTextEditor2.Model
    , termenDeExecutare : MyDate.Model

    -- , masuriDeAsigurare : MasuriDeAsigurare
    }


initialModel : Model
initialModel =
    { procesVerbalContinuare = RichTextEditor2.initialModel
    , incheiereContinuare = RichTextEditor2.initialModel
    , borderouDeCalcul = RichTextEditor2.initialModel
    , termenDeExecutare = MyDate.empty

    -- , masuriDeAsigurare = MasuriDeAsigurare.empty
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PartileNuAjungLaIntelegere" ]
        , DateField.view "Termen de executare:" model.termenDeExecutare |> map SetTermenDeExecutare
        , RichTextEditor2.view "Formează proces-verbal de continuare" model.procesVerbalContinuare |> map SetProcesVerbalContinuare
        , RichTextEditor2.view "Formează încheiere de continuare" model.incheiereContinuare |> map SetIncheiereContinuare
        , RichTextEditor2.view "Formează borderou de calcul" model.borderouDeCalcul |> map SetBorderouDeCalcul

        -- , MasuriDeAsigurare.view data.masuriDeAsigurare
        --     (\v ->
        --         Model { data | masuriDeAsigurare = v } |> callback
        --     )
        ]


type Msg
    = SetTermenDeExecutare DateField.Msg
    | SetProcesVerbalContinuare RichTextEditor2.Msg
    | SetIncheiereContinuare RichTextEditor2.Msg
    | SetBorderouDeCalcul RichTextEditor2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenDeExecutare msgDateField ->
            { model | termenDeExecutare = DateField.update msgDateField model.termenDeExecutare }

        SetProcesVerbalContinuare msgRichTextEditor2 ->
            { model | procesVerbalContinuare = RichTextEditor2.update msgRichTextEditor2 model.procesVerbalContinuare }

        SetIncheiereContinuare msgRichTextEditor2 ->
            { model | incheiereContinuare = RichTextEditor2.update msgRichTextEditor2 model.incheiereContinuare }

        SetBorderouDeCalcul msgRichTextEditor2 ->
            { model | borderouDeCalcul = RichTextEditor2.update msgRichTextEditor2 model.borderouDeCalcul }
