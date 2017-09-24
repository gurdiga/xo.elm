module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList
    exposing
        ( EditableList(EditableList)
        , fromItems
        , view
        )

import Html exposing (Html, h1, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
import Utils.MyHtml exposing (whenTrue, whenNonEmpty, whenNonNothing)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))


type EditableList
    = EditableList
        { items : List BunUrmarit
        , maybeItemToEdit : Maybe ItemToEdit
        }


type ItemToEdit
    = ItemToEdit
        { item : BunUrmarit
        , maybeIndex : Maybe Int
        }


fromItems : List BunUrmarit -> EditableList
fromItems items =
    EditableList
        { items = items
        , maybeItemToEdit = Nothing
        }


updateItem : EditableList -> BunUrmarit -> Maybe Int -> EditableList
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


resetItemToEdit : EditableList -> EditableList
resetItemToEdit (EditableList data) =
    EditableList { data | maybeItemToEdit = Nothing }


updateItemToEdit : EditableList -> BunUrmarit -> Maybe Int -> EditableList
updateItemToEdit (EditableList data) bunUrmarit maybeIndex =
    EditableList { data | maybeItemToEdit = Just (ItemToEdit { item = bunUrmarit, maybeIndex = maybeIndex }) }


view : EditableList -> (EditableList -> msg) -> Html msg
view ((EditableList { items, maybeItemToEdit }) as v) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "EditableList" ]
                , whenNonEmpty items
                    (\items ->
                        itemListView items
                            (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> c)
                    )
                , case maybeItemToEdit of
                    Just itemToEdit ->
                        editItemForm itemToEdit

                    Nothing ->
                        addItemButton
                ]

        c bunuriUrmarite =
            callback bunuriUrmarite

        editItemForm (ItemToEdit { item, maybeIndex }) =
            BunUrmarit.editForm item
                (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> c)
                (\bunUrmarit -> updateItem v bunUrmarit maybeIndex |> c)
                (\bunUrmarit -> resetItemToEdit v |> c)

        addItemButton =
            button
                [ onClick (\_ -> updateItemToEdit v BunUrmarit.empty Nothing |> c) ]
                [ text "Adaugă bun" ]
    in
        this


itemListView : List BunUrmarit -> (BunUrmarit -> Int -> msg) -> Html msg
itemListView items editCallback =
    let
        renderItem index item =
            li []
                [ BunUrmarit.view item
                , button [ onClick (\_ -> editCallback item index) ] [ text "Edit" ]
                ]
    in
        ul [] (List.indexedMap renderItem items)
