module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare as MasuriDeAsigurare
import Html exposing (Html, fieldset, legend, map, p, text)
import Utils.MyDate as MyDate
import Widgets.RichTextEditor3 as RichTextEditor3
import Widgets.DateField as DateField


type alias Model =
    { procesVerbalContinuare : String
    , incheiereContinuare : String
    , borderouDeCalcul : String
    , termenDeExecutare : MyDate.Model
    , masuriDeAsigurare : MasuriDeAsigurare.Model
    }


initialModel : Model
initialModel =
    { procesVerbalContinuare = ""
    , incheiereContinuare = ""
    , borderouDeCalcul = ""
    , termenDeExecutare = MyDate.empty
    , masuriDeAsigurare = MasuriDeAsigurare.empty
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PartileNuAjungLaIntelegere" ]
        , DateField.view "Termen de executare:" model.termenDeExecutare SetTermenDeExecutare
        , RichTextEditor3.view "Formează proces-verbal de continuare" model.procesVerbalContinuare SetProcesVerbalContinuare
        , RichTextEditor3.view "Formează încheiere de continuare" model.incheiereContinuare SetIncheiereContinuare
        , RichTextEditor3.view "Formează borderou de calcul" model.borderouDeCalcul SetBorderouDeCalcul
        , MasuriDeAsigurare.view model.masuriDeAsigurare |> map SetMasuriDeAsigurare
        ]


type Msg
    = SetTermenDeExecutare MyDate.Model
    | SetProcesVerbalContinuare String
    | SetIncheiereContinuare String
    | SetBorderouDeCalcul String
    | SetMasuriDeAsigurare MasuriDeAsigurare.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenDeExecutare v ->
            { model | termenDeExecutare = v }

        SetProcesVerbalContinuare v ->
            { model | procesVerbalContinuare = v }

        SetIncheiereContinuare v ->
            { model | incheiereContinuare = v }

        SetBorderouDeCalcul v ->
            { model | borderouDeCalcul = v }

        SetMasuriDeAsigurare msgMasuriDeAsigurare ->
            { model | masuriDeAsigurare = MasuriDeAsigurare.update msgMasuriDeAsigurare model.masuriDeAsigurare }
