module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList2 as EditableList2
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijloaceBanesti as MijloaceBanesti
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, p, text, ul)


type alias Model =
    { mijloaceBanesti : MijloaceBanesti.Model
    , bunuriUrmarite : BunuriUrmarite.Model
    , bunuriUrmarite2 : List BunUrmarit.Model
    , bunuriUrmarite2EditableListState : EditableList2.State
    }


initialModel : Model
initialModel =
    { mijloaceBanesti = MijloaceBanesti.initialModel
    , bunuriUrmarite = BunuriUrmarite.initialModel
    , bunuriUrmarite2 = []
    , bunuriUrmarite2EditableListState = EditableList2.state {}
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , BunuriUrmarite.view model.bunuriUrmarite |> map SetBunuriUrmarite
        , EditableList2.view bunuriUrmarite2EditableListConfig bunuriUrmarite2EditableListState model.bunuriUrmarite2
        , MijloaceBanesti.view model.mijloaceBanesti |> map SetMijloaceBanesti
        ]


bunuriUrmarite2EditableListConfig : EditableList2.Config Msg
bunuriUrmarite2EditableListConfig =
    EditableList2.config
        { toMsg = SetBunuriUrmarite2EditableListState
        }


bunuriUrmarite2EditableListState : EditableList2.State
bunuriUrmarite2EditableListState =
    EditableList2.state {}


type Msg
    = SetBunuriUrmarite BunuriUrmarite.Msg
    | SetMijloaceBanesti MijloaceBanesti.Msg
    | SetBunuriUrmarite2EditableListState EditableList2.State


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetBunuriUrmarite m ->
            { model | bunuriUrmarite = BunuriUrmarite.update m model.bunuriUrmarite }

        SetMijloaceBanesti m ->
            { model | mijloaceBanesti = MijloaceBanesti.update m model.mijloaceBanesti }

        SetBunuriUrmarite2EditableListState s ->
            { model | bunuriUrmarite2EditableListState = s }
