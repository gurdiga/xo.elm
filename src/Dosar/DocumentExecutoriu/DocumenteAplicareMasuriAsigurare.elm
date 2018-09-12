module Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare exposing (Model, Msg, initialModel, update, view)

import Dosar.DocumentExecutoriu.DocumentAplicareMasuriAsigurare as DocumentAplicareMasuriAsigurare
import Html exposing (Html, button, fieldset, legend, li, map, text)
import Html.Events exposing (onClick)
import Utils.DocumentScanat as DocumentScanat
import Widgets.EditableList as EditableList
import Widgets.Fields exposing (unlabeledLargeTextField, unlabeledTextField)


type alias Item =
    DocumentAplicareMasuriAsigurare.Model


type alias Model =
    EditableList.Model Item


initialModel : Model
initialModel =
    EditableList.initialModel [ DocumentAplicareMasuriAsigurare.initialModel ]


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DocumentAplicareMasuriAsigurare" ]
        , EditableList.view
            { viewNoItems = text "Nu sunt documente înregistrate."
            , viewItem = viewItem
            , viewItemAdd = viewItemAdd
            , viewItemEdit = viewItemEdit
            , viewAddItemButton = viewAddItemButton
            }
            model
        ]


viewItem : Int -> Item -> Html Msg
viewItem i x =
    li []
        [ DocumentAplicareMasuriAsigurare.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewItemAdd : Item -> Html Msg
viewItemAdd x =
    fieldset []
        [ legend [] [ text "Adaugă document" ]
        , DocumentAplicareMasuriAsigurare.viewEditForm x |> map (\m -> DocumentAplicareMasuriAsigurare.update m x |> EditableList.BeginAddItem)
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewAddItemButton : Html Msg
viewAddItemButton =
    button [ onClick (EditableList.BeginAddItem DocumentAplicareMasuriAsigurare.initialModel) ] [ text "Adaugă" ]


viewItemEdit : ( Int, Item ) -> Html Msg
viewItemEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , DocumentAplicareMasuriAsigurare.viewEditForm x |> map (\m -> DocumentAplicareMasuriAsigurare.update m x |> EditableList.BeginEditItem i)
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg Item


update : Msg -> Model -> Model
update =
    EditableList.update
