module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text)
import Html.Styled.Events exposing (onClick)
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
viewBunUrmarit i x =
    li []
        [ BunUrmarit.view x |> map (\m -> EditableList.Noop)
        , button [ onClick (EditableList.BeginEditItem i x) ] [ text "Editează" ]
        , button [ onClick (EditableList.DeleteItem x) ] [ text "Șterge" ]
        ]


viewBunUrmaritAdd : BunUrmarit.Model -> Html Msg
viewBunUrmaritAdd x =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , BunUrmarit.viewEditForm x |> map (\m -> BunUrmarit.update m x |> EditableList.BeginAddItem)
        , button [ onClick (EditableList.AddItem x) ] [ text "Confirmă adăugarea" ]
        , button [ onClick EditableList.CancelAddItem ] [ text "Anulează adăugarea" ]
        ]


viewBunUrmaritAddButton : Html Msg
viewBunUrmaritAddButton =
    button [ onClick (EditableList.BeginAddItem BunUrmarit.initialModel) ] [ text "Adaugă" ]


viewBunUrmaritEdit : ( Int, BunUrmarit.Model ) -> Html Msg
viewBunUrmaritEdit ( i, x ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , BunUrmarit.viewEditForm x |> map (\m -> BunUrmarit.update m x |> EditableList.BeginEditItem i)
        , button [ onClick (EditableList.ReplaceItem i x) ] [ text "Confirmă editarea" ]
        , button [ onClick EditableList.CancelEditItem ] [ text "Anulează editarea" ]
        ]


type alias Msg =
    EditableList.Msg BunUrmarit.Model


update : Msg -> Model -> Model
update =
    EditableList.update
