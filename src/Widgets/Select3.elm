module Widgets.Select3 exposing (Model, initialModel, update, selectedValueFromMsg, Msg, view)

import Html exposing (Html, label, text, button)
import Html.Attributes exposing (attribute, style)
import Html.Events exposing (onClick)
import UI.Styles as Styles


-- import Utils.MyHtmlEvents exposing (onMouseOver, onMouseOut)


view : String -> Model a -> Html (Msg a)
view labelText (Model model) =
    let
        this =
            container
                [ label labelText
                , button [ onClick (Select (Model model)) ] [ text "OK" ]
                , listboxContainer
                    [ input selectedOptionLabel

                    -- TODO: add the listbox
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


type Msg a
    = Select (Model a)


update : Msg a -> Model a -> Model a
update msg (Model model) =
    case msg of
        Select model ->
            Debug.log "update Select" model


type Model a
    = Model
        { valuesWithLabels : ValuesWithLabels a
        , selectedValue : a
        , hoveredValue : Maybe a
        , isOpened : Bool
        }


type alias ValuesWithLabels a =
    List ( a, String )


type alias Callback a msg =
    Model a -> msg


initialModel : a -> ValuesWithLabels a -> Model a
initialModel selectedValue valuesWithLabels =
    Model
        { valuesWithLabels = valuesWithLabels
        , selectedValue = selectedValue
        , hoveredValue = Nothing
        , isOpened = False
        }


selectedValueFromMsg : Msg a -> a
selectedValueFromMsg msg =
    case msg of
        Select (Model model) ->
            model.selectedValue



-- view1 : String -> Model a -> (Model a -> Msg a) -> Html (Msg a)
-- view1 labelText (Model model) callback =
--     let
--         this =
--             container
--                 [ label labelText
--                 , listboxContainer
--                     [ input selectedOptionLabel
--                     , listbox (Model model) callback
--                     ]
--                 ]
--         selectedOptionLabel =
--             case findValueWithLabelForValue model.selectedValue of
--                 Just ( v, label ) ->
--                     label
--                 Nothing ->
--                     ""
--         findValueWithLabelForValue value =
--             model.valuesWithLabels
--                 |> List.filter (\( v, l ) -> v == value)
--                 |> List.head
--     in
--         this


container : List (Html (Msg a)) -> Html (Msg a)
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


label : String -> Html (Msg a)
label s =
    Html.label
        [ attribute "id" "combobox-N-label"
        , attribute "for" "combobox-N"
        , style [ ( "margin-right", "0.25em" ) ]
        ]
        [ Html.text s ]


input : String -> Html (Msg a)
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



-- listbox : Model a -> (Model a -> Msg a) -> Html (Msg a)
-- listbox (Model model) callback =
--     let
--         this =
--             Html.ul
--                 [ attribute "role" "listbox"
--                 , attribute "id" "combobox-N-listbox"
--                 , style styles
--                 ]
--                 (List.map renderOption model.valuesWithLabels)
--         renderOption ( value, label ) =
--             listboxOption
--                 { value = value
--                 , label = label
--                 , isSelected = value == model.selectedValue
--                 , isHovered = Just value == model.hoveredValue
--                 , onSelect = (\v -> callback (Model { model | selectedValue = v }))
--                 , onHover = (\v -> callback (Model { model | hoveredValue = v }))
--                 }
--         styles =
--             [ ( "position", "absolute" )
--             , ( "margin", "0" )
--             , ( "padding", "0" )
--             , ( "list-style-type", "none" )
--             , ( "display", "block" )
--             ]
--                 ++ Styles.inheritFont
--     in
--         this
-- type alias OptionInput a msg =
--     { value : a
--     , label : String
--     , isSelected : Bool
--     , isHovered : Bool
--     , onSelect : a -> msg
--     , onHover : Maybe a -> msg
--     }
-- listboxOption : OptionInput a msg -> Html msg
-- listboxOption { value, label, isSelected, isHovered, onSelect, onHover } =
--     let
--         this =
--             Html.li
--                 [ attribute "role" "option"
--                 , style (styles ++ optionHoverStyles ++ optionSelectedStyles)
--                 , onClick (\_ -> onSelect value)
--                 , onMouseOver (\_ -> onHover (Just value))
--                 , onMouseOut (\_ -> onHover Nothing)
--                 ]
--                 [ Html.text label ]
--         styles =
--             [ ( "cursor", "pointer" ) ]
--         optionHoverStyles =
--             if isHovered then
--                 [ ( "background", "black" ) ]
--             else
--                 []
--         optionSelectedStyles =
--             if isSelected then
--                 [ ( "background", "blue" ) ]
--             else
--                 []
--     in
--         this
