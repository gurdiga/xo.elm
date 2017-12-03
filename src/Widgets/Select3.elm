module Widgets.Select3 exposing (Model, init, view)

import Html exposing (Html, label, text)
import Html.Attributes exposing (attribute, style)
import UI.Styles as Styles
import Utils.MyHtmlEvents exposing (onClick, onMouseOver, onMouseOut)


type alias Model a =
    { valuesWithLabels : ValuesWithLabels a
    , selectedValue : a
    , hoveredValue : Maybe a
    , isOpened : Bool
    }


type alias ValuesWithLabels a =
    List ( a, String )


init : a -> ValuesWithLabels a -> Model a
init selectedValue valuesWithLabels =
    { valuesWithLabels = valuesWithLabels
    , selectedValue = selectedValue
    , hoveredValue = Nothing
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
                    , listbox
                        { valuesWithLabels = model.valuesWithLabels
                        , hoveredValue = model.hoveredValue
                        , selectedValue = model.selectedValue
                        , onSelect = (\v -> callback { model | selectedValue = v })
                        , onHover = (\v -> callback { model | hoveredValue = v })
                        }
                    ]
                ]

        selectedOptionLabel =
            case findValueWithLabelForValue model.selectedValue of
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


type alias ListboxInput a msg =
    { valuesWithLabels : List ( a, String )
    , hoveredValue : Maybe a
    , selectedValue : a
    , onSelect : a -> msg
    , onHover : Maybe a -> msg
    }


listbox : ListboxInput a msg -> Html msg
listbox { valuesWithLabels, hoveredValue, selectedValue, onSelect, onHover } =
    let
        this =
            Html.ul
                [ attribute "role" "listbox"
                , attribute "id" "combobox-N-listbox"
                , style styles
                ]
                (List.map listboxOption valuesWithLabels)

        listboxOption ( value, label ) =
            Html.option
                [ attribute "role" "option"
                , style ((hoverStyles value) ++ (selectedStyles value))
                , onClick (\_ -> onSelect value)
                , onMouseOver (\_ -> onHover (Just value))
                , onMouseOut (\_ -> onHover Nothing)
                ]
                [ Html.text label ]

        hoverStyles value =
            case hoveredValue of
                Just v ->
                    if v == value then
                        [ ( "background", "black" ) ]
                    else
                        []

                Nothing ->
                    []

        selectedStyles value =
            if selectedValue == value then
                [ ( "background", "blue" ) ]
            else
                []

        styles =
            [ ( "position", "absolute" )
            , ( "margin", "0" )
            , ( "padding", "0" )
            , ( "list-style-type", "none" )
            , ( "display", "block" )
            ]
                ++ Styles.inheritFont
    in
        this
