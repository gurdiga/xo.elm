module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite
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
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , BunuriUrmarite.view model.bunuriUrmarite |> map SetBunuriUrmarite
        , MijloaceBanesti.view model.mijloaceBanesti |> map SetMijloaceBanesti
        ]


viewItem : Int -> BunUrmarit.Model -> Html Msg
viewItem i x =
    li []
        [ text "BunUrmarit.view x"
        , button [] [ text "Editează" ]
        , button [] [ text "Șterge" ]
        ]


type Msg
    = SetBunuriUrmarite BunuriUrmarite.Msg
    | SetMijloaceBanesti MijloaceBanesti.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetBunuriUrmarite m ->
            { model | bunuriUrmarite = BunuriUrmarite.update m model.bunuriUrmarite }

        SetMijloaceBanesti m ->
            { model | mijloaceBanesti = MijloaceBanesti.update m model.mijloaceBanesti }
