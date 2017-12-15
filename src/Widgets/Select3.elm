module Widgets.Select3 exposing (Model, initialModel, update, selectedValue, Msg, view)

import Html exposing (Html, label, text, button)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick, onMouseOver, onMouseOut, onFocus, onBlur)
import UI.Styles as Styles
import FNV as HashingUtility


-- TODO: extract Widget.Select3.Css


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
    let
        this =
            Html.div
                [ attribute "role" "combobox"
                , attribute "aria-labelledby" ("combobox-" ++ id ++ "-label")
                , attribute "aria-expanded" "true"
                , attribute "aria-haspopup" "listbox"
                , style styles
                ]

        styles =
            [ ( "position", "relative" )
            , ( "display", "flex" )
            , ( "width", "100%" )
            ]
                ++ Styles.inheritFont
    in
        this


listboxContainer : List (Html (Msg a)) -> Html (Msg a)
listboxContainer =
    let
        this =
            Html.div
                [ attribute "class" "combobox-listbox-container"
                , style styles
                ]

        styles =
            [ ( "display", "inline-block" )
            , ( "position", "relative" )
            , ( "flex-grow", "1" )
            ]
                ++ Styles.inheritFont
    in
        this


label : String -> String -> Html (Msg a)
label id labelText =
    Html.label
        [ attribute "id" ("combobox-" ++ id ++ "-label")
        , attribute "for" ("combobox-" ++ id)
        , style [ ( "margin-right", "0.25em" ) ]
        ]
        [ Html.text labelText ]


input : String -> String -> Html (Msg a)
input id label =
    let
        this =
            Html.input
                [ attribute "id" ("combobox-" ++ id)
                , attribute "type" "text"
                , attribute "aria-autocomplete" "list"
                , attribute "aria-controls" ("combobox-" ++ id ++ "-listbox")
                , attribute "aria-activedescendant" ("combobox-" ++ id ++ "-selected-option")
                , attribute "value" label
                , style styles
                , onFocus Open
                , onBlur Close
                ]
                []

        styles =
            ([ ( "border-style", "solid" )
             , ( "border-width", "1px" )
             , ( "padding", "0 0.25em" )
             , ( "margin-top", "-1px" )
             , ( "width", "100%" )
             , ( "box-sizing", "border-box" )
             ]
                ++ Styles.inheritFont
            )
    in
        this


listbox : String -> Bool -> ValuesWithLabels a -> a -> Maybe a -> Html (Msg a)
listbox id isOpened valuesWithLabels selectedValue hoveredValue =
    let
        this =
            Html.ul
                [ attribute "role" "listbox"
                , attribute "id" ("combobox-" ++ id ++ "-listbox")
                , style styles
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

        styles =
            [ ( "position", "absolute" )
            , ( "margin", "0" )
            , ( "padding", "0" )
            , ( "list-style-type", "none" )
            ]
                ++ Styles.inheritFont
                ++ visibilityStyles

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
                , style (styles ++ optionHoverStyles ++ optionSelectedStyles)
                , onClick (OptionSelected value)
                , onMouseOver (OptionMouseOver value)
                , onMouseOut (OptionMouseOut)
                ]
                [ Html.text label ]

        styles =
            [ ( "cursor", "pointer" ) ]

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
