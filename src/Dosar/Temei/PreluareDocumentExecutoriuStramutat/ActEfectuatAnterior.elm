module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html exposing (Html, button, fieldset, legend, li, map, p, text, ul)
import Widgets.DocumentScanat2 as DocumentScanat2
import Widgets.LargeTextField as LargeTextField


type alias Model =
    { copiaScanata : DocumentScanat2.Model
    , note : String
    }


initialModel : Model
initialModel =
    { copiaScanata = DocumentScanat2.initialModel
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "ActEfectuatAnterior" ]
        , ul []
            [ li [] [ text ("Copia scanată:" ++ model.copiaScanata.file.path) ]
            , li [] [ text ("Note:" ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ DocumentScanat2.view "Copia scanată:" model.copiaScanata |> map SetCopiaScanata ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetCopiaScanata DocumentScanat2.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCopiaScanata m ->
            { model | copiaScanata = DocumentScanat2.update m model.copiaScanata }

        SetNote v ->
            { model | note = v }
