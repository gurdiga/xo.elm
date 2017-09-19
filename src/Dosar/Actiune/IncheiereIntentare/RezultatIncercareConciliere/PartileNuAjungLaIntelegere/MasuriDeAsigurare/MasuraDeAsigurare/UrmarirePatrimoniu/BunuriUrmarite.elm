module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite
        , empty
        , view
        )

import Html exposing (Html, h1, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
import Html.Attributes exposing (type_, checked)
import Html.Events exposing (onCheck)
import Utils.RichTextEditor as RichTextEditor
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
        , procesVerbalSechestru : String
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
        , procesVerbalSechestru = ""
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


processSelectedItems : Callback msg -> BunuriUrmarite -> msg
processSelectedItems callback bunuriUrmarite =
    Debug.log "processItems" (callback bunuriUrmarite Cmd.none Sub.none)


type alias Callback msg =
    BunuriUrmarite -> Cmd msg -> Sub msg -> msg


view : BunuriUrmarite -> Callback msg -> Html msg
view ((BunuriUrmarite ({ items, maybeItemToEdit, isSelectionStarted } as data)) as v) callback =
    let
        c bunuriUrmarite =
            callback bunuriUrmarite Cmd.none Sub.none

        formeazaProcesVerbalSechestru _ =
            setIsSelectionPending v False
                |> clearSelection
                |> processSelectedItems callback

        cancelAction _ =
            setIsSelectionPending v False
                |> clearSelection
                |> c

        startSelection _ =
            setIsSelectionPending v True
                |> c
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
                                p []
                                    [ text "Selectează bunurile care urmează a fi sechestrate sau "
                                    , button [ onClick cancelAction ] [ text "Anulează" ]
                                    , text "."
                                    ]
                            )
                        , itemListView items
                            isSelectionStarted
                            (\item index -> updateItem v item (Just index) |> c)
                            (\bunUrmarit index -> updateItemToEdit v bunUrmarit (Just index) |> c)
                        , whenTrue (anyItemSelected v)
                            (\_ ->
                                div []
                                    [ RichTextEditor.view
                                        { buttonLabel = "Formează proces-verbal de sechestru"
                                        , content = templateProcesVerbalSechestru v
                                        , onOpen = callback v
                                        , onResponse = (\v -> c (BunuriUrmarite { data | procesVerbalSechestru = v }))
                                        }
                                    ]
                            )
                        ]
                )
            , whenNonNothing maybeItemToEdit
                (\(ItemToEdit { item, maybeIndex }) ->
                    BunUrmarit.editForm item
                        (\bunUrmarit -> updateItemToEdit v bunUrmarit maybeIndex |> c)
                        (\bunUrmarit -> commitItem v bunUrmarit maybeIndex |> c)
                        (\bunUrmarit -> resetItemToEdit v |> c)
                )
            , whenTrue (not isSelectionStarted)
                (\_ ->
                    button
                        [ onClick (\_ -> updateItemToEdit v BunUrmarit.empty Nothing |> c) ]
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


templateProcesVerbalSechestru : BunuriUrmarite -> List (Html msg)
templateProcesVerbalSechestru bunuriUrmarite =
    -- TODO: find the real template
    [ h1 [] [ text "Proces-verbal de sechestru" ]
    , p [] [ text <| toString <| bunuriUrmarite ]
    ]
