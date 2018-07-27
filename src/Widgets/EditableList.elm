module Widgets.EditableList exposing (Model, initialModel, setItemToEdit, setItems, view)

import Html.Styled exposing (Html, button, fieldset, legend, li, p, text, ul)


type alias Model a =
    { items : Items a
    , itemToAdd : ItemToAdd a
    , itemToEdit : ItemToEdit a
    }


type alias Items a =
    List a


type alias ItemToAdd a =
    Maybe a


type alias ItemToEdit a =
    Maybe ( Int, a )


initialModel : Items a -> ItemToAdd a -> ItemToEdit a -> Model a
initialModel items itemToAdd itemToEdit =
    { items = items
    , itemToAdd = itemToAdd
    , itemToEdit = itemToEdit
    }


setItems : Items a -> Model a -> Model a
setItems items model =
    { model | items = items }


setItemToEdit : ItemToEdit a -> Model a -> Model a
setItemToEdit itemToEdit model =
    { model | itemToEdit = itemToEdit }


setItemToAdd : ItemToAdd a -> Model a -> Model a
setItemToAdd itemToAdd model =
    { model | itemToAdd = itemToAdd }


type alias ViewItem a msg =
    Int -> a -> Html msg


type alias ViewItemAdd a msg =
    a -> Html msg


type alias ViewItemEdit a msg =
    ( Int, a ) -> Html msg


type alias Config a msg =
    { noItemsView : Maybe (Html msg)
    , viewItemAdd : ViewItemAdd a msg
    , viewItem : ViewItem a msg
    , viewItemEdit : ViewItemEdit a msg
    , viewAddItemButton : Html msg
    }


view : Config a msg -> Model a -> Html msg
view config model =
    fieldset []
        [ legend [] [ text "EditableList" ]
        , if List.isEmpty model.items then
            p [] [ config.noItemsView |> Maybe.withDefault (text "No items.") ]
          else
            viewList config.viewItem model.items
        , model.itemToAdd
            |> Maybe.map config.viewItemAdd
            |> Maybe.withDefault
                (model.itemToEdit
                    |> Maybe.map config.viewItemEdit
                    |> Maybe.withDefault config.viewAddItemButton
                )
        ]


viewList : ViewItem a msg -> List a -> Html msg
viewList viewItem items =
    ul [] (List.indexedMap viewItem items)
