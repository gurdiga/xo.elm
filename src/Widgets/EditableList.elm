module Widgets.EditableList exposing (Model, addItem, initialModel, resetItemToAdd, resetItemToEdit, setItemToAdd, setItemToEdit, setItems, view)

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


initialModel : Items a -> Model a
initialModel items =
    { items = items
    , itemToAdd = Nothing
    , itemToEdit = Nothing
    }


setItems : Items a -> Model a -> Model a
setItems items model =
    { model
        | items = items
        , itemToEdit = Nothing
    }


setItemToEdit : ItemToEdit a -> Model a -> Model a
setItemToEdit itemToEdit model =
    { model | itemToEdit = itemToEdit }


resetItemToEdit : Model a -> Model a
resetItemToEdit =
    setItemToEdit Nothing


setItemToAdd : ItemToAdd a -> Model a -> Model a
setItemToAdd itemToAdd model =
    { model | itemToAdd = itemToAdd }


resetItemToAdd : Model a -> Model a
resetItemToAdd =
    setItemToAdd Nothing


addItem : a -> Model a -> Model a
addItem item model =
    { model
        | items = model.items ++ [ item ]
        , itemToAdd = Nothing
    }


type alias ViewItem a msg =
    Int -> a -> Html msg


type alias ViewItemAdd a msg =
    a -> Html msg


type alias ViewItemEdit a msg =
    ( Int, a ) -> Html msg


type alias Config a msg =
    { viewNoItems : Html msg
    , viewItem : ViewItem a msg
    , viewItemAdd : ViewItemAdd a msg
    , viewItemEdit : ViewItemEdit a msg
    , viewAddItemButton : Html msg
    }


view : Config a msg -> Model a -> Html msg
view config model =
    fieldset []
        [ legend [] [ text "EditableList" ]
        , if List.isEmpty model.items then
            p [] [ config.viewNoItems ]
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
