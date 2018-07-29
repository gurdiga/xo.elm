module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, p, text, ul)


type alias Model =
    { mijloaceBanesti : List MijlocBanesc.Model
    , bunuriUrmarite : BunuriUrmarite.Model
    }


initialModel : Model
initialModel =
    { mijloaceBanesti = []
    , bunuriUrmarite = BunuriUrmarite.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , BunuriUrmarite.view model.bunuriUrmarite |> map SetBunuriUrmarite
        , ul [] (List.indexedMap viewMijlocBanesc model.mijloaceBanesti)
        ]


viewMijlocBanesc : Int -> MijlocBanesc.Model -> Html Msg
viewMijlocBanesc i mijlocBanesc =
    li [] [ text <| toString mijlocBanesc ]


type Msg
    = SetBunuriUrmarite BunuriUrmarite.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetBunuriUrmarite msgBunuriUrmarite ->
            { model | bunuriUrmarite = BunuriUrmarite.update msgBunuriUrmarite model.bunuriUrmarite }
