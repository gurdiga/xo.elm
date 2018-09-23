module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare as IncheiereIncetare
import Html exposing (Html, fieldset, legend, map, text)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.RichTextEditor3 as RichTextEditor3


type alias Model =
    { procesVerbalConsemnareConditiiExecutare : String
    , copieProcesVerbalConsemnareConditiiExecutare : DocumentScanat3.Model
    , procesVerbalConstatareExecutare : String
    , copieProcesVerbalConstatareExecutare : DocumentScanat3.Model
    , incheiereIncetare : IncheiereIncetare.Model
    }


initialModel : Model
initialModel =
    { procesVerbalConsemnareConditiiExecutare = ""
    , copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat3.initialModel
    , procesVerbalConstatareExecutare = ""
    , copieProcesVerbalConstatareExecutare = DocumentScanat3.initialModel
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
        , DocumentScanat3.view
            "Copia semnată a procesului-verbal de consemnare a condițiilor de executare"
            SetCopieProcesVerbalConsemnareConditiiExecutare
        , RichTextEditor3.view
            "Formează proces-verbal de constatare a executării"
            model.procesVerbalConstatareExecutare
            SetProcesVerbalConstatareExecutare
        , DocumentScanat3.view
            "Copia semnată a procesului-verbal de constatare a executării"
            SetCopieProcesVerbalConstatareExecutare
        , IncheiereIncetare.view model.incheiereIncetare |> map SetIncheiereIncetare
        ]


type Msg
    = SetProcesVerbalConsemnareConditiiExecutare String
    | SetCopieProcesVerbalConsemnareConditiiExecutare DocumentScanat3.Model
    | SetProcesVerbalConstatareExecutare String
    | SetCopieProcesVerbalConstatareExecutare DocumentScanat3.Model
    | SetIncheiereIncetare IncheiereIncetare.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetProcesVerbalConsemnareConditiiExecutare v ->
            { model | procesVerbalConsemnareConditiiExecutare = v }

        SetCopieProcesVerbalConsemnareConditiiExecutare v ->
            { model | copieProcesVerbalConsemnareConditiiExecutare = v }

        SetProcesVerbalConstatareExecutare v ->
            { model | procesVerbalConstatareExecutare = v }

        SetCopieProcesVerbalConstatareExecutare v ->
            { model | copieProcesVerbalConstatareExecutare = v }

        SetIncheiereIncetare msgIncheiereIncetare ->
            { model | incheiereIncetare = IncheiereIncetare.update msgIncheiereIncetare model.incheiereIncetare }
