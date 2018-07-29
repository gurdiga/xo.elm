module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList
import Widgets.EditableList as EditableList


type alias Model =
    EditableList.Model BunUrmarit.Model


initialModel : Model
initialModel =
    EditableList.initialModel [ BunUrmarit.initialModel ]


view : Model -> Html Msg
view model =
    EditableList.view
        { viewNoItems = text "Nu sunt bunuri înregistrate."
        , viewItem = viewBunUrmarit
        , viewItemAdd = viewBunUrmaritAdd
        , viewItemEdit = viewBunUrmaritEdit
        , viewAddItemButton = viewBunUrmaritAddButton
        }
        model


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


type Msg
    = BunUrmaritNouAdd
    | BunUrmaritNouSet BunUrmarit.Model BunUrmarit.Msg
    | BunUrmaritNouSubmit BunUrmarit.Model
    | BunUrmaritNouReset
    | BunUrmaritEditatInit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatSet ( Int, BunUrmarit.Model ) BunUrmarit.Msg
    | BunUrmaritEditatSubmit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatReset
    | BunUrmaritDelete BunUrmarit.Model
    | BunUrmaritNoop BunUrmarit.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        BunUrmaritNouAdd ->
            EditableList.setItemToAdd (Just BunUrmarit.initialModel) model

        BunUrmaritNouSet modelBunUrmarit msgBunUrmarit ->
            EditableList.setItemToAdd (Just (BunUrmarit.update msgBunUrmarit modelBunUrmarit)) model

        BunUrmaritNouSubmit modelBunUrmarit ->
            EditableList.addItem modelBunUrmarit model

        BunUrmaritNouReset ->
            EditableList.resetItemToAdd model

        BunUrmaritEditatInit ( i, modelBunUrmarit ) ->
            EditableList.setItemToEdit (Just ( i, modelBunUrmarit )) model

        BunUrmaritEditatSet ( i, modelBunUrmarit ) msgBunUrmarit ->
            EditableList.setItemToEdit (Just ( i, BunUrmarit.update msgBunUrmarit modelBunUrmarit )) model

        BunUrmaritEditatSubmit ( i, modelBunUrmarit ) ->
            EditableList.setItems (MyList.replace model.items i modelBunUrmarit) model

        BunUrmaritEditatReset ->
            EditableList.resetItemToEdit model

        BunUrmaritDelete modelBunUrmarit ->
            EditableList.setItems (List.filter ((/=) modelBunUrmarit) model.items) model

        -- TODO: Is this alright?
        BunUrmaritNoop msgBunUrmarit ->
            model
