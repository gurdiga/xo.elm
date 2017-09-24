module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList
    exposing
        ( EditableList
        , fromItems
        , view
        )

import Html exposing (Html, h1, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
import Utils.MyHtml exposing (whenTrue, whenNonEmpty, whenNonNothing)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList


type EditableList a
    = EditableList
        { items : List a
        , maybeItemToEdit : Maybe (ItemToEdit a)
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


fromItems : List a -> EditableList a
fromItems items =
    EditableList
        { items = items
        , maybeItemToEdit = Nothing
        }


updateItem : EditableList a -> a -> Maybe Int -> EditableList a
updateItem ((EditableList ({ items } as data)) as bunuriUrmarite) item maybeIndex =
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
updateItemToEdit (EditableList data) bunUrmarit maybeIndex =
    EditableList { data | maybeItemToEdit = Just (ItemToEdit { item = bunUrmarit, maybeIndex = maybeIndex }) }


view : EditableList a -> ItemEditForm a msg -> ItemView a msg -> a -> (EditableList a -> msg) -> Html msg
view ((EditableList { items, maybeItemToEdit }) as v) itemEditFormView itemView newItem callback =
    let
        this =
            fieldset []
                [ legend [] [ text "EditableList" ]
                , whenNonEmpty items
                    (\items ->
                        itemListView itemView
                            items
                            (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> callback)
                    )
                , case maybeItemToEdit of
                    Just itemToEdit ->
                        itemEditForm itemToEdit

                    Nothing ->
                        addItemButton
                ]

        itemEditForm (ItemToEdit { item, maybeIndex }) =
            itemEditFormView item
                (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> callback)
                (\bunUrmarit -> updateItem v bunUrmarit maybeIndex |> callback)
                (\bunUrmarit -> resetItemToEdit v |> callback)

        addItemButton =
            button
                [ onClick (\_ -> updateItemToEdit v newItem Nothing |> callback) ]
                [ text "Adaugă bun" ]
    in
        this


itemListView : ItemView a msg -> List a -> (a -> Int -> msg) -> Html msg
itemListView itemView items editCallback =
    let
        this =
            ul [] (List.indexedMap renderItem items)

        renderItem index item =
            li []
                [ itemView item
                , button [ onClick (\_ -> editCallback item index) ] [ text "Edit" ]
                ]
    in
        this
