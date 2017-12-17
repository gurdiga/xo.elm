module Widgets.Select3 exposing (Model, initialModel, update, selectedValue, Msg, view, subscriptions)

import Html exposing (Html, label, text, button)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onMouseDown, onClick, onMouseOver, onMouseOut, onBlur)
import FNV as HashingUtility
import Keyboard
import UI.Styles as Styles
import Widgets.Select3.Css as Css
import Utils.MyList as MyList
import Utils.MyHtmlEvents exposing (onKeyDown)


type Model a
    = Model
        { valuesWithLabels : ValuesWithLabels a
        , selectedValue : a
        , hoveredValue : Maybe a
        , isOpened : Bool
        , id : String
        }


type alias ValuesWithLabels a =
    List (ValueWithLabel a)


type alias ValueWithLabel a =
    ( a, String )


initialModel : a -> ValuesWithLabels a -> Model a
initialModel selectedValue valuesWithLabels =
    Model
        { valuesWithLabels = valuesWithLabels
        , selectedValue = selectedValue
        , hoveredValue = Nothing
        , isOpened = False
        , id = valuesWithLabels |> toString |> HashingUtility.hashString |> toString
        }


selectedValue : Model a -> a
selectedValue (Model { selectedValue }) =
    selectedValue


type Msg a
    = Open
    | Close
    | Toggle
    | OptionSelected a
    | OptionMouseOver a
    | OptionMouseOut
    | KeyDown Keyboard.KeyCode


view : String -> Model a -> Html (Msg a)
view labelText (Model { valuesWithLabels, selectedValue, hoveredValue, isOpened, id }) =
    let
        this =
            container id
                [ label id labelText
                , listboxContainer
                    [ input id selectedOptionLabel
                    , dropdownSymbol
                    , listbox id isOpened valuesWithLabels selectedValue hoveredValue
                    ]
                ]

        selectedOptionLabel =
            valuesWithLabels
                |> List.filter (valueIs (Just selectedValue))
                |> List.head
                |> Maybe.map Tuple.second
                |> Maybe.withDefault ""

        dropdownSymbol =
            Html.span [ style Css.dropdownSymbol ] [ text "▾" ]
    in
        this


valueIs : Maybe a -> ValueWithLabel a -> Bool
valueIs maybeV ( vx, _ ) =
    case maybeV of
        Nothing ->
            False

        Just v ->
            vx == v


update : Msg a -> Model a -> Model a
update msg (Model model) =
    case msg of
        Open ->
            Model { model | isOpened = True }

        Close ->
            Model { model | isOpened = False }

        Toggle ->
            Model { model | isOpened = not model.isOpened }

        OptionSelected value ->
            Model { model | selectedValue = value }

        OptionMouseOver value ->
            Model { model | hoveredValue = Just value }

        OptionMouseOut ->
            Model { model | hoveredValue = Nothing }

        KeyDown keyCode ->
            handleKeyDowns keyCode (Model model)


handleKeyDowns : Keyboard.KeyCode -> Model a -> Model a
handleKeyDowns keyCode (Model model) =
    case keyCode of
        -- down
        40 ->
            if model.isOpened then
                Model
                    { model
                        | hoveredValue = nextValue model.hoveredValue model.valuesWithLabels
                        , isOpened = True
                    }
            else
                Model { model | isOpened = True }

        -- up
        38 ->
            if model.isOpened then
                Model
                    { model
                        | hoveredValue = previousValue model.hoveredValue model.valuesWithLabels
                        , isOpened = True
                    }
            else
                Model model

        -- Enter
        13 ->
            case model.hoveredValue of
                Just v ->
                    Model { model | selectedValue = v, isOpened = False }

                Nothing ->
                    Model model

        -- Esc
        27 ->
            Model { model | isOpened = False }

        _ ->
            Model model


