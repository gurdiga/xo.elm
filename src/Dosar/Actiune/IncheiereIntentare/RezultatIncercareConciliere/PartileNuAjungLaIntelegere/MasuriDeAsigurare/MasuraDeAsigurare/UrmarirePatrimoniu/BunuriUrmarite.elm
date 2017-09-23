module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite
    exposing
        ( BunuriUrmarite(BunuriUrmarite)
        , empty
        , view
        , bunuriUrmarite
        )

import Html exposing (Html, h1, fieldset, legend, div, span, ul, li, p, button, input, text, strong, br)
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
        { items : List BunUrmarit
        , maybeItemToEdit : Maybe ItemToEdit
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
        }


someItems : List BunUrmarit
someItems =
    [ BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
    , BunUrmarit { denumire = "Automobil Porche", valoare = Money 250000 USD, note = "Yeah!" }
    ]


updateItem : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
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


resetItemToEdit : BunuriUrmarite -> BunuriUrmarite
resetItemToEdit (BunuriUrmarite data) =
    BunuriUrmarite { data | maybeItemToEdit = Nothing }


updateItemToEdit : BunuriUrmarite -> BunUrmarit -> Maybe Int -> BunuriUrmarite
updateItemToEdit (BunuriUrmarite data) bunUrmarit maybeIndex =
    BunuriUrmarite { data | maybeItemToEdit = Just (ItemToEdit { item = bunUrmarit, maybeIndex = maybeIndex }) }


bunuriUrmarite : BunuriUrmarite -> List BunUrmarit
bunuriUrmarite (BunuriUrmarite { items }) =
    items


type alias Callback msg =
    BunuriUrmarite -> Cmd msg -> Sub msg -> msg


view : BunuriUrmarite -> Callback msg -> Html msg
view ((BunuriUrmarite ({ items, maybeItemToEdit } as data)) as v) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "BunuriUrmarite" ]
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
            callback bunuriUrmarite Cmd.none Sub.none

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
