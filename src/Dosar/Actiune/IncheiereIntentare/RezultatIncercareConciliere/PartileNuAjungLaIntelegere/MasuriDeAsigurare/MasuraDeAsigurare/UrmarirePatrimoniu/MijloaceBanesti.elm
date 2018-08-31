module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijloaceBanesti exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html exposing (Html, button, fieldset, legend, li, map, text)
import Html.Events exposing (onClick)
import Widgets.EditableList as EditableList


type alias Model =
    EditableList.Model MijlocBanesc.Model


initialModel : Model
initialModel =
    EditableList.initialModel []


view : Model -> Html Msg
view =
    EditableList.view
        { viewNoItems = text "Nu sunt mijloace bănești înregistrate."
        , viewItem = viewItem
        , viewItemAdd = viewItemAdd
        , viewItemEdit = viewItemEdit
        , viewAddItemButton = viewAddItemButton
        }


viewItem : Int -> MijlocBanesc.Model -> Html Msg
viewItem i x =
    li []
        [ MijlocBanesc.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewItemAdd : MijlocBanesc.Model -> Html Msg
viewItemAdd x =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , MijlocBanesc.viewEditForm x |> map (\m -> MijlocBanesc.update m x |> EditableList.BeginAddItem)
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewAddItemButton : Html Msg
viewAddItemButton =
    button [ onClick (EditableList.BeginAddItem MijlocBanesc.initialModel) ] [ text "Adaugă" ]


viewItemEdit : ( Int, MijlocBanesc.Model ) -> Html Msg
viewItemEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , MijlocBanesc.viewEditForm x |> map (\m -> MijlocBanesc.update m x |> EditableList.BeginEditItem i)
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg MijlocBanesc.Model


update : Msg -> Model -> Model
update =
    EditableList.update
