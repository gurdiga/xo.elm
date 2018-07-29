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
        , viewItem = viewBunUrmarit EditedInit
        , viewItemAdd = viewBunUrmaritAdd
        , viewItemEdit = viewBunUrmaritEdit
        , viewAddItemButton = viewBunUrmaritAddButton
        }
        model


viewBunUrmarit : (( Int, BunUrmarit.Model ) -> Msg) -> Int -> BunUrmarit.Model -> Html Msg
viewBunUrmarit msgEditedInit i bunUrmarit =
    li []
        [ BunUrmarit.view bunUrmarit |> map Noop
        , button [ onClick (msgEditedInit ( i, bunUrmarit )) ] [ text "Editează" ]
        , button [ onClick (Delete bunUrmarit) ] [ text "Șterge" ]
        ]


viewBunUrmaritAdd : BunUrmarit.Model -> Html Msg
viewBunUrmaritAdd modelBunUrmarit =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (NewSet modelBunUrmarit)
        , button [ onClick (NewSubmit modelBunUrmarit) ] [ text "Confirmă adăugarea" ]
        , button [ onClick NewReset ] [ text "Anulează adăugarea" ]
        ]


viewBunUrmaritAddButton : Html Msg
viewBunUrmaritAddButton =
    button [ onClick NewAdd ] [ text "Adaugă" ]


viewBunUrmaritEdit : ( Int, BunUrmarit.Model ) -> Html Msg
viewBunUrmaritEdit ( i, modelBunUrmarit ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (EditedSet ( i, modelBunUrmarit ))
        , button [ onClick (EditedSubmit ( i, modelBunUrmarit )) ] [ text "Confirmă editarea" ]
        , button [ onClick EditedReset ] [ text "Anulează editarea" ]
        ]


type Msg
    = NewAdd
    | NewSet BunUrmarit.Model BunUrmarit.Msg
    | NewSubmit BunUrmarit.Model
    | NewReset
    | EditedInit ( Int, BunUrmarit.Model )
    | EditedSet ( Int, BunUrmarit.Model ) BunUrmarit.Msg
    | EditedSubmit ( Int, BunUrmarit.Model )
    | EditedReset
    | Delete BunUrmarit.Model
    | Noop BunUrmarit.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        NewAdd ->
            EditableList.setItemToAdd (Just BunUrmarit.initialModel) model

        NewSet modelBunUrmarit msgBunUrmarit ->
            EditableList.setItemToAdd (Just (BunUrmarit.update msgBunUrmarit modelBunUrmarit)) model

        NewSubmit modelBunUrmarit ->
            EditableList.addItem modelBunUrmarit model

        NewReset ->
            EditableList.resetItemToAdd model

        EditedInit ( i, modelBunUrmarit ) ->
            EditableList.setItemToEdit (Just ( i, modelBunUrmarit )) model

        EditedSet ( i, modelBunUrmarit ) msgBunUrmarit ->
            EditableList.setItemToEdit (Just ( i, BunUrmarit.update msgBunUrmarit modelBunUrmarit )) model

        EditedSubmit ( i, modelBunUrmarit ) ->
            EditableList.setItems (MyList.replace model.items i modelBunUrmarit) model

        EditedReset ->
            EditableList.resetItemToEdit model

        Delete modelBunUrmarit ->
            EditableList.setItems (List.filter ((/=) modelBunUrmarit) model.items) model

        -- TODO: Is this alright?
        Noop msgBunUrmarit ->
            model
