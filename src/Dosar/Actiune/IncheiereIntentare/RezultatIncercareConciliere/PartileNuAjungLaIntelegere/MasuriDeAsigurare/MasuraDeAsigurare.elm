module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu as UrmarirePatrimoniu
import Html exposing (Html, button, div, fieldset, legend, li, map, text, ul)


type alias Model =
    UrmarirePatrimoniu.Model


initialModel : Model
initialModel =
    UrmarirePatrimoniu.initialModel


view : Model -> Html Msg
view model =
    UrmarirePatrimoniu.view model |> map SetUrmarirePatrimoniu


type Msg
    = SetUrmarirePatrimoniu UrmarirePatrimoniu.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetUrmarirePatrimoniu msgUrmarirePatrimoniu ->
            UrmarirePatrimoniu.update msgUrmarirePatrimoniu model
