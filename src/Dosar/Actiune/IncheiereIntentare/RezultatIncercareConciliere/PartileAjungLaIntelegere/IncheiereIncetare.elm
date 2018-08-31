module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, h1, legend, map, text)
import Utils.DocumentScanat2 as DocumentScanat2
import Utils.RichTextEditor2 as RichTextEditor2


type alias Model =
    { text : RichTextEditor2.Model
    , copie : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { text = RichTextEditor2.initialModel
    , copie = DocumentScanat2.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIncetare" ]
        , RichTextEditor2.view "Formează încheiere încetare:" model.text |> map SetText
        , DocumentScanat2.view "Copia încheierii de încetare:" model.copie |> map SetCopie
        ]


type Msg
    = SetText RichTextEditor2.Msg
    | SetCopie DocumentScanat2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetText msgRichTextEditor2 ->
            { model | text = RichTextEditor2.update msgRichTextEditor2 model.text }

        SetCopie msgDocumentScanat2 ->
            { model | copie = DocumentScanat2.update msgDocumentScanat2 model.copie }
