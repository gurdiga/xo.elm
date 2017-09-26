module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList
    exposing
        ( EditableList
        , new
        , view
        )

import Html exposing (Html, h1, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
import Utils.MyHtml exposing (whenTrue, whenNonEmpty, whenNothing, whenNonNothing)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList


type EditableList a
    = EditableList
        { items : List a
        , maybeItemToEdit : Maybe (ItemToEdit a)
        , inAddMode : Bool
        , hasExternalAddTrigger : Bool
        }


type ItemToEdit a
    = ItemToEdit
        { item : a
        , maybeIndex : Maybe Int
        }


type alias ItemView a msg =
    a -> Html msg


type alias ItemEditForm a msg =
    a
    -> UpdateItemCallback a msg
    -> SubmitItemCallback a msg
    -> CancellCallback a msg
    -> Html msg


type alias UpdateItemCallback a msg =
    a -> msg


type alias SubmitItemCallback a msg =
    a -> msg


type alias CancellCallback a msg =
    a -> msg


new : { items : List a, inAddMode : Bool, hasExternalAddTrigger : Bool } -> EditableList a
new { items, inAddMode, hasExternalAddTrigger } =
    EditableList
        { items = items
        , maybeItemToEdit = Nothing
        , inAddMode = inAddMode
        , hasExternalAddTrigger = hasExternalAddTrigger
        }


submitItem : EditableList a -> a -> Maybe Int -> EditableList a
submitItem (EditableList ({ items } as data)) item maybeIndex =
    let
        newItems =
            case maybeIndex of
                Just index ->
                    MyList.replace items index item

                Nothing ->
                    items ++ [ item ]
    in
        EditableList
            { data
                | items = newItems
                , maybeItemToEdit = Nothing
            }


resetItemToEdit : EditableList a -> EditableList a
resetItemToEdit (EditableList data) =
    EditableList { data | maybeItemToEdit = Nothing }


updateItemToEdit : EditableList a -> a -> Maybe Int -> EditableList a
updateItemToEdit (EditableList data) item maybeIndex =
    EditableList { data | maybeItemToEdit = Just (ItemToEdit { item = item, maybeIndex = maybeIndex }) }


type alias Input a msg =
    { editableList : EditableList a
    , editItemView : ItemEditForm a msg
    , displayItemView : ItemView a msg
    , newItem : a
    , callback : EditableList a -> msg
    }


view : Input a msg -> Html msg
view { editableList, editItemView, displayItemView, newItem, callback } =
    let
        this =
            div []
                [ whenNonEmpty items
                    (itemListView displayItemView (\item index -> updateItemToEdit editableList item (Just index) |> callback))
                , whenNonNothing maybeItemToEdit itemEditForm
                , whenNothing maybeItemToEdit addItemButton
                ]

        (EditableList { items, maybeItemToEdit, hasExternalAddTrigger }) =
            editableList

        itemEditForm (ItemToEdit { item, maybeIndex }) =
            editItemView item
                (\item -> updateItemToEdit editableList item maybeIndex |> callback)
                (\item -> submitItem editableList item maybeIndex |> callback)
                (\item -> resetItemToEdit editableList |> callback)

        addItemButton _ =
            if hasExternalAddTrigger then
                text ""
            else
                button
                    [ onClick (\_ -> updateItemToEdit editableList newItem Nothing |> callback) ]
                    [ text "Adaugă" ]
    in
        this


itemListView : ItemView a msg -> (a -> Int -> msg) -> List a -> Html msg
itemListView itemView editCallback items =
    let
        this =
            ul [] (List.indexedMap renderItem items)

        renderItem index item =
            li []
                [ itemView item
                , button [ onClick (\_ -> editCallback item index) ] [ text "Editează" ]
                ]
    in
        this
