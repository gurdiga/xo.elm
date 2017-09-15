module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, ul, li, p, button, input, text, br)
import Html.Attributes exposing (type_, checked)
import Html.Events exposing (onCheck)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList
import Utils.Money as Money exposing (Money(Money), Currency(EUR, USD))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite Data


type alias Data =
    { items : Items
    , itemToEdit : Maybe ItemToEdit
    }


type ItemToEdit
    = ItemToEdit
        { index : Maybe Int
        , item : BunUrmarit
        }


type alias Items =
    List (Selectable BunUrmarit)


type Selectable a
    = Selectable
        { isSelected : Bool
        , item : a
        }


empty : BunuriUrmarite
empty =
    BunuriUrmarite
        { items = someItems
        , itemToEdit = Nothing
        }


someItems : Items
someItems =
    [ Selectable
        { item = BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
        , isSelected = False
        }
    , Selectable
        { item = BunUrmarit { denumire = "Automobil Porche", valoare = Money 250000 USD, note = "Yeah!" }
        , isSelected = True
        }
    ]


setItems : Data -> Items -> Data
setItems data v =
    { data | items = v }


addOrReplaceItem : Data -> Maybe Int -> Selectable BunUrmarit -> Items
addOrReplaceItem data index selectableItem =
    case index of
        Just i ->
            MyList.replace data.items i selectableItem

        Nothing ->
            data.items ++ [ selectableItem ]


setItemToEdit : Data -> Maybe ItemToEdit -> Data
setItemToEdit data v =
    { data | itemToEdit = v }


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view bunuriUrmarite callback =
    let
        (BunuriUrmarite data) =
            bunuriUrmarite

        c =
            BunuriUrmarite >> callback

        initItemToEdit _ =
            ItemToEdit { index = Nothing, item = BunUrmarit.empty }
                |> updateItemToEdit

        updateItemToEdit v =
            setItemToEdit data (Just v)

        removeItemToEdit _ =
            setItemToEdit data Nothing

        submitItem (ItemToEdit { item, index }) =
            Selectable { item = item, isSelected = False }
                |> addOrReplaceItem data index
                |> setItems data
                |> (flip setItemToEdit) Nothing

        updateItems v =
            setItems data v
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , itemListView data.items
                (updateItems >> c)
                (updateItemToEdit >> c)
            , editForm data.itemToEdit
                (updateItemToEdit >> c)
                (submitItem >> c)
                (removeItemToEdit >> c)
            , button [ onClick (initItemToEdit >> c) ] [ text "+" ]
            ]


itemListView : Items -> (Items -> msg) -> (ItemToEdit -> msg) -> Html msg
itemListView items updateCallback editCallback =
    if List.length items > 0 then
        let
            updateItem i v =
                MyList.replace items i v

            editItem i v =
                ItemToEdit { index = Just i, item = v }

            renderItem i v =
                itemView v
                    (updateItem i >> updateCallback)
                    (editItem i >> editCallback)
        in
            ul [] (List.indexedMap renderItem items)
    else
        text ""


itemView : Selectable BunUrmarit -> (Selectable BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
itemView selectableBunUrmarit updateCallback editCallback =
    let
        (Selectable data) =
            selectableBunUrmarit

        setIsSelected v =
            Selectable { data | isSelected = v }
    in
        li []
            ([ input
                [ type_ "checkbox"
                , checked data.isSelected
                , onCheck (setIsSelected >> updateCallback)
                ]
                []
             ]
                ++ BunUrmarit.view data.item
                ++ [ button [ onClick (\_ -> editCallback data.item) ] [ text "Edit" ] ]
            )


editForm : Maybe ItemToEdit -> (ItemToEdit -> msg) -> (ItemToEdit -> msg) -> (ItemToEdit -> msg) -> Html msg
editForm maybeItemToEdit updateItemToEditCallback submitItemCallback cancelEditCallback =
    case maybeItemToEdit of
        Just (ItemToEdit { index, item }) ->
            let
                makeItemToEdit v =
                    ItemToEdit { index = index, item = v }
            in
                BunUrmarit.editForm item
                    (makeItemToEdit >> updateItemToEditCallback)
                    (makeItemToEdit >> submitItemCallback)
                    (makeItemToEdit >> cancelEditCallback)

        Nothing ->
            text ""
