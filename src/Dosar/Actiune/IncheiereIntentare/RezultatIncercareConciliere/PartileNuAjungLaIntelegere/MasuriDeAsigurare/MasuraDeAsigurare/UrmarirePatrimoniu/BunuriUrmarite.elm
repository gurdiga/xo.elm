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
        { item : BunUrmarit
        , index : Maybe Int
        }


type alias Items =
    List Item


type alias Item =
    Selectable BunUrmarit


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


submitItem : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
submitItem ((BunuriUrmarite { items, itemToEdit }) as bunuriUrmarite) v index =
    -- TODO: make this nice
    setItems
        (resetItemToEdit bunuriUrmarite)
        (case index of
            Just index ->
                MyList.replace items index (Selectable { isSelected = False, item = v })

            Nothing ->
                items ++ [ Selectable { isSelected = False, item = v } ]
        )


setItemToEdit : BunuriUrmarite -> Maybe ItemToEdit -> BunuriUrmarite
setItemToEdit (BunuriUrmarite data) v =
    BunuriUrmarite { data | itemToEdit = v }


resetItemToEdit : BunuriUrmarite -> BunuriUrmarite
resetItemToEdit bunuriUrmarite =
    setItemToEdit bunuriUrmarite Nothing


updateItemToEdit : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
updateItemToEdit bunuriUrmarite bunUrmarit index =
    setItemToEdit bunuriUrmarite
        (Just (ItemToEdit { item = bunUrmarit, index = index }))


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view ((BunuriUrmarite { items, itemToEdit }) as v) callback =
    fieldset []
        [ legend [] [ text "BunuriUrmarite" ]
        , withNonEmpty items
            (\items ->
                itemListView items
                    (\items -> setItems v items |> callback)
                    (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> callback)
            )
        , withNonNothing itemToEdit
            (\(ItemToEdit { item, index }) ->
                BunUrmarit.editForm item
                    (\bunUrmarit -> updateItemToEdit v item index |> callback)
                    (\bunUrmarit -> submitItem v item index |> callback)
                    (\bunUrmarit -> resetItemToEdit v |> callback)
            )
        , button
            [ onClick (\_ -> updateItemToEdit v BunUrmarit.empty Nothing |> callback) ]
            [ text "+" ]
        ]


itemListView : Items -> (Items -> msg) -> (BunUrmarit -> Int -> msg) -> Html msg
itemListView items updateCallback editCallback =
    let
        updateItem i v =
            MyList.replace items i v

        renderItem i v =
            selectableItemView v
                (updateItem i >> updateCallback)
                (\bunUrmarit -> editCallback bunUrmarit i)
    in
        ul [] (List.indexedMap renderItem items)


selectableItemView : Item -> (Item -> msg) -> (BunUrmarit -> msg) -> Html msg
selectableItemView (Selectable { item, isSelected }) updateCallback editCallback =
    li []
        ([ input
            [ type_ "checkbox"
            , checked isSelected
            , onCheck (\v -> Selectable { item = item, isSelected = v } |> updateCallback)
            ]
            []
         ]
            ++ BunUrmarit.view item
            ++ [ button [ onClick (\_ -> editCallback item) ] [ text "Edit" ] ]
        )


withNonNothing : Maybe a -> (a -> Html msg) -> Html msg
withNonNothing maybeV renderer =
    case maybeV of
        Just v ->
            renderer v

        Nothing ->
            text ""


withNonEmpty : List a -> (List a -> Html msg) -> Html msg
withNonEmpty list renderer =
    if List.isEmpty list then
        text ""
    else
        renderer list
