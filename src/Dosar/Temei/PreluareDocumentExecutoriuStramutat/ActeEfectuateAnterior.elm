module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Html exposing (Html, button, div, fieldset, form, input, label, legend, li, map, p, text, textarea, ul)
import Html.Attributes exposing (class, for, id, type_)
import Html.Events exposing (onClick, onInput)
import Widgets.EditableList as EditableList


type alias Model =
    EditableList.Model ActEfectuatAnterior.Model


initialModel : Model
initialModel =
    EditableList.initialModel []


view : Model -> Html Msg
view =
    EditableList.view
        { viewNoItems = text "Nu sunt acte efectuate anterior."
        , viewItem = viewItem
        , viewItemAdd = viewItemAdd
        , viewItemEdit = viewItemEdit
        , viewAddItemButton = viewAddItemButton
        }


viewItem : Int -> ActEfectuatAnterior.Model -> Html Msg
viewItem i x =
    li []
        [ ActEfectuatAnterior.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewItemAdd : ActEfectuatAnterior.Model -> Html Msg
viewItemAdd x =
    fieldset []
        [ legend [] [ text "Adaugă act" ]
        , ActEfectuatAnterior.viewEditForm x |> map (\m -> ActEfectuatAnterior.update m x |> EditableList.BeginAddItem)
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewAddItemButton : Html Msg
viewAddItemButton =
    button [ onClick (EditableList.BeginAddItem ActEfectuatAnterior.initialModel) ] [ text "Adaugă" ]


viewItemEdit : ( Int, ActEfectuatAnterior.Model ) -> Html Msg
viewItemEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează act" ]
        , ActEfectuatAnterior.viewEditForm x |> map (\m -> ActEfectuatAnterior.update m x |> EditableList.BeginEditItem i)
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg ActEfectuatAnterior.Model


update : Msg -> Model -> Model
update =
    EditableList.update
