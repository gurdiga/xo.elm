module Dosar.DocumentExecutoriu.DocumentAplicareMasuriAsigurare exposing (Model, initialModel, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.LargeTextField as LargeTextField
import Widgets.TextField as TextField


type alias Model =
    { denumire : String
    , note : String
    , copiaScanata : DocumentScanat3.Model
    }


initialModel : Model
initialModel =
    { denumire = ""
    , note = ""
    , copiaScanata = DocumentScanat3.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumentAplicareMasuriAsigurare" ]
        , ul []
            [ li [] [ text ("Denumire:" ++ model.denumire) ]
            , li [] [ text ("Note:" ++ model.note) ]
            , li [] [ text ("Copia scanată:" ++ DocumentScanat3.toString model.copiaScanata) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Denumire:" model.denumire SetDenumire ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        , li [] [ DocumentScanat3.view "Copia scanată:" SetCopiaScanata ]
        ]


type Msg
    = SetDenumire String
    | SetNote String
    | SetCopiaScanata DocumentScanat3.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire v ->
            { model | denumire = v }

        SetNote v ->
            { model | note = v }

        SetCopiaScanata v ->
            { model | copiaScanata = v }
