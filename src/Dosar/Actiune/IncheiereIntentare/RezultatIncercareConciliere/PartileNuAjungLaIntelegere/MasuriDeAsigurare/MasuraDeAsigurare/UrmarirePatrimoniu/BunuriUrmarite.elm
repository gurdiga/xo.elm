module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text)
import Html.Styled.Events exposing (onClick)
import Widgets.EditableList as EditableList


type alias Model =
    { items : List BunUrmarit.Model
    , editableListState : EditableList.State BunUrmarit.Model
    }


initialModel : Model
initialModel =
    { items = []
    , editableListState = editableListState
    }


editableListState : EditableList.State BunUrmarit.Model
editableListState =
    EditableList.state
        { itemToAdd = Nothing
        , itemToEdit = Nothing
        }


view : Model -> Html Msg
view { items, editableListState } =
    EditableList.view editableListConfig editableListState items


editableListConfig : EditableList.Config BunUrmarit.Model SomeKindOfMsg
editableListConfig =
    EditableList.config
        { viewNoItems = text "Nu sunt bunuri înregistrate."
        , viewItem = viewItem
        , viewItemAdd = viewItemAdd
        , viewItemEdit = viewItemEdit
        , viewAddItemButton = viewAddItemButton
        }


viewItem : Int -> BunUrmarit.Model -> Html Msg
viewItem i x =
    li []
        [ BunUrmarit.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewItemAdd : BunUrmarit.Model -> Html Msg
viewItemAdd x =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , BunUrmarit.viewEditForm x |> map (\m -> BunUrmarit.update m x |> EditableList.BeginAddItem)
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewAddItemButton : Html Msg
viewAddItemButton =
    button [ onClick (EditableList.BeginAddItem BunUrmarit.initialModel) ] [ text "Adaugă" ]


viewItemEdit : ( Int, BunUrmarit.Model ) -> Html Msg
viewItemEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , BunUrmarit.viewEditForm x |> map (\m -> BunUrmarit.update m x |> EditableList.BeginEditItem i)
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg BunUrmarit.Model


update : Msg -> Model -> Model
update msg model =
    EditableList.update msg model.editableListState model.items
