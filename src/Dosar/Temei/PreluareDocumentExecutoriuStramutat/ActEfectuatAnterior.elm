module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (Model, Msg(..), initialModel, setFile, setNote, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 as DocumentScanat2
import Html exposing (Html, button, fieldset, legend, p, text)


type Msg
    = Set


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set ->
            model


setFile : Model -> String -> Model
setFile model newPath =
    { model | copie = DocumentScanat2.setCopie model.copie newPath }


setNote : Model -> String -> Model
setNote model newNote =
    { model | note = newNote }


type alias Model =
    { copie : DocumentScanat2.Model
    , note : String
    }


initialModel : Model
initialModel =
    { copie = DocumentScanat2.initialModel
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "ActEfectuatAnterior" ]
        , text "TODO"
        ]
