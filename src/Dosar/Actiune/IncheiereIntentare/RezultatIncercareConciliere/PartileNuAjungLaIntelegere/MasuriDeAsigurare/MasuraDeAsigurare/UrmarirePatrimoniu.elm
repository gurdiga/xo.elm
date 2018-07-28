module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, p, text, ul)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList
import Widgets.EditableList as EditableList


type alias Model =
    { mijloaceBanesti : List MijlocBanesc.Model
    , bunuriUrmarite : EditableList.Model BunUrmarit.Model
    }


initialModel : Model
initialModel =
    { mijloaceBanesti = []
    , bunuriUrmarite = EditableList.initialModel [ BunUrmarit.initialModel ]
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , EditableList.view
            { viewNoItems = text "Nu sunt bunuri înregistrate."
            , viewItem = viewBunUrmarit
            , viewItemAdd = viewBunUrmaritAdd
            , viewItemEdit = viewBunUrmaritEdit
            , viewAddItemButton = viewBunUrmaritAddButton
            }
            model.bunuriUrmarite
        , ul [] (List.indexedMap viewMijlocBanesc model.mijloaceBanesti)
        ]


viewBunuriUrmarite : List BunUrmarit.Model -> Html Msg
viewBunuriUrmarite bunuriUrmarite =
    ul [] (List.indexedMap viewBunUrmarit bunuriUrmarite)


viewBunUrmarit : Int -> BunUrmarit.Model -> Html Msg
viewBunUrmarit i bunUrmarit =
    li []
        [ BunUrmarit.view bunUrmarit |> map BunUrmaritNoop
        , button [ onClick (BunUrmaritEditatInit ( i, bunUrmarit )) ] [ text "Editează" ]
        , button [ onClick (BunUrmaritDelete bunUrmarit) ] [ text "Șterge" ]
        ]


viewBunUrmaritAdd : BunUrmarit.Model -> Html Msg
viewBunUrmaritAdd modelBunUrmarit =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (BunUrmaritNouSet modelBunUrmarit)
        , button [ onClick (BunUrmaritNouSubmit modelBunUrmarit) ] [ text "Confirmă adăugarea" ]
        , button [ onClick BunUrmaritNouReset ] [ text "Anulează adăugarea" ]
        ]


viewBunUrmaritAddButton : Html Msg
viewBunUrmaritAddButton =
    button [ onClick BunUrmaritNouAdd ] [ text "Adaugă" ]


viewBunUrmaritEdit : ( Int, BunUrmarit.Model ) -> Html Msg
viewBunUrmaritEdit ( i, modelBunUrmarit ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (BunUrmaritEditatSet ( i, modelBunUrmarit ))
        , button [ onClick (BunUrmaritEditatSubmit ( i, modelBunUrmarit )) ] [ text "Confirmă editarea" ]
        , button [ onClick BunUrmaritEditatReset ] [ text "Anulează editarea" ]
        ]


viewMijlocBanesc : Int -> MijlocBanesc.Model -> Html Msg
viewMijlocBanesc i mijlocBanesc =
    li [] [ text <| toString mijlocBanesc ]


type Msg
    = BunUrmaritNouAdd
    | BunUrmaritNouSet BunUrmarit.Model BunUrmarit.Msg
    | BunUrmaritNouSubmit BunUrmarit.Model
    | BunUrmaritNouReset
    | -- TODO: could I hide these 4 in EditableList?
      BunUrmaritEditatInit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatSet ( Int, BunUrmarit.Model ) BunUrmarit.Msg
    | BunUrmaritEditatSubmit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatReset
    | BunUrmaritNoop BunUrmarit.Msg
    | BunUrmaritDelete BunUrmarit.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        BunUrmaritNouAdd ->
            { model | bunuriUrmarite = EditableList.setItemToAdd (Just BunUrmarit.initialModel) model.bunuriUrmarite }

        BunUrmaritNouSet modelBunUrmarit msgBunUrmarit ->
            { model | bunuriUrmarite = EditableList.setItemToAdd (Just (BunUrmarit.update msgBunUrmarit modelBunUrmarit)) model.bunuriUrmarite }

        BunUrmaritNouSubmit modelBunUrmarit ->
            { model | bunuriUrmarite = EditableList.addItem modelBunUrmarit model.bunuriUrmarite }

        BunUrmaritNouReset ->
            { model | bunuriUrmarite = EditableList.resetItemToAdd model.bunuriUrmarite }

        BunUrmaritEditatInit ( i, modelBunUrmarit ) ->
            { model | bunuriUrmarite = EditableList.setItemToEdit (Just ( i, modelBunUrmarit )) model.bunuriUrmarite }

        BunUrmaritEditatSet ( i, modelBunUrmarit ) msgBunUrmarit ->
            { model | bunuriUrmarite = EditableList.setItemToEdit (Just ( i, BunUrmarit.update msgBunUrmarit modelBunUrmarit )) model.bunuriUrmarite }

        BunUrmaritEditatSubmit ( i, modelBunUrmarit ) ->
            { model | bunuriUrmarite = EditableList.setItems (MyList.replace model.bunuriUrmarite.items i modelBunUrmarit) model.bunuriUrmarite }

        BunUrmaritEditatReset ->
            { model | bunuriUrmarite = EditableList.resetItemToEdit model.bunuriUrmarite }

        -- TODO: Is this alright?
        BunUrmaritNoop msgBunUrmarit ->
            model

        BunUrmaritDelete modelBunUrmarit ->
            { model | bunuriUrmarite = EditableList.setItems (List.filter ((/=) modelBunUrmarit) model.bunuriUrmarite.items) model.bunuriUrmarite }
