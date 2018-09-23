module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, h1, legend, map, text)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.RichTextEditor3 as RichTextEditor3


type alias Model =
    { text : String
    , copie : DocumentScanat3.Model
    }


initialModel : Model
initialModel =
    { text = ""
    , copie = DocumentScanat3.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereIncetare" ]
        , RichTextEditor3.view "Formează încheiere încetare:" model.text SetText
        , DocumentScanat3.view "Copia încheierii de încetare:" SetCopie
        ]


type Msg
    = SetText String
    | SetCopie DocumentScanat3.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetText v ->
            { model | text = v }

        SetCopie v ->
            { model | copie = v }
