module Dosar.Actiune.IncheiereIntentare exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere as RezultatIncercareConciliere
import Html exposing (Html, button, div, fieldset, h1, legend, map, p, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Utils.File as File exposing (File)
import Utils.MyDate as MyDate
import Widgets.RichTextEditor3 as RichTextEditor3
import Widgets.DateField as DateField
import Widgets.DocumentScanat3 as DocumentScanat3


type alias Model =
    { html : String
    , borderouDeCalcul : String
    , copieIncheiere : File
    , termenConciliere : MyDate.Model
    , rezultatIncercareConciliere : RezultatIncercareConciliere.Model
    }


initialModel : Model
initialModel =
    { html = ""
    , borderouDeCalcul = ""
    , copieIncheiere = File.empty
    , termenConciliere = MyDate.empty
    , rezultatIncercareConciliere = RezultatIncercareConciliere.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , RichTextEditor3.view "Textul încheierii:" model.html SetHtml
        , RichTextEditor3.view "Borderou de calcul:" model.borderouDeCalcul SetBorderouDeCalcul
        , DocumentScanat3.view "Copia încheierii:" SetCopieIncheiere
        , -- LATER: Check that the date is reasonable? In the near future?
          DateField.view "Termen de conciliere:" model.termenConciliere SetTermenConciliere
        , RezultatIncercareConciliere.view model.rezultatIncercareConciliere |> map SetRezultatIncercareConciliere
        ]


type Msg
    = SetTermenConciliere MyDate.Model
    | SetHtml String
    | SetBorderouDeCalcul String
    | SetCopieIncheiere File
    | SetRezultatIncercareConciliere RezultatIncercareConciliere.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenConciliere v ->
            { model | termenConciliere = v }

        SetHtml v ->
            { model | html = v }

        SetBorderouDeCalcul v ->
            { model | borderouDeCalcul = v }

        SetCopieIncheiere v ->
            { model | copieIncheiere = v }

        SetRezultatIncercareConciliere msgRezultatIncercareConciliere ->
            { model | rezultatIncercareConciliere = RezultatIncercareConciliere.update msgRezultatIncercareConciliere model.rezultatIncercareConciliere }
