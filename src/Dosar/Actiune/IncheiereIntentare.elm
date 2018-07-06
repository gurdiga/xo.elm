module Dosar.Actiune.IncheiereIntentare exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere as RezultatIncercareConciliere exposing (RezultatIncercareConciliere)

import Html.Styled exposing (Html, button, div, fieldset, h1, legend, map, p, text)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)
import Utils.MyDate as MyDate
import Utils.RichTextEditor2 as RichTextEditor2
import Widgets.DateField as DateField


type alias Model =
    { html : RichTextEditor2.Model
    , borderouDeCalcul : RichTextEditor2.Model
    , copieIncheiere : DocumentScanat
    , termenConciliere : MyDate.Model

    -- , rezultatIncercareConciliere : RezultatIncercareConciliere
    }


initialModel : Model
initialModel =
    { html = RichTextEditor2.initialModel
    , borderouDeCalcul = RichTextEditor2.initialModel
    , copieIncheiere = DocumentScanat.empty
    , termenConciliere = MyDate.empty

    -- , rezultatIncercareConciliere = RezultatIncercareConciliere.empty
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , RichTextEditor2.view "Textul încheierii:" model.html |> map SetHtml
        , RichTextEditor2.view "Borderou de calcul:" model.borderouDeCalcul |> map SetBorderouDeCalcul

        -- , DocumentScanat.view
        --     { labelText = "Copia încheierii:"
        --     , documentScanat = data.copieIncheiere
        --     , callback = \v -> c { data | copieIncheiere = v }
        --     }
        , -- LATER: Check that the date is reasonable? In the near future?
          DateField.view "Termen de conciliere:" model.termenConciliere |> map SetTermenConciliere

        -- , RezultatIncercareConciliere.view
        --     data.rezultatIncercareConciliere
        --     (\v -> callback (Model { data | rezultatIncercareConciliere = v }))
        ]


type Msg
    = SetTermenConciliere DateField.Msg
    | SetHtml RichTextEditor2.Msg
    | SetBorderouDeCalcul RichTextEditor2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenConciliere msgDateField ->
            { model | termenConciliere = DateField.update msgDateField model.termenConciliere }

        SetHtml msgRichTextEditor2 ->
            { model | html = RichTextEditor2.update msgRichTextEditor2 model.html }

        SetBorderouDeCalcul msgRichTextEditor2 ->
            { model | borderouDeCalcul = RichTextEditor2.update msgRichTextEditor2 model.borderouDeCalcul }
