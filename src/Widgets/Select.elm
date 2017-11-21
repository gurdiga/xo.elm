module Widgets.Select exposing (view, unlabeledView)

import Html exposing (Html, label, select, option, span, text)
import Html.Attributes exposing (attribute, style, selected)
import Html.Events exposing (onInput)
import UI.Styles as Styles


view : String -> List ( a, String ) -> a -> (a -> msg) -> Html msg
view label valuesWithLabels defaultValue callback =
    -- TODO: make it work
    widget
        { fieldId = "combobox-1"
        , label = label
        , valuesWithLabels = valuesWithLabels
        , defaultValue = defaultValue
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
                }

        this1 =
            select
                [ onInput (callback << valueFromLabel)
                , style (Styles.inheritFont)
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
    }


widget : Model a -> Html msg
widget model =
    container
        [ label model.label
        , listboxContainer
            [ input selectedOption
            , listbox (List.map Tuple.second model.valuesWithLabels)
            ]
        ]


unlabeledWidget : Model a -> Html msg
unlabeledWidget model =
    container
        [ input selectedOption
        , listbox (List.map Tuple.second model.valuesWithLabels)
        ]


container : List (Html msg) -> Html msg
container =
    Html.div
        [ attribute "role" "combobox"
        , attribute "aria-labelledby" "combobox-N-label"
        , attribute "aria-expanded" "true"
        , attribute "aria-haspopup" "listbox"
        , style [ ( "position", "relative" ) ]
        ]


label : String -> Html msg
label s =
    Html.label
        [ attribute "id" "combobox-N-label"
        , attribute "for" "combobox-N"
        ]
        [ Html.text s ]


listboxContainer : List (Html msg) -> Html msg
listboxContainer =
    Html.div
        [ attribute "class" "combobox-listbox-container"
        , style [ ( "display", "inline-block" ), ( "position", "relative" ) ]
        ]


selectedOption : String
selectedOption =
    "1"


input : String -> Html msg
input s =
    Html.input
        [ attribute "id" "combobox-N"
        , attribute "type" "text"
        , attribute "aria-autocomplete" "list"
        , attribute "aria-controls" "combobox-N-listbox"
        , attribute "aria-activedescendant" "combobox-N-selected-option"
        , attribute "value" s
        ]
        []


listbox : List String -> Html msg
listbox valuesWithLabels =
    Html.ul
        [ attribute "role" "listbox"
        , attribute "id" "combobox-N-listbox"
        , style
            [ ( "position", "absolute" )
            , ( "margin", "0" )
            , ( "padding", "0" )
            , ( "list-style-type", "none" )
            , ( "display", "none" )
            ]
        ]
        (List.map listboxOption valuesWithLabels)


listboxOption : String -> Html msg
listboxOption s =
    Html.option optionAttributes [ Html.text s ]


optionAttributes : List (Html.Attribute msg)
optionAttributes =
    [ attribute "role" "option" ]



-- ++ if v == model.defaultValue then
--     [ attribute "aria-selected" "true"
--     , attribute "id" "combobox-N-selected-option"
--     ]
--    else
--     []
