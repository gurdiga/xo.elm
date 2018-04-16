module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (Model, Msg(..), view, update, initialModel)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 as DocumentScanat2
import Html.Styled exposing (Html, fieldset, legend, p, text, button)


type Msg
    = Set


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set ->
            model


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
        , model |> toString |> text
        ]
