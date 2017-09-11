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
import Utils.Money as Money exposing (Money(Money), Currency(EUR))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite Data


type alias Data =
    { items : List (Selectable BunUrmarit)
    , itemToEdit : Maybe BunUrmarit
    }


type Selectable a
    = Selectable
        { isSelected : Bool
        , item : a
        }


empty : BunuriUrmarite
empty =
    BunuriUrmarite
        { items =
            [ Selectable
                { item = BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
                , isSelected = False
                }
            ]
        , itemToEdit = Nothing
        }


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view bunuriUrmarite callback =
    let
        (BunuriUrmarite { items, itemToEdit }) =
            bunuriUrmarite

        updateItemToEdit item =
            callback (BunuriUrmarite { items = items, itemToEdit = Just item })

        submitItemCallback item =
            callback (BunuriUrmarite { items = items ++ [ Selectable { item = item, isSelected = False } ], itemToEdit = Nothing })

        cancelEditCallback item =
            callback (BunuriUrmarite { items = items, itemToEdit = Nothing })

        updateItems items =
            callback (BunuriUrmarite { items = items, itemToEdit = itemToEdit })
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , itemListView items updateItems
            , editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback
            , button [ onClick (\_ -> updateItemToEdit BunUrmarit.empty) ] [ text "+" ]
            ]


itemListView : List (Selectable BunUrmarit) -> (List (Selectable BunUrmarit) -> msg) -> Html msg
itemListView items callback =
    if List.length items > 0 then
        let
            updateItem index item =
                callback (MyList.replace items index item)
        in
            ul [] <| List.indexedMap (\index v -> itemView v (updateItem index)) items
    else
        text ""


itemView : Selectable BunUrmarit -> (Selectable BunUrmarit -> msg) -> Html msg
itemView selectableBunUrmarit callback =
    let
        (Selectable { isSelected, item }) =
            selectableBunUrmarit

        checkbox =
            input [ type_ "checkbox", checked isSelected, onCheck select ] []

        select isSelected =
            callback (Selectable { isSelected = isSelected, item = item })
    in
        li [] (checkbox :: (BunUrmarit.view item))


editForm : Maybe BunUrmarit -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback =
    case itemToEdit of
        Just itemToEdit ->
            BunUrmarit.editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback

        Nothing ->
            text ""
