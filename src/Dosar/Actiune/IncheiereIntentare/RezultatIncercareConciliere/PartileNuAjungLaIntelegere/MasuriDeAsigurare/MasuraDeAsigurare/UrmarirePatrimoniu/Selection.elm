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


type alias Input a msg =
    { selection : Selection a
    , itemDisplayView : a -> Html msg
    , callback : Selection a -> msg
    }


view : Input a msg -> Html msg
view { selection, itemDisplayView, callback } =
    let
        this =
            ul [] (List.indexedMap renderItem selectionItems)

        (Selection selectionItems) =
            selection

        renderItem index (SelectionItem ({ item } as selectionItem)) =
            li [] [ checkbox index selectionItem, itemDisplayView item ]

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
