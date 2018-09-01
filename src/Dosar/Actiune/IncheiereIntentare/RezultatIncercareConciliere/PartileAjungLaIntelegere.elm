module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare as IncheiereIncetare
import Html exposing (Html, fieldset, legend, map, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Utils.RichTextEditor2 as RichTextEditor2
import Utils.RichTextEditor3 as RichTextEditor3


type alias Model =
    { procesVerbalConsemnareConditiiExecutare : String
    , copieProcesVerbalConsemnareConditiiExecutare : DocumentScanat2.Model
    , procesVerbalConstatareExecutare : RichTextEditor2.Model
    , copieProcesVerbalConstatareExecutare : DocumentScanat2.Model
    , incheiereIncetare : IncheiereIncetare.Model
    }


initialModel : Model
initialModel =
    { procesVerbalConsemnareConditiiExecutare = ""
    , copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.initialModel
    , procesVerbalConstatareExecutare = RichTextEditor2.initialModel
    , copieProcesVerbalConstatareExecutare = DocumentScanat2.initialModel
    , incheiereIncetare = IncheiereIncetare.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PartileAjungLaIntelegere" ]
        , RichTextEditor3.view
            "Formează proces-verbal de consemnare condițiilor de executare"
            model.procesVerbalConsemnareConditiiExecutare
            SetProcesVerbalConsemnareConditiiExecutare
        , DocumentScanat2.view
            "Copia semnată a procesului-verbal de consemnare a condițiilor de executare"
            model.copieProcesVerbalConsemnareConditiiExecutare
            |> map SetCopieProcesVerbalConsemnareConditiiExecutare
        , RichTextEditor2.view
            "Formează proces-verbal de constatare a executării"
            model.procesVerbalConstatareExecutare
            |> map SetProcesVerbalConstatareExecutare
        , DocumentScanat2.view
            "Copia semnată a procesului-verbal de constatare a executării"
            model.copieProcesVerbalConstatareExecutare
            |> map SetCopieProcesVerbalConstatareExecutare
        , IncheiereIncetare.view model.incheiereIncetare |> map SetIncheiereIncetare
        ]


type Msg
    = SetProcesVerbalConsemnareConditiiExecutare String
    | SetCopieProcesVerbalConsemnareConditiiExecutare DocumentScanat2.Msg
    | SetProcesVerbalConstatareExecutare RichTextEditor2.Msg
    | SetCopieProcesVerbalConstatareExecutare DocumentScanat2.Msg
    | SetIncheiereIncetare IncheiereIncetare.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetProcesVerbalConsemnareConditiiExecutare v ->
            { model | procesVerbalConsemnareConditiiExecutare = v }

        SetCopieProcesVerbalConsemnareConditiiExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetProcesVerbalConstatareExecutare msgRichTextEditor2 ->
            { model | procesVerbalConstatareExecutare = RichTextEditor2.update msgRichTextEditor2 model.procesVerbalConstatareExecutare }

        SetCopieProcesVerbalConstatareExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConstatareExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetIncheiereIncetare msgIncheiereIncetare ->
            { model | incheiereIncetare = IncheiereIncetare.update msgIncheiereIncetare model.incheiereIncetare }
