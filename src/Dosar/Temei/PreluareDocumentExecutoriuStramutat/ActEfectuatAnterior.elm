module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior exposing (Model, view, Msg, update, initialModel)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 as DocumentScanat2
import Html.Styled exposing (Html, fieldset, legend, p, text)


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
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
        [ legend [] [ text "ActeEfectuateAnterior" ]
        , model |> toString |> text
        ]