nextValue : Maybe a -> ValuesWithLabels a -> Maybe a
nextValue maybeHoveredValue valuesWithLabels =
    case maybeHoveredValue of
        Nothing ->
            (valuesWithLabels
                |> List.head
                |> Maybe.map Tuple.first
            )

        Just v ->
            valuesWithLabels
                |> MyList.dropUntil (valueIs (Just v))
                |> List.head
                |> Maybe.map Tuple.first


previousValue : Maybe a -> ValuesWithLabels a -> Maybe a
previousValue maybeHoveredValue valuesWithLabels =
    valuesWithLabels
        |> List.reverse
        |> nextValue maybeHoveredValue


container : String -> List (Html (Msg a)) -> Html (Msg a)
container id =
    Html.div
        [ attribute "role" "combobox"
        , attribute "aria-labelledby" ("combobox-" ++ id ++ "-label")
        , attribute "aria-expanded" "true"
        , attribute "aria-haspopup" "listbox"
        , style (Styles.inheritFont ++ Css.container)
        ]


listboxContainer : List (Html (Msg a)) -> Html (Msg a)
listboxContainer =
    Html.div
        [ attribute "class" "combobox-listbox-container"
        , style (Styles.inheritFont ++ Css.listboxContainer)
        ]


label : String -> String -> Html (Msg a)
label id labelText =
    Html.label
        [ attribute "id" ("combobox-" ++ id ++ "-label")
        , attribute "for" ("combobox-" ++ id)
        , style Css.label
        ]
        [ Html.text labelText ]


input : String -> String -> Html (Msg a)
input id label =
    Html.input
        [ attribute "id" ("combobox-" ++ id)
        , attribute "type" "text"
        , attribute "aria-autocomplete" "list"
        , attribute "aria-controls" ("combobox-" ++ id ++ "-listbox")
        , attribute "aria-activedescendant" ("combobox-" ++ id ++ "-selected-option")
        , attribute "value" label
        , attribute "readonly" "readonly"
        , style (Styles.inheritFont ++ Css.input)
        , onBlur Close
        , onClick Toggle
        , onKeyDown KeyDown
        ]
        []


listbox : String -> Bool -> ValuesWithLabels a -> a -> Maybe a -> Html (Msg a)
listbox id isOpened valuesWithLabels selectedValue hoveredValue =
    let
        this =
            Html.ul
                [ attribute "role" "listbox"
                , attribute "id" ("combobox-" ++ id ++ "-listbox")
                , style (Styles.inheritFont ++ Css.listbox ++ visibilityStyles)
                ]
                options

        options =
            (List.map (tupleToOptionModel >> listboxOption) valuesWithLabels)

        tupleToOptionModel ( value, label ) =
            { value = value
            , label = label
            , isSelected = value == selectedValue
            , isHovered = Just value == hoveredValue
            }

        visibilityStyles =
            if isOpened then
                [ ( "display", "block" ) ]
            else
                [ ( "display", "none" ) ]
    in
        this


type alias OptionModel a =
    { value : a
    , label : String
    , isSelected : Bool
    , isHovered : Bool
    }


listboxOption : OptionModel a -> Html (Msg a)
listboxOption { value, label, isSelected, isHovered } =
    let
        this =
            Html.li
                [ attribute "role" "option"
                , ariaSelectedState
                , style (Css.listboxOption ++ optionHoverStyles)
                , onMouseDown (OptionSelected value)
                , onMouseOver (OptionMouseOver value)
                , onMouseOut (OptionMouseOut)
                ]
                [ optionSelectedMarker
                , Html.text label
                ]

        ariaSelectedState =
            if isSelected then
                attribute "aria-selected" "true"
            else
                attribute "aria-selected" "false"

        optionHoverStyles =
            if isHovered then
                Css.optionHoverStyles
            else
                []

        optionSelectedMarker =
            Html.span
                [ style Css.optionSelectedMarker ]
                [ text
                    (if isSelected then
                        "✓"
                     else
                        ""
                    )
                ]
    in
        this


subscriptions : List (Sub (Msg a))
subscriptions =
    []
