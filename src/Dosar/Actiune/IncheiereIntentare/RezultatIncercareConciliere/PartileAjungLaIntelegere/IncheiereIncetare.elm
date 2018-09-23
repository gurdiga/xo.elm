module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, h1, legend, map, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Widgets.RichTextEditor3 as RichTextEditor3


type alias Model =
    { text : String
    , copie : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { text = ""
    , copie = DocumentScanat2.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIncetare" ]
        , RichTextEditor3.view "Formează încheiere încetare:" model.text SetText
        , DocumentScanat2.view "Copia încheierii de încetare:" model.copie |> map SetCopie
        ]


type Msg
    = SetText String
    | SetCopie DocumentScanat2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetText v ->
            { model | text = v }

        SetCopie msgDocumentScanat2 ->
            { model | copie = DocumentScanat2.update msgDocumentScanat2 model.copie }
