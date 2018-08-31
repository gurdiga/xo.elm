module Widgets.EditableList exposing (Model, Msg(..), initialModel, update, view)

import Html exposing (Html, button, fieldset, legend, li, p, text, ul)
import Utils.MyList as MyList


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
            ul [] (List.indexedMap config.viewItem model.items)
        , model.itemToAdd
            |> Maybe.map config.viewItemAdd
            |> Maybe.withDefault
                (model.itemToEdit
                    |> Maybe.map config.viewItemEdit
                    |> Maybe.withDefault config.viewAddItemButton
                )
        ]


type Msg a
    = BeginAddItem a
    | CancelAddItem
    | AddItem a
    | BeginEditItem Int a
    | CancelEditItem
    | ReplaceItem Int a
    | DeleteItem a
    | Noop


update : Msg a -> Model a -> Model a
update msg model =
    case msg of
        BeginAddItem x ->
            { model | itemToAdd = Just x }

        CancelAddItem ->
            { model | itemToAdd = Nothing }

        AddItem x ->
            { model
                | items = model.items ++ [ x ]
                , itemToAdd = Nothing
            }

        BeginEditItem i x ->
            { model | itemToEdit = Just ( i, x ) }

        CancelEditItem ->
            { model | itemToEdit = Nothing }

        ReplaceItem i x ->
            { model
                | items = MyList.replace model.items i x
                , itemToEdit = Nothing
            }

        DeleteItem x ->
            { model | items = List.filter ((/=) x) model.items }

        Noop ->
            model
