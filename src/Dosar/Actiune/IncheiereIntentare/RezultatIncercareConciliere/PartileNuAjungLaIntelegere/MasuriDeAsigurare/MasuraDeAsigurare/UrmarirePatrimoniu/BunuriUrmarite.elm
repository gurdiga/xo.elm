module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, div, span, ul, li, p, button, input, text, br)
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


updateItem : BunuriUrmarite -> Item -> Maybe Int -> BunuriUrmarite
updateItem ((BunuriUrmarite { items }) as bunuriUrmarite) item maybeIndex =
    let
        newItems =
            case maybeIndex of
                Just index ->
                    MyList.replace items index item

                Nothing ->
                    items ++ [ item ]
    in
        setItems bunuriUrmarite newItems
            |> resetItemToEdit


commitItem : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
commitItem bunuriUrmarite bunUrmarit maybeIndex =
    let
        item =
            (Selectable { item = bunUrmarit, isSelected = False })
    in
        updateItem bunuriUrmarite item maybeIndex


resetSelectedItems : BunuriUrmarite -> BunuriUrmarite
resetSelectedItems ((BunuriUrmarite ({ items } as data)) as bunuriUrmarite) =
    let
        unselect (Selectable bunUrmarit) =
            Selectable { bunUrmarit | isSelected = False }

        newItems =
            List.map unselect items
    in
        BunuriUrmarite { data | items = newItems }


anyItemSelected : BunuriUrmarite -> Bool
anyItemSelected (BunuriUrmarite { items }) =
    let
        isSelected (Selectable bunUrmarit) =
            bunUrmarit.isSelected
    in
        List.any isSelected items


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


processSelectedItems : BunuriUrmarite -> BunuriUrmarite
processSelectedItems bunuriUrmarite =
    Debug.log "processItems" bunuriUrmarite


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view ((BunuriUrmarite { items, maybeItemToEdit, isSelectionPending }) as v) callback =
    let
        actionButtons =
            span []
                [ whenTrue (anyItemSelected v)
                    (\_ -> button [ onClick (\_ -> doProcessSelectedItems) ] [ text "Commit" ])
                , button [ onClick (\_ -> doCancelAction) ] [ text "Cancel" ]
                ]

        doProcessSelectedItems =
            processSelectedItems v
                |> (flip setIsSelectionPending) False
                |> callback

        doCancelAction =
            setIsSelectionPending v False
                |> resetSelectedItems
                |> callback
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , whenNonEmpty items
                (\items ->
                    div []
                        [ button [ onClick (\_ -> setIsSelectionPending v True |> callback) ] [ text "Start action" ]
                        , whenTrue isSelectionPending (\_ -> actionButtons)
                        , itemListView items
                            isSelectionPending
                            (\item index -> updateItem v item (Just index) |> callback)
                            (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> callback)
                        ]
                )
            , whenNonNothing maybeItemToEdit
                (\(ItemToEdit { item, maybeIndex }) ->
                    BunUrmarit.editForm item
                        (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> callback)
                        (\bunUrmarit -> commitItem v bunUrmarit maybeIndex |> callback)
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
selectableItemView (Selectable ({ item, isSelected } as data)) shouldDisplayCheckbox updateCallback editCallback =
    li []
        [ whenTrue shouldDisplayCheckbox
            (\_ ->
                input
                    [ type_ "checkbox"
                    , checked isSelected
                    , onCheck (\v -> Selectable { data | isSelected = v } |> updateCallback)
                    ]
                    []
            )
        , BunUrmarit.view item
        , button [ onClick (\_ -> editCallback item) ] [ text "Edit" ]
        ]


whenNonNothing : Maybe a -> (a -> Html msg) -> Html msg
whenNonNothing maybeV renderer =
    case maybeV of
        Just v ->
            renderer v

        Nothing ->
            text ""


whenNonEmpty : List a -> (List a -> Html msg) -> Html msg
whenNonEmpty list renderer =
    if List.isEmpty list then
        text ""
    else
        renderer list


whenTrue : Bool -> (Bool -> Html msg) -> Html msg
whenTrue v renderer =
    if v == True then
        renderer v
    else
        text ""
