module Widgets.Select3 exposing (Model, initialModel, update, selectedValue, Msg, view, subscriptions)

import Html exposing (Html, label, text, button)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick, onMouseOver, onMouseOut, onFocus, onBlur)
import FNV as HashingUtility
import Keyboard
import UI.Styles as Styles
import Widgets.Select3.Css as Css
import Utils.MyList as MyList
import Utils.MyHtmlEvents exposing (onKeyDown)


type Msg a
    = Open
    | Close
    | OptionSelected a
    | OptionMouseOver a
    | OptionMouseOut
    | KeyDown Keyboard.KeyCode


type Model a
    = Model
        { valuesWithLabels : ValuesWithLabels a
        , selectedValue : a
        , hoveredValue : Maybe a
        , isOpened : Bool
        , id : String
        }


type alias ValuesWithLabels a =
    List ( a, String )


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


view : String -> Model a -> Html (Msg a)
view labelText (Model { valuesWithLabels, selectedValue, hoveredValue, isOpened, id }) =
    let
        this =
            container id
                [ label id labelText
                , listboxContainer
                    [ input id selectedOptionLabel
                    , listbox id isOpened valuesWithLabels selectedValue hoveredValue
                    ]
                ]

        selectedOptionLabel =
            valuesWithLabels
                |> List.filter (\( v, l ) -> v == selectedValue)
                |> List.head
                |> Maybe.map Tuple.second
                |> Maybe.withDefault ""
    in
        this


update : Msg a -> Model a -> Model a
update msg (Model model) =
    case msg of
        Open ->
            Model { model | isOpened = True }

        Close ->
            Model { model | isOpened = False }

        OptionSelected value ->
            Model { model | selectedValue = value }

        OptionMouseOver value ->
            Model { model | hoveredValue = Just value }

        OptionMouseOut ->
            Model { model | hoveredValue = Nothing }

        KeyDown keyCode ->
            case keyCode of
                -- down
                40 ->
                    if model.isOpened then
                        Model
                            { model
                                | selectedValue = nextValue model.selectedValue model.valuesWithLabels
                                , isOpened = True
                            }
                    else
                        Model { model | isOpened = True }

                -- up
                38 ->
                    if model.isOpened then
                        Model
                            { model
                                | selectedValue = previousValue model.selectedValue model.valuesWithLabels
                                , isOpened = True
                            }
                    else
                        Model model

                -- Enter
                13 ->
                    Model { model | isOpened = False }

                -- Esc
                27 ->
                    Model { model | isOpened = False }

                _ ->
                    Model model


nextValue : a -> ValuesWithLabels a -> a
nextValue selectedValue valuesWithLabels =
    valuesWithLabels
        |> MyList.dropUntil (\( v, l ) -> v == selectedValue)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault
            (valuesWithLabels
                |> List.head
                |> Maybe.map Tuple.first
                |> Maybe.withDefault selectedValue
            )


previousValue : a -> ValuesWithLabels a -> a
previousValue selectedValue valuesWithLabels =
    valuesWithLabels
        |> List.reverse
        |> nextValue selectedValue


container : String -> List (Html (Msg a)) -> Html (Msg a)
container id =
    Html.div
        [ attribute "role" "combobox"
        , attribute "aria-labelledby" ("combobox-" ++ id ++ "-label")
        , attribute "aria-expanded" "true"
        , attribute "aria-haspopup" "listbox"
        , style (Css.container ++ Styles.inheritFont)
        ]


listboxContainer : List (Html (Msg a)) -> Html (Msg a)
listboxContainer =
    Html.div
        [ attribute "class" "combobox-listbox-container"
        , style (Css.listboxContainer ++ Styles.inheritFont)
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
        , style (Css.input ++ Styles.inheritFont)
        , onFocus Open
        , onBlur Close
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
                , style (Css.listbox ++ Styles.inheritFont ++ visibilityStyles)
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
                , style (Css.listboxOption ++ optionHoverStyles ++ optionSelectedStyles)
                , onClick (OptionSelected value)
                , onMouseOver (OptionMouseOver value)
                , onMouseOut (OptionMouseOut)
                ]
                [ Html.text label ]

        ariaSelectedState =
            if isSelected then
                attribute "aria-selected" "true"
            else
                attribute "aria-selected" "false"

        optionHoverStyles =
            if isHovered then
                [ ( "background", "black" ) ]
            else
                []

        optionSelectedStyles =
            if isSelected then
                [ ( "background", "blue" ) ]
            else
                []
    in
        this


subscriptions : List (Sub (Msg a))
subscriptions =
    []
