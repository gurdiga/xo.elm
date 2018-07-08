module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu as UrmarirePatrimoniu
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, text, ul)


type Model
    = UrmarirePatrimoniu UrmarirePatrimoniu.Model


initialModel : Model
initialModel =
    UrmarirePatrimoniu UrmarirePatrimoniu.initialModel


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
            case model of
                UrmarirePatrimoniu modelUrmarirePatrimoniu ->
                    UrmarirePatrimoniu (UrmarirePatrimoniu.update msgUrmarirePatrimoniu modelUrmarirePatrimoniu)
