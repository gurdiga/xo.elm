module Dosar.DocumentExecutoriu exposing (Model, Msg, initialModel, update, view)

-- import Utils.MyHtmlEvents exposing (onClick)
-- import Utils.MyList as MyList
-- import Widgets.Fields exposing (largeTextField)

import Dosar.DocumentExecutoriu.Debitori as Debitori
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare as DocumenteAplicareMasuriAsigurare
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata
import Dosar.DocumentExecutoriu.Pricina as Pricina
import Html exposing (Html, br, button, div, fieldset, legend, map, text)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Widgets.Select4 as Select4


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
        , Select4.view <|
            Select4.config
                { label = "Instanța de judecată:"
                , valuesWithLabels = InstantaDeJudecata.valuesWithLabels
                , defaultValue = model.instantaEmitatoare
                , onInput = SetInstantaEmitatoare
                }
        , Select4.view <|
            Select4.config
                { label = "Pricina:"
                , valuesWithLabels = Pricina.valuesWithLabels
                , defaultValue = model.pricina
                , onInput = SetPricina
                }
        , DateField.view "Data pronunțării hotărîrii:" model.dataPronuntareHotarire |> map SetDataPronuntareHotarire
        , LargeTextField.view "Dispozitivul:" model.dispozitivul |> map SetDispozitivul
        , DateField.view "Data rămînerii definitive:" model.dataRamineriiDefinitive |> map SetDataRamineriiDefinitive
        , Debitori.view model.debitori |> map SetDebitori
        , DateField.view "Data eliberării:" model.dataEliberarii |> map SetDataEliberarii
        , DocumenteAplicareMasuriAsigurare.view model.documenteAplicareMasuriAsigurare |> map SetDocumenteAplicareMasuriAsigurare
        , LargeTextField.view "Mențiuni privind autorizarea pătrunderii forțate:" model.mentiuniPrivindPatrundereaFortata
            |> map SetMentiuniPrivindPatrundereaFortata
        , LargeTextField.view "Locul de păstrare a bunurilor sechestrate:" model.locPastrareBunuriSechestrate
            |> map SetLocPastrareBunuriSechestrate
        , LargeTextField.view "Note:" model.note |> map SetNote
        ]


type Msg
    = SetInstantaEmitatoare InstantaDeJudecata.Model
    | SetPricina Pricina.Model
    | SetDataPronuntareHotarire DateField.Msg
    | SetDispozitivul LargeTextField.Msg
    | SetDataRamineriiDefinitive DateField.Msg
    | SetDebitori Debitori.Msg
    | SetDataEliberarii DateField.Msg
    | SetDocumenteAplicareMasuriAsigurare DocumenteAplicareMasuriAsigurare.Msg
    | SetMentiuniPrivindPatrundereaFortata LargeTextField.Msg
    | SetLocPastrareBunuriSechestrate LargeTextField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetInstantaEmitatoare v ->
            { model | instantaEmitatoare = v }

        SetPricina v ->
            { model | pricina = v }

        SetDataPronuntareHotarire dateFieldMsg ->
            { model | dataPronuntareHotarire = DateField.update dateFieldMsg model.dataPronuntareHotarire }

        SetDispozitivul largeTextFieldMsg ->
            { model | dispozitivul = LargeTextField.update largeTextFieldMsg model.dispozitivul }

        SetDataRamineriiDefinitive dateFieldMsg ->
            { model | dataRamineriiDefinitive = DateField.update dateFieldMsg model.dataRamineriiDefinitive }

        SetDebitori m ->
            { model | debitori = Debitori.update m model.debitori }

        SetDataEliberarii dateFieldMsg ->
            { model | dataEliberarii = DateField.update dateFieldMsg model.dataEliberarii }

        SetDocumenteAplicareMasuriAsigurare m ->
            { model | documenteAplicareMasuriAsigurare = DocumenteAplicareMasuriAsigurare.update m model.documenteAplicareMasuriAsigurare }

        SetMentiuniPrivindPatrundereaFortata largeTextFieldMsg ->
            { model | mentiuniPrivindPatrundereaFortata = LargeTextField.update largeTextFieldMsg model.mentiuniPrivindPatrundereaFortata }

        SetLocPastrareBunuriSechestrate largeTextFieldMsg ->
            { model | locPastrareBunuriSechestrate = LargeTextField.update largeTextFieldMsg model.locPastrareBunuriSechestrate }

        SetNote largeTextFieldMsg ->
            { model | note = LargeTextField.update largeTextFieldMsg model.note }
