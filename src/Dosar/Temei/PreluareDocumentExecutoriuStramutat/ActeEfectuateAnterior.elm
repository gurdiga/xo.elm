module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (Model, Msg, initialModel, view, update)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Html.Styled exposing (Html, fieldset, legend, p, text, map)


type Msg
    = Set ActEfectuatAnterior.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set actEfectuatAnteriorMsg ->
            model


type alias Model =
    List ActEfectuatAnterior.Model


initialModel : Model
initialModel =
    [ ActEfectuatAnterior.initialModel ]


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "ActeEfectuateAnterior" ]
        , list |> toString |> text
        ]
