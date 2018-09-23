module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html exposing (Html, button, fieldset, legend, li, map, p, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.LargeTextField as LargeTextField


type alias Model =
    { copiaScanata : DocumentScanat3.Model
    , note : String
    }


initialModel : Model
initialModel =
    { copiaScanata = DocumentScanat3.initialModel
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "ActEfectuatAnterior" ]
        , ul []
            [ li [] [ text ("Copia scanată:" ++ DocumentScanat3.toString model.copiaScanata) ]
            , li [] [ text ("Note:" ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ DocumentScanat3.view "Copia scanată:" SetCopiaScanata ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetCopiaScanata DocumentScanat3.Model
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCopiaScanata v ->
            { model | copiaScanata = v }

        SetNote v ->
            { model | note = v }
