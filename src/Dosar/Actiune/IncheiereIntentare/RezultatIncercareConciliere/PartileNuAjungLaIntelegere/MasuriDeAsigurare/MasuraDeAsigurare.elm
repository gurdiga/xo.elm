module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare exposing (Model, Msg, addView, getValueFromMsg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu as UrmarirePatrimoniu
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, text, ul)
import Html.Styled.Events exposing (onClick)


type Model
    = UrmarirePatrimoniu UrmarirePatrimoniu.Model


initialModel : Model
initialModel =
    UrmarirePatrimoniu UrmarirePatrimoniu.initialModel


getValueFromMsg : Msg -> Model
getValueFromMsg msg =
    case msg of
        Set masuraDeAsigurare ->
            masuraDeAsigurare

        SetUrmarirePatrimoniu msgUrmarirePatrimoniu ->
            UrmarirePatrimoniu (UrmarirePatrimoniu.getValueFromMsg msgUrmarirePatrimoniu)


addView : Html Msg
addView =
    div []
        [ text "Adaugă măsură:"
        , ul []
            [ li [] [ button [ onClick (Set (UrmarirePatrimoniu UrmarirePatrimoniu.initialModel)) ] [ text "UrmarirePatrimoniu" ] ]
            ]
        ]


view : Model -> Html Msg
view model =
    case model of
        UrmarirePatrimoniu v ->
            UrmarirePatrimoniu.view v |> map SetUrmarirePatrimoniu


type Msg
    = Set Model
    | SetUrmarirePatrimoniu UrmarirePatrimoniu.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set masuraDeAsigurare ->
            masuraDeAsigurare

        SetUrmarirePatrimoniu msgUrmarirePatrimoniu ->
            UrmarirePatrimoniu (UrmarirePatrimoniu.update msgUrmarirePatrimoniu)
