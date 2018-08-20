module Widgets.EditableList exposing (Config, Model, Msg(..), State, config, state, update, view)

import Html.Styled exposing (Html, button, fieldset, legend, li, p, text, ul)
import Utils.MyList as MyList


type alias Model a =
    List a


type Config a msg
    = Config (ConfigData a msg)


type alias ConfigData a msg =
    { viewNoItems : Html msg
    , viewItem : ViewItem a msg
    , viewItemAdd : ViewItemAdd a msg
    , viewItemEdit : ViewItemEdit a msg
    , viewAddItemButton : Html msg
    }


type alias ViewItem a msg =
    Int -> a -> Html msg


type alias ViewItemAdd a msg =
    a -> Html msg


type alias ViewItemEdit a msg =
    ( Int, a ) -> Html msg


config : ConfigData a msg -> Config a msg
config =
    Config


type State a
    = State (StateData a)


type alias StateData a =
    { itemToAdd : ItemToAdd a
    , itemToEdit : ItemToEdit a
    }


type alias ItemToAdd a =
    Maybe a


type alias ItemToEdit a =
    Maybe ( Int, a )


state : StateData a -> State a
state =
    State


view : Config a msg -> State a -> Model a -> Html msg
view (Config config) (State state) items =
    fieldset []
        [ legend [] [ text "EditableList" ]
        , if List.isEmpty items then
            p [] [ config.viewNoItems ]
          else
            ul [] (List.indexedMap config.viewItem items)
        , state.itemToAdd
            |> Maybe.map config.viewItemAdd
            |> Maybe.withDefault
                (state.itemToEdit
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


update : Msg a -> State a -> Model a -> ( State a, Model a )
update msg (State state) items =
    case msg of
        BeginAddItem x ->
            ( State { state | itemToAdd = Just x }, items )

        CancelAddItem ->
            ( State { state | itemToAdd = Nothing }, items )

        AddItem x ->
            ( State { state | itemToAdd = Nothing }, items ++ [ x ] )

        BeginEditItem i x ->
            ( State { state | itemToEdit = Just ( i, x ) }, items )

        CancelEditItem ->
            ( State { state | itemToEdit = Nothing }, items )

        ReplaceItem i x ->
            ( State { state | itemToEdit = Nothing }, MyList.replace items i x )

        DeleteItem x ->
            ( State state, List.filter ((/=) x) items )

        Noop ->
            ( State state, items )
