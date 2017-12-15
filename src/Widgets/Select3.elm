module Widgets.Select3 exposing (Model, initialModel, update, selectedValue, Msg, view)

import Html exposing (Html, label, text, button)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick, onMouseOver, onMouseOut, onFocus, onBlur)
import UI.Styles as Styles
import Widgets.Select3.Css as Css
import FNV as HashingUtility


-- TODO: Ceck elm-css. Why? How would it be better besides less cluttered HTML
-- in the browser console?


type Msg a
    = Open
    | Close
    | OptionSelected a
    | OptionMouseOver a
    | OptionMouseOut


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
                , style (Css.listboxOption ++ optionHoverStyles ++ optionSelectedStyles)
                , onClick (OptionSelected value)
                , onMouseOver (OptionMouseOver value)
                , onMouseOut (OptionMouseOut)
                ]
                [ Html.text label ]

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
