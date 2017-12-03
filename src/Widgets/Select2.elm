module Widgets.Select2 exposing (view, unlabeledView)

import Html exposing (Html, label, select, option, span, text)
import Html.Attributes exposing (attribute, style, selected)
import Html.Events exposing (onInput)
import UI.Styles as Styles
import Utils.MyList as MyList


view : String -> List ( a, String ) -> a -> (a -> msg) -> Html msg
view label valuesWithLabels defaultValue callback =
    -- TODO: make the listbox open on focus
    --
    -- Should it enclose the state for isOpen?
    --
    -- It kind of feels obnoxious to require the container to hold widget’s
    -- state that is not directly relevant to the container’s needs.
    --
    -- Or is it?
    --
    -- This would also require the widget to expose its model’s type, wouldn’t
    -- it?
    --
    widget
        { fieldId = "combobox-1"
        , label = label
        , valuesWithLabels = valuesWithLabels
        , defaultValue = defaultValue
        , isOpen = True
        }


unlabeledView : List ( a, String ) -> a -> (a -> msg) -> Html msg
unlabeledView valuesWithLabels defaultValue callback =
    let
        this =
            unlabeledWidget
                { fieldId = "combobox-1"
                , label = "Temei"
                , valuesWithLabels = valuesWithLabels
                , defaultValue = defaultValue
                , isOpen = False
                }

        this1 =
            select
                [ onInput (callback << valueFromLabel)
                , style Styles.inheritFont
                ]
                (options valuesWithLabels defaultValue)

        options valuesWithLabels defaultValue =
            List.map optionForTuple valuesWithLabels

        optionForTuple ( value, label ) =
            option [ selected (defaultValue == value) ] [ text label ]

        valueFromLabel label =
            case maybeValueFromLabel label of
                Nothing ->
                    defaultValue

                Just ( value, label ) ->
                    value

        maybeValueFromLabel l =
            List.filter (\( value, label ) -> label == l) valuesWithLabels
                |> List.head
    in
        this


type alias Model a =
    { fieldId : String
    , label : String
    , valuesWithLabels : List ( a, String )
    , defaultValue : a
    , isOpen : Bool
    }


widget : Model a -> Html msg
widget model =
    let
        this =
            container
                [ label model.label
                , listboxContainer
                    [ input selectedOptionLabel
                    , listbox (List.map Tuple.second model.valuesWithLabels) model.isOpen
                    ]
                ]

        selectedOptionLabel =
            case selectedOption of
                Just ( v, label ) ->
                    label

                Nothing ->
                    ""

        selectedOption =
            MyList.find (withValue model.defaultValue) model.valuesWithLabels

        withValue v =
            (\( value, label ) -> value == v)
    in
        this


unlabeledWidget : Model a -> Html msg
unlabeledWidget model =
    container
        [ input selectedOption
        , listbox (List.map Tuple.second model.valuesWithLabels) model.isOpen
        ]


container : List (Html msg) -> Html msg
container =
    let
        this =
            Html.div
                [ attribute "role" "combobox"
                , attribute "aria-labelledby" "combobox-N-label"
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


label : String -> Html msg
label s =
    Html.label
        [ attribute "id" "combobox-N-label"
        , attribute "for" "combobox-N"
        , style [ ( "margin-right", "0.25em" ) ]
        ]
        [ Html.text s ]


listboxContainer : List (Html msg) -> Html msg
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


selectedOption : String
selectedOption =
    "1"


input : String -> Html msg
input s =
    let
        this =
            Html.input
                [ attribute "id" "combobox-N"
                , attribute "type" "text"
                , attribute "aria-autocomplete" "list"
                , attribute "aria-controls" "combobox-N-listbox"
                , attribute "aria-activedescendant" "combobox-N-selected-option"
                , attribute "value" s
                , style styles
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


listbox : List String -> Bool -> Html msg
listbox valuesWithLabels isOpen =
    let
        this =
            Html.ul
                [ attribute "role" "listbox"
                , attribute "id" "combobox-N-listbox"
                , style styles
                ]
                (List.map listboxOption valuesWithLabels)

        styles =
            [ ( "position", "absolute" )
            , ( "margin", "0" )
            , ( "padding", "0" )
            , ( "list-style-type", "none" )
            , ( "display", cssDisplay )
            ]
                ++ Styles.inheritFont

        cssDisplay =
            if isOpen then
                "block"
            else
                "none"
    in
        this


listboxOption : String -> Html msg
listboxOption s =
    Html.option
        [ attribute "role" "option" ]
        [ Html.text s ]



-- ++ if v == model.defaultValue then
--     [ attribute "aria-selected" "true"
--     , attribute "id" "combobox-N-selected-option"
--     ]
--    else
--     []
