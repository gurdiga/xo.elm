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
    = BunuriUrmarite
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


setItems : BunuriUrmarite -> Items -> BunuriUrmarite
setItems (BunuriUrmarite data) v =
    BunuriUrmarite { data | items = v }


addOrReplaceItem : BunuriUrmarite -> Maybe Int -> BunUrmarit -> BunuriUrmarite
addOrReplaceItem ((BunuriUrmarite { items, itemToEdit }) as bunuriUrmarite) index v =
    setItems
        (setItemToEdit bunuriUrmarite Nothing)
        (case index of
            Just index ->
                MyList.replace items index (Selectable { isSelected = False, item = v })

            Nothing ->
                items ++ [ Selectable { isSelected = False, item = v } ]
        )


setItemToEdit : BunuriUrmarite -> Maybe ItemToEdit -> BunuriUrmarite
setItemToEdit (BunuriUrmarite data) v =
    BunuriUrmarite { data | itemToEdit = v }


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view ((BunuriUrmarite { items, itemToEdit }) as v) callback =
    fieldset []
        [ legend [] [ text "BunuriUrmarite" ]
        , itemListView items
            (setItems v >> callback)
            (\i (Selectable { isSelected, item }) -> callback (setItemToEdit v (Just (ItemToEdit { item = item, index = Just i }))))
        , editForm itemToEdit
            (Just >> setItemToEdit v >> callback)
            (\(ItemToEdit { index, item }) -> callback (addOrReplaceItem v index item))
            (\(ItemToEdit { index, item }) -> callback (setItemToEdit v Nothing))
        , button
            [ onClick
                (\_ ->
                    callback <|
                        setItemToEdit v
                            (Just
                                (ItemToEdit
                                    { index = Nothing
                                    , item = BunUrmarit.empty
                                    }
                                )
                            )
                )
            ]
            [ text "+" ]
        ]


itemListView : Items -> (Items -> msg) -> (Int -> Selectable BunUrmarit -> msg) -> Html msg
itemListView items updateCallback editCallback =
    if List.length items > 0 then
        let
            updateItem i v =
                MyList.replace items i v

            renderItem i v =
                itemView v
                    (updateItem i >> updateCallback)
                    (editCallback i)
        in
            ul [] (List.indexedMap renderItem items)
    else
        text ""


itemView : Selectable BunUrmarit -> (Selectable BunUrmarit -> msg) -> (Selectable BunUrmarit -> msg) -> Html msg
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
                ++ [ button [ onClick (\_ -> editCallback selectableBunUrmarit) ] [ text "Edit" ] ]
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
