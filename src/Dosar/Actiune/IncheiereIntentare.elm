module Dosar.Actiune.IncheiereIntentare exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere as RezultatIncercareConciliere
import Html.Styled exposing (Html, button, div, fieldset, h1, legend, map, p, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Utils.MyDate as MyDate
import Utils.RichTextEditor2 as RichTextEditor2
import Widgets.DateField as DateField


type alias Model =
    { html : RichTextEditor2.Model
    , borderouDeCalcul : RichTextEditor2.Model
    , copieIncheiere : DocumentScanat2.Model
    , termenConciliere : MyDate.Model
    , rezultatIncercareConciliere : RezultatIncercareConciliere.Model
    }


initialModel : Model
initialModel =
    { html = RichTextEditor2.initialModel
    , borderouDeCalcul = RichTextEditor2.initialModel
    , copieIncheiere = DocumentScanat2.initialModel
    , termenConciliere = MyDate.empty
    , rezultatIncercareConciliere = RezultatIncercareConciliere.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , RichTextEditor2.view "Textul încheierii:" model.html |> map SetHtml
        , RichTextEditor2.view "Borderou de calcul:" model.borderouDeCalcul |> map SetBorderouDeCalcul
        , DocumentScanat2.view "Copia încheierii:" model.copieIncheiere |> map SetCopieIncheiere
        , -- LATER: Check that the date is reasonable? In the near future?
          DateField.view "Termen de conciliere:" model.termenConciliere |> map SetTermenConciliere
        , RezultatIncercareConciliere.view model.rezultatIncercareConciliere |> map SetRezultatIncercareConciliere
        ]


type Msg
    = SetTermenConciliere DateField.Msg
    | SetHtml RichTextEditor2.Msg
    | SetBorderouDeCalcul RichTextEditor2.Msg
    | SetCopieIncheiere DocumentScanat2.Msg
    | SetRezultatIncercareConciliere RezultatIncercareConciliere.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenConciliere msgDateField ->
            { model | termenConciliere = DateField.update msgDateField model.termenConciliere }

        SetHtml msgRichTextEditor2 ->
            { model | html = RichTextEditor2.update msgRichTextEditor2 model.html }

        SetBorderouDeCalcul msgRichTextEditor2 ->
            { model | borderouDeCalcul = RichTextEditor2.update msgRichTextEditor2 model.borderouDeCalcul }

        SetCopieIncheiere msgDocumentScanat2 ->
            { model | copieIncheiere = DocumentScanat2.update msgDocumentScanat2 model.copieIncheiere }

        SetRezultatIncercareConciliere msgRezultatIncercareConciliere ->
            { model | rezultatIncercareConciliere = RezultatIncercareConciliere.update msgRezultatIncercareConciliere model.rezultatIncercareConciliere }
