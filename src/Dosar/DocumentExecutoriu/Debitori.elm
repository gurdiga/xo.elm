module Dosar.DocumentExecutoriu.Debitori exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana as Persoana
import Html exposing (Html, button, fieldset, legend, li, map, text)
import Html.Events exposing (onClick)
import Widgets.EditableList as EditableList


type alias Item =
    Persoana.Model


type alias Model =
    EditableList.Model Item


initialModel : Model
initialModel =
    EditableList.initialModel [ Persoana.initialModel ]


view : Model -> Html Msg
view =
    EditableList.view
        { viewNoItems = text "Nu sunt debitori înregistrați."
        , viewItem = viewItem
        , viewItemAdd = viewItemAdd
        , viewItemEdit = viewItemEdit
        , viewAddItemButton = viewAddItemButton
        }


viewItem : Int -> Item -> Html Msg
viewItem i x =
    li []
        [ Persoana.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewItemAdd : Item -> Html Msg
viewItemAdd x =
    fieldset []
        [ legend [] [ text "Adaugă debitor" ]
        , text "Persoana.viewEditForm"
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewAddItemButton : Html Msg
viewAddItemButton =
    button [ onClick (EditableList.BeginAddItem Persoana.initialModel) ] [ text "Adaugă" ]


viewItemEdit : ( Int, Item ) -> Html Msg
viewItemEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează debitor" ]
        , text "Persoana.viewEditForm"
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg Item


update : Msg -> Model -> Model
update =
    EditableList.update
