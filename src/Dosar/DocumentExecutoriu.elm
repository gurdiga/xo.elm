module Dosar.DocumentExecutoriu exposing (Model, Msg, initialModel, update, view)

import Dosar.DocumentExecutoriu.Debitori as Debitori
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare as DocumenteAplicareMasuriAsigurare
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata
import Dosar.DocumentExecutoriu.Pricina as Pricina
import Html exposing (Html, br, button, div, fieldset, legend, map, text)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Widgets.Select as Select


type alias Model =
    { instantaEmitatoare : InstantaDeJudecata.Model
    , pricina : Pricina.Model
    , dataPronuntareHotarire : MyDate.Model
    , dispozitivul : String
    , dataRamineriiDefinitive : MyDate.Model
    , debitori : Debitori.Model
    , dataEliberarii : MyDate.Model
    , documenteAplicareMasuriAsigurare : DocumenteAplicareMasuriAsigurare.Model
    , mentiuniPrivindPatrundereaFortata : String
    , locPastrareBunuriSechestrate : String
    , note : String
    }


initialModel : Model
initialModel =
    { instantaEmitatoare = InstantaDeJudecata.initialModel
    , pricina = Pricina.initialModel
    , dataPronuntareHotarire = MyDate.empty
    , dispozitivul = ""
    , dataRamineriiDefinitive = MyDate.empty
    , debitori = Debitori.initialModel
    , dataEliberarii = MyDate.empty
    , documenteAplicareMasuriAsigurare = DocumenteAplicareMasuriAsigurare.initialModel
    , mentiuniPrivindPatrundereaFortata = ""
    , locPastrareBunuriSechestrate = ""
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumentExecutoriu" ]
        , Select.view
            { label = "Instanța de judecată:"
            , valuesWithLabels = InstantaDeJudecata.valuesWithLabels
            , defaultValue = model.instantaEmitatoare
            , onOptionSelected = SetInstantaEmitatoare
            }
        , Select.view
            { label = "Pricina:"
            , valuesWithLabels = Pricina.valuesWithLabels
            , defaultValue = model.pricina
            , onOptionSelected = SetPricina
            }
        , DateField.view "Data pronunțării hotărîrii:" model.dataPronuntareHotarire SetDataPronuntareHotarire
        , LargeTextField.view "Dispozitivul:" model.dispozitivul SetDispozitivul
        , DateField.view "Data rămînerii definitive:" model.dataRamineriiDefinitive SetDataRamineriiDefinitive
        , Debitori.view model.debitori |> map SetDebitori
        , DateField.view "Data eliberării:" model.dataEliberarii SetDataEliberarii
        , DocumenteAplicareMasuriAsigurare.view model.documenteAplicareMasuriAsigurare |> map SetDocumenteAplicareMasuriAsigurare
        , LargeTextField.view "Mențiuni privind autorizarea pătrunderii forțate:" model.mentiuniPrivindPatrundereaFortata SetMentiuniPrivindPatrundereaFortata
        , LargeTextField.view "Locul de păstrare a bunurilor sechestrate:" model.locPastrareBunuriSechestrate SetLocPastrareBunuriSechestrate
        , LargeTextField.view "Note:" model.note SetNote
        ]


type Msg
    = SetInstantaEmitatoare InstantaDeJudecata.Model
    | SetPricina Pricina.Model
    | SetDataPronuntareHotarire MyDate.Model
    | SetDispozitivul String
    | SetDataRamineriiDefinitive MyDate.Model
    | SetDebitori Debitori.Msg
    | SetDataEliberarii MyDate.Model
    | SetDocumenteAplicareMasuriAsigurare DocumenteAplicareMasuriAsigurare.Msg
    | SetMentiuniPrivindPatrundereaFortata String
    | SetLocPastrareBunuriSechestrate String
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetInstantaEmitatoare v ->
            { model | instantaEmitatoare = v }

        SetPricina v ->
            { model | pricina = v }

        SetDataPronuntareHotarire v ->
            { model | dataPronuntareHotarire = v }

        SetDispozitivul v ->
            { model | dispozitivul = v }

        SetDataRamineriiDefinitive v ->
            { model | dataRamineriiDefinitive = v }

        SetDebitori m ->
            { model | debitori = Debitori.update m model.debitori }

        SetDataEliberarii v ->
            { model | dataEliberarii = v }

        SetDocumenteAplicareMasuriAsigurare m ->
            { model | documenteAplicareMasuriAsigurare = DocumenteAplicareMasuriAsigurare.update m model.documenteAplicareMasuriAsigurare }

        SetMentiuniPrivindPatrundereaFortata v ->
            { model | mentiuniPrivindPatrundereaFortata = v }

        SetLocPastrareBunuriSechestrate v ->
            { model | locPastrareBunuriSechestrate = v }

        SetNote v ->
            { model | note = v }
