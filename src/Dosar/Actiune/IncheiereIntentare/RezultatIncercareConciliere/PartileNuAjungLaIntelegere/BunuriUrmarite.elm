module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite exposing (BunuriUrmarite, empty, view)

import Html exposing (Html, fieldset, legend, ul, li, p, button, text, br)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.Money as Money exposing (Money(Money), Currency(EUR))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite Data


type alias Data =
    { items : List BunUrmarit
    , itemToEdit : Maybe BunUrmarit
    }


empty : BunuriUrmarite
empty =
    BunuriUrmarite
        { items =
            [ BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
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
            callback (BunuriUrmarite { items = items ++ [ item ], itemToEdit = Nothing })

        cancelEditCallback item =
            callback (BunuriUrmarite { items = items, itemToEdit = Nothing })
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , itemList items
            , editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback
            , button [ onClick (\_ -> updateItemToEdit BunUrmarit.empty) ] [ text "+" ]
            ]


itemList : List BunUrmarit -> Html msg
itemList items =
    let
        itemView =
            li [] << BunUrmarit.view
    in
        if List.length items > 0 then
            ul [] <| List.map itemView items
        else
            text ""


editForm : Maybe BunUrmarit -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback =
    case itemToEdit of
        Just itemToEdit ->
            BunUrmarit.editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback

        Nothing ->
            text ""
