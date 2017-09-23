module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selection
    exposing
        ( Selection
        , empty
        , fromItems
        , view
        )

import Html exposing (Html, ul, li, input, text)
import Html.Attributes exposing (type_, checked)
import Html.Events exposing (onCheck)
import Utils.MyList as MyList


type Selection a
    = Selection (List (SelectionItem a))


type SelectionItem a
    = SelectionItem
        { item : a
        , isSelected : Bool
        }


empty : Selection a
empty =
    Selection []


fromItems : List a -> Selection a
fromItems items =
    Selection
        (List.map (\v -> SelectionItem { item = v, isSelected = False }) items)


view : Selection a -> (a -> Html msg) -> (Selection a -> msg) -> Html msg
view (Selection selectionItems) itemRenderer callback =
    let
        this =
            ul [] (List.indexedMap renderItem selectionItems)

        renderItem index (SelectionItem ({ item } as selectionItem)) =
            li [] [ checkbox index selectionItem, itemRenderer item ]

        checkbox index selectionItem =
            input
                [ type_ "checkbox"
                , checked selectionItem.isSelected
                , onCheck (updateSelectionState index selectionItem)
                ]
                []

        updateSelectionState index selectionItem v =
            SelectionItem { selectionItem | isSelected = v }
                |> MyList.replace selectionItems index
                |> Selection
                |> callback
    in
        this
