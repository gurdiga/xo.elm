module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare as IncheiereIncetare
import Html exposing (Html, fieldset, legend, map, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Widgets.RichTextEditor3 as RichTextEditor3


type alias Model =
    { procesVerbalConsemnareConditiiExecutare : String
    , copieProcesVerbalConsemnareConditiiExecutare : DocumentScanat2.Model
    , procesVerbalConstatareExecutare : String
    , copieProcesVerbalConstatareExecutare : DocumentScanat2.Model
    , incheiereIncetare : IncheiereIncetare.Model
    }


initialModel : Model
initialModel =
    { procesVerbalConsemnareConditiiExecutare = ""
    , copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.initialModel
    , procesVerbalConstatareExecutare = ""
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
        , RichTextEditor3.view
            "Formează proces-verbal de constatare a executării"
            model.procesVerbalConstatareExecutare
            SetProcesVerbalConstatareExecutare
        , DocumentScanat2.view
            "Copia semnată a procesului-verbal de constatare a executării"
            model.copieProcesVerbalConstatareExecutare
            |> map SetCopieProcesVerbalConstatareExecutare
        , IncheiereIncetare.view model.incheiereIncetare |> map SetIncheiereIncetare
        ]


type Msg
    = SetProcesVerbalConsemnareConditiiExecutare String
    | SetCopieProcesVerbalConsemnareConditiiExecutare DocumentScanat2.Msg
    | SetProcesVerbalConstatareExecutare String
    | SetCopieProcesVerbalConstatareExecutare DocumentScanat2.Msg
    | SetIncheiereIncetare IncheiereIncetare.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetProcesVerbalConsemnareConditiiExecutare v ->
            { model | procesVerbalConsemnareConditiiExecutare = v }

        SetCopieProcesVerbalConsemnareConditiiExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetProcesVerbalConstatareExecutare v ->
            { model | procesVerbalConstatareExecutare = v }

        SetCopieProcesVerbalConstatareExecutare msgDocumentScanat2 ->
            { model | copieProcesVerbalConstatareExecutare = DocumentScanat2.update msgDocumentScanat2 model.copieProcesVerbalConstatareExecutare }

        SetIncheiereIncetare msgIncheiereIncetare ->
            { model | incheiereIncetare = IncheiereIncetare.update msgIncheiereIncetare model.incheiereIncetare }
