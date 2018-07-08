module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)


type alias Model =
    { bunuri : List BunUrmarit.Model
    , mijloaceBanesti : List MijlocBanesc.Model
    }


initialModel : Model
initialModel =
    { bunuri = [ BunUrmarit.initialModel ]
    , mijloaceBanesti = []
    }


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]

        --
        -- TODO: Implement list CRUD: list, delete button, add button, add/edit item form
        --
        , ul [] (List.indexedMap viewBunUrmarit list.bunuri)
        , ul [] (List.indexedMap viewMijlocBanesc list.mijloaceBanesti)
        ]


viewBunUrmarit : Int -> BunUrmarit.Model -> Html Msg
viewBunUrmarit i bunUrmarit =
    li [] [ BunUrmarit.view bunUrmarit |> map (SetBunUrmarit i) ]


viewMijlocBanesc : Int -> MijlocBanesc.Model -> Html Msg
viewMijlocBanesc i mijlocBanesc =
    li [] [ text <| toString mijlocBanesc ]


type Msg
    = SetBunUrmarit Int BunUrmarit.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetBunUrmarit i mgBunUrmarit ->
            model
