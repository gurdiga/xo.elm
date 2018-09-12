module Dosar.DocumentExecutoriu.DocumentAplicareMasuriAsigurare exposing (Model, initialModel, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.DocumentScanat2 as DocumentScanat2
import Widgets.LargeTextField as LargeTextField
import Widgets.TextField as TextField


type alias Model =
    { denumire : String
    , note : String
    , copiaScanata : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { denumire = ""
    , note = ""
    , copiaScanata = DocumentScanat2.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumentAplicareMasuriAsigurare" ]
        , ul []
            [ li [] [ text ("Denumire:" ++ model.denumire) ]
            , li [] [ text ("Note:" ++ model.note) ]
            , li [] [ text ("Copia scanată:" ++ model.copiaScanata.file.path) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Denumire:" model.denumire |> map SetDenumire ]
        , li [] [ LargeTextField.view "Note:" model.note |> map SetNote ]
        , li [] [ DocumentScanat2.view "Copia scanată:" model.copiaScanata |> map SetCopiaScanata ]
        ]


type Msg
    = SetDenumire TextField.Msg
    | SetNote LargeTextField.Msg
    | SetCopiaScanata DocumentScanat2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire m ->
            { model | denumire = TextField.update m model.denumire }

        SetNote m ->
            { model | note = LargeTextField.update m model.note }

        SetCopiaScanata m ->
            { model | copiaScanata = DocumentScanat2.update m model.copiaScanata }
