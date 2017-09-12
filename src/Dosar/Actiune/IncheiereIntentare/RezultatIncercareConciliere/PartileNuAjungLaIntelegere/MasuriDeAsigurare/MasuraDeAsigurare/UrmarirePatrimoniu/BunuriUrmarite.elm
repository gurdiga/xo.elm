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
        (BunuriUrmarite data) =
            bunuriUrmarite

        c =
            BunuriUrmarite >> callback

        setItemToEdit data v =
            { data | itemToEdit = v }

        setItems data v =
            { data | items = v }

        removeItemToEdit _ =
            setItemToEdit data Nothing

        initItemToEdit _ =
            updateItemToEdit BunUrmarit.empty

        updateItemToEdit v =
            setItemToEdit data (Just v)

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
            , itemListView data.items (updateItems >> c)
            , editForm data.itemToEdit
                (updateItemToEdit >> c)
                (submitItemItoEdit >> c)
                (removeItemToEdit >> c)
            , button [ onClick (initItemToEdit >> c) ] [ text "+" ]
            ]


itemListView : List (Selectable BunUrmarit) -> (List (Selectable BunUrmarit) -> msg) -> Html msg
itemListView items callback =
    if List.length items > 0 then
        let
            updateItem index item =
                MyList.replace items index item
                    |> callback
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
