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
    , itemToEdit : Maybe BunUrmarit
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


setItemToEdit : Data -> Maybe BunUrmarit -> Data
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
            updateItemToEdit BunUrmarit.empty

        updateItemToEdit v =
            setItemToEdit data (Just v)

        removeItemToEdit _ =
            setItemToEdit data Nothing

        submitItemItoEdit v =
            [ Selectable { item = v, isSelected = False } ]
                |> List.append data.items
                |> setItems data
                |> (flip setItemToEdit) Nothing

        updateItems v =
            setItems data v
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , maybeItemListView data.items (updateItems >> c)
            , editForm data.itemToEdit
                (updateItemToEdit >> c)
                (submitItemItoEdit >> c)
                (removeItemToEdit >> c)
            , button [ onClick (initItemToEdit >> c) ] [ text "+" ]
            ]


maybeItemListView : List (Selectable BunUrmarit) -> (List (Selectable BunUrmarit) -> msg) -> Html msg
maybeItemListView items callback =
    if List.length items > 0 then
        let
            updateItem i v =
                MyList.replace items i v

            renderItem i v =
                itemView v (updateItem i >> callback)
        in
            ul [] (List.indexedMap renderItem items)
    else
        text ""


itemView : Selectable BunUrmarit -> (Selectable BunUrmarit -> msg) -> Html msg
itemView selectableBunUrmarit callback =
    let
        c =
            Selectable >> callback

        (Selectable data) =
            selectableBunUrmarit

        setIsSelected v =
            { data | isSelected = v }

        checkbox =
            input [ type_ "checkbox", checked data.isSelected, onCheck (setIsSelected >> c) ] []
    in
        li [] (checkbox :: BunUrmarit.view data.item)


editForm : Maybe BunUrmarit -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback =
    case itemToEdit of
        Just itemToEdit ->
            BunUrmarit.editForm itemToEdit updateItemToEdit submitItemCallback cancelEditCallback

        Nothing ->
            text ""
