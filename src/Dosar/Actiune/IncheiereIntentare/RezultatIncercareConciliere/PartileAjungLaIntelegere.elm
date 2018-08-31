module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare as IncheiereIncetare
import Html exposing (Html, fieldset, legend, map, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Utils.RichTextEditor2 as RichTextEditor2


type alias Model =
    { procesVerbalConsemnareConditiiExecutare : RichTextEditor2.Model
    , copieProcesVerbalConsemnareConditiiExecutare : DocumentScanat2.Model
    , procesVerbalConstatareExecutare : RichTextEditor2.Model
    , copieProcesVerbalConstatareExecutare : DocumentScanat2.Model
    , incheiereIncetare : IncheiereIncetare.Model
    }


initialModel : Model
initialModel =
    { procesVerbalConsemnareConditiiExecutare = RichTextEditor2.initialModel
    , copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.initialModel
    , procesVerbalConstatareExecutare = RichTextEditor2.initialModel
    , copieProcesVerbalConstatareExecutare = DocumentScanat2.initialModel
    , incheiereIncetare = IncheiereIncetare.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PartileAjungLaIntelegere" ]
        , RichTextEditor2.view
            "Formează proces-verbal de consemnare condițiilor de executare"
            model.procesVerbalConsemnareConditiiExecutare
            |> map SetProcesVerbalConsemnareConditiiExecutare
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
    = SetProcesVerbalConsemnareConditiiExecutare RichTextEditor2.Msg
    | SetCopieProcesVerbalConsemnareConditiiExecutare DocumentScanat2.Msg
    | SetProcesVerbalConstatareExecutare RichTextEditor2.Msg
    | SetCopieProcesVerbalConstatareExecutare DocumentScanat2.Msg
    | SetIncheiereIncetare IncheiereIncetare.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetProcesVerbalConsemnareConditiiExecutare msgRichTextEditor2 ->
            { model | procesVerbalConsemnareConditiiExecutare = RichTextEditor2.update msgRichTextEditor2 model.procesVerbalConsemnareConditiiExecutare }

        SetCopieProcesVerbalConsemnareConditiiExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetProcesVerbalConstatareExecutare msgRichTextEditor2 ->
            { model | procesVerbalConstatareExecutare = RichTextEditor2.update msgRichTextEditor2 model.procesVerbalConstatareExecutare }

        SetCopieProcesVerbalConstatareExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConstatareExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetIncheiereIncetare msgIncheiereIncetare ->
            { model | incheiereIncetare = IncheiereIncetare.update msgIncheiereIncetare model.incheiereIncetare }
