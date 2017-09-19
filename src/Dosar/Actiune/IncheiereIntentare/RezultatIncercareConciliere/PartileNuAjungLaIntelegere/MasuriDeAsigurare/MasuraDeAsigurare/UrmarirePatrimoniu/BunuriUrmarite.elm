module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
import Html.Attributes exposing (type_, checked)
import Html.Events exposing (onCheck)
import Utils.MyHtml exposing (whenTrue, whenNonEmpty, whenNonNothing)
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
        , isSelectionStarted : Bool
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
        , isSelectionStarted = False
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


setIsSelectionPending : BunuriUrmarite -> Bool -> BunuriUrmarite
setIsSelectionPending (BunuriUrmarite data) v =
    BunuriUrmarite { data | isSelectionStarted = v }


updateItem : BunuriUrmarite -> Item -> Maybe Int -> BunuriUrmarite
updateItem ((BunuriUrmarite ({ items } as data)) as bunuriUrmarite) item maybeIndex =
    let
        newItems =
            case maybeIndex of
                Just index ->
                    MyList.replace items index item

                Nothing ->
                    items ++ [ item ]
    in
        BunuriUrmarite
            { data
                | items = newItems
                , maybeItemToEdit = Nothing
            }


commitItem : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
commitItem bunuriUrmarite bunUrmarit maybeIndex =
    let
        item =
            (Selectable { item = bunUrmarit, isSelected = False })
    in
        updateItem bunuriUrmarite item maybeIndex


clearSelection : BunuriUrmarite -> BunuriUrmarite
clearSelection ((BunuriUrmarite ({ items } as data)) as bunuriUrmarite) =
    let
        unselect (Selectable bunUrmarit) =
            Selectable { bunUrmarit | isSelected = False }
    in
        BunuriUrmarite { data | items = List.map unselect items }


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
view ((BunuriUrmarite { items, maybeItemToEdit, isSelectionStarted }) as v) callback =
    let
        formeazaProcesVerbal _ =
            setIsSelectionPending v False
                |> clearSelection
                |> processSelectedItems
                |> callback

        cancelAction _ =
            setIsSelectionPending v False
                |> clearSelection
                |> callback

        startSelection _ =
            setIsSelectionPending v True
                |> callback
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , whenNonEmpty items
                (\items ->
                    div []
                        [ whenTrue (not isSelectionStarted)
                            (\_ -> button [ onClick startSelection ] [ text "Aplică sechestru" ])
                        , whenTrue isSelectionStarted
                            (\_ ->
                                div []
                                    [ p [] [ strong [] [ text "Aplicare sechestru" ] ]
                                    , p []
                                        [ text "Selectează bunurile sau "
                                        , button [ onClick cancelAction ] [ text "Anulează" ]
                                        , text "."
                                        ]
                                    ]
                            )
                        , itemListView items
                            isSelectionStarted
                            (\item index -> updateItem v item (Just index) |> callback)
                            (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> callback)
                        , whenTrue (anyItemSelected v)
                            (\_ -> div [] [ button [ onClick formeazaProcesVerbal ] [ text "Formează proces-verbal" ] ])
                        ]
                )
            , whenNonNothing maybeItemToEdit
                (\(ItemToEdit { item, maybeIndex }) ->
                    BunUrmarit.editForm item
                        (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> callback)
                        (\bunUrmarit -> commitItem v bunUrmarit maybeIndex |> callback)
                        (\bunUrmarit -> resetItemToEdit v |> callback)
                )
            , whenTrue (not isSelectionStarted)
                (\_ ->
                    button
                        [ onClick (\_ -> updateItemToEdit v BunUrmarit.empty Nothing |> callback) ]
                        [ text "+" ]
                )
            ]


itemListView : Items -> Bool -> (Item -> Int -> msg) -> (BunUrmarit -> Int -> msg) -> Html msg
itemListView items shouldDisplayCheckboxes updateCallback editCallback =
    let
        renderItem i v =
            selectableItemView v
                shouldDisplayCheckboxes
                (\item -> updateCallback item i)
                (\bunUrmarit -> editCallback bunUrmarit i)
    in
        ul [] (List.indexedMap renderItem items)


selectableItemView : Item -> Bool -> (Item -> msg) -> (BunUrmarit -> msg) -> Html msg
selectableItemView (Selectable ({ item, isSelected } as data)) shouldDisplayCheckbox updateCallback editCallback =
    let
        shouldDisplayEditButton =
            not shouldDisplayCheckbox

        checkbox =
            input
                [ type_ "checkbox"
                , checked isSelected
                , onCheck (\v -> Selectable { data | isSelected = v } |> updateCallback)
                ]
                []
    in
        li []
            [ whenTrue shouldDisplayCheckbox (\_ -> checkbox)
            , BunUrmarit.view item
            , whenTrue shouldDisplayEditButton
                (\_ ->
                    button [ onClick (\_ -> editCallback item) ] [ text "Edit" ]
                )
            ]
