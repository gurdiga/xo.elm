module Widgets.Select3 exposing (Model, init, view)

import Html exposing (Html, label, text)
import Html.Attributes exposing (attribute, style)
import UI.Styles as Styles


type alias Model a =
    { valuesWithLabels : ValuesWithLabels a
    , defaultValue : a
    , isOpened : Bool
    }


type alias ValuesWithLabels a =
    List ( a, String )


init : a -> ValuesWithLabels a -> Model a
init defaultValue valuesWithLabels =
    { valuesWithLabels = valuesWithLabels
    , defaultValue = defaultValue
    , isOpened = False
    }


view : String -> Model a -> (Model a -> msg) -> Html msg
view labelText model callback =
    let
        this =
            container
                [ label labelText
                , listboxContainer
                    [ input selectedOptionLabel

                    -- TODO: add the list-box
                    ]
                ]

        selectedOptionLabel =
            case findValueWithLabelForValue model.defaultValue of
                Just ( v, label ) ->
                    label

                Nothing ->
                    ""

        findValueWithLabelForValue value =
            model.valuesWithLabels
                |> List.filter (\( v, l ) -> v == value)
                |> List.head
    in
        this


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


label : String -> Html msg
label s =
    Html.label
        [ attribute "id" "combobox-N-label"
        , attribute "for" "combobox-N"
        , style [ ( "margin-right", "0.25em" ) ]
        ]
        [ Html.text s ]


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
