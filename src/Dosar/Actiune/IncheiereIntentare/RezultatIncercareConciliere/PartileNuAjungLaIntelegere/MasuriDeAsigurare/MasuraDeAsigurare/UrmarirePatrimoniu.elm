module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text, ul)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList


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
        -- TODO: Implement simple list CRUD: list, delete button, add button, add/edit item form
        --
        , ul [] (List.map viewBunUrmarit list.bunuri)
        , ul [] (List.indexedMap viewMijlocBanesc list.mijloaceBanesti)
        ]


viewBunUrmarit : BunUrmarit.Model -> Html Msg
viewBunUrmarit bunUrmarit =
    li []
        [ BunUrmarit.view bunUrmarit |> map (SetBunUrmarit bunUrmarit)
        , button [ onClick (DeleteBunUrmarit bunUrmarit) ] [ text "Șterge" ]
        ]


viewMijlocBanesc : Int -> MijlocBanesc.Model -> Html Msg
viewMijlocBanesc i mijlocBanesc =
    li [] [ text <| toString mijlocBanesc ]


type Msg
    = SetBunUrmarit BunUrmarit.Model BunUrmarit.Msg
    | DeleteBunUrmarit BunUrmarit.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetBunUrmarit modelBunUrmarit msgBunUrmarit ->
            let
                newModelBunUrmarit =
                    BunUrmarit.update msgBunUrmarit modelBunUrmarit
            in
            { model | bunuri = MyList.replaceItem modelBunUrmarit newModelBunUrmarit model.bunuri }

        DeleteBunUrmarit modelBunUrmarit ->
            { model | bunuri = List.filter ((/=) modelBunUrmarit) model.bunuri }
