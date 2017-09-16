module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, div, ul, li, p, button, input, text, br)
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
        , maybeItemToEdit : Maybe ItemToEdit
        , isSelectionPending : Bool
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


type ItemToEdit
    = ItemToEdit
        { item : BunUrmarit
        , maybeIndex : Maybe Int
        }


empty : BunuriUrmarite
empty =
    BunuriUrmarite
        { items = someItems
        , maybeItemToEdit = Nothing
        , isSelectionPending = False
        }


someItems : Items
someItems =
    [ Selectable
        { item = BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
        , isSelected = False
        }
    , Selectable
        { item = BunUrmarit { denumire = "Automobil Porche", valoare = Money 250000 USD, note = "Yeah!" }
        , isSelected = False
        }
    ]


setItems : BunuriUrmarite -> Items -> BunuriUrmarite
setItems (BunuriUrmarite data) v =
    BunuriUrmarite { data | items = v }


setIsSelectionPending : BunuriUrmarite -> Bool -> BunuriUrmarite
setIsSelectionPending (BunuriUrmarite data) v =
    BunuriUrmarite { data | isSelectionPending = v }


submitItem : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
submitItem ((BunuriUrmarite { items }) as bunuriUrmarite) bunUrmarit maybeIndex =
    let
        item =
            Selectable { isSelected = False, item = bunUrmarit }

        newItems =
            case maybeIndex of
                Just index ->
                    MyList.replace items index item

                Nothing ->
                    items ++ [ item ]
    in
        setItems bunuriUrmarite newItems
            |> resetItemToEdit


resetSelectedItems : BunuriUrmarite -> BunuriUrmarite
resetSelectedItems ((BunuriUrmarite ({ items } as data)) as bunuriUrmarite) =
    let
        newItems =
            List.map (\(Selectable bunUrmarit) -> Selectable { bunUrmarit | isSelected = False }) items
    in
        BunuriUrmarite { data | items = newItems }


setItemToEdit : BunuriUrmarite -> Maybe ItemToEdit -> BunuriUrmarite
setItemToEdit (BunuriUrmarite data) v =
    BunuriUrmarite { data | maybeItemToEdit = v }


resetItemToEdit : BunuriUrmarite -> BunuriUrmarite
resetItemToEdit bunuriUrmarite =
    setItemToEdit bunuriUrmarite Nothing


updateItemToEdit : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
updateItemToEdit bunuriUrmarite bunUrmarit maybeIndex =
    setItemToEdit bunuriUrmarite
        (Just (ItemToEdit { item = bunUrmarit, maybeIndex = maybeIndex }))


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view ((BunuriUrmarite { items, maybeItemToEdit, isSelectionPending }) as v) callback =
    fieldset []
        [ legend [] [ text "BunuriUrmarite" ]
        , withNonEmpty items
            (\items ->
                div []
                    [ button [ onClick (\_ -> setIsSelectionPending v True |> callback) ] [ text "Start action" ]
                    , withTrue isSelectionPending
                        (\_ ->
                            button [ onClick (\_ -> setIsSelectionPending v False |> resetSelectedItems |> callback) ] [ text "Cancel" ]
                        )
                    , itemListView items
                        isSelectionPending
                        (\(Selectable { item }) index -> submitItem v item (Just index) |> callback)
                        (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> callback)
                    ]
            )
        , withNonNothing maybeItemToEdit
            (\(ItemToEdit { item, maybeIndex }) ->
                BunUrmarit.editForm item
                    (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> callback)
                    (\bunUrmarit -> submitItem v bunUrmarit maybeIndex |> callback)
                    (\bunUrmarit -> resetItemToEdit v |> callback)
            )
        , button
            [ onClick (\_ -> updateItemToEdit v BunUrmarit.empty Nothing |> callback) ]
            [ text "+" ]
        ]


itemListView : Items -> Bool -> (Item -> Int -> msg) -> (BunUrmarit -> Int -> msg) -> Html msg
itemListView items isSelectionPending updateCallback editCallback =
    let
        renderItem i v =
            selectableItemView v
                isSelectionPending
                (\item -> updateCallback item i)
                (\bunUrmarit -> editCallback bunUrmarit i)
    in
        ul [] (List.indexedMap renderItem items)


selectableItemView : Item -> Bool -> (Item -> msg) -> (BunUrmarit -> msg) -> Html msg
selectableItemView (Selectable { item, isSelected }) shouldDisplayCheckbox updateCallback editCallback =
    li []
        [ withTrue shouldDisplayCheckbox
            (\_ ->
                input
                    [ type_ "checkbox"
                    , checked isSelected
                    , onCheck (\v -> Selectable { item = item, isSelected = v } |> updateCallback)
                    ]
                    []
            )
        , BunUrmarit.view item
        , button [ onClick (\_ -> editCallback item) ] [ text "Edit" ]
        ]


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


withTrue : Bool -> (Bool -> Html msg) -> Html msg
withTrue v renderer =
    if v == True then
        renderer v
    else
        text ""
