module Widgets.Select3
    exposing
        ( Model
        , -- Msg constructors are exported for tests only.
          Msg(..)
        , hoveredValue
        , initialModel
        , isOpened
        , selectedValue
        , update
        , view
        )

import Char
import FNV as HashingUtility
import Html.Styled exposing (Html, div, li, span, text, ul)
import Html.Styled.Attributes exposing (attribute, classList, css, style)
import Html.Styled.Events exposing (on, onBlur, onClick, onMouseDown, onMouseOut, onMouseOver)
import Json.Decode
import Keyboard
import Utils.MyList as MyList
import Widgets.Select3.Css as Css


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


hoveredValue : Model a -> Maybe a
hoveredValue (Model { hoveredValue }) =
    hoveredValue


isOpened : Model a -> Bool
isOpened (Model { isOpened }) =
    isOpened


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
                isOpened
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
            span [ css [ Css.dropdownSymbol ] ] [ text "▾" ]
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
            Model { model | isOpened = False, hoveredValue = Nothing }

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
    -- TODO: Why doesn’t up/down work as expected? Do I need unit tests here?
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
            Model
                { model
                    | selectedValue =
                        findByLabelFistChar keyCode (Model model)
                            |> Maybe.withDefault model.selectedValue
                }


findByLabelFistChar : Keyboard.KeyCode -> Model a -> Maybe a
findByLabelFistChar keyCode (Model model) =
    let
        this =
            model.valuesWithLabels
                |> List.filter (labelBeginsWith char)
                |> List.head
                |> Maybe.map Tuple.first

        char =
            keyCode
                |> Char.fromCode
                |> Char.toLower

        labelBeginsWith : Char -> ValueWithLabel a -> Bool
        labelBeginsWith char tuple =
            tuple
                |> Tuple.second
                |> String.slice 0 1
                |> String.toList
                |> List.head
                |> Maybe.map (\c -> Char.toLower c == char)
                |> Maybe.withDefault False
    in
    this


nextValue : Maybe a -> ValuesWithLabels a -> Maybe a
nextValue maybeHoveredValue valuesWithLabels =
    case maybeHoveredValue of
        Nothing ->
            valuesWithLabels
                |> List.head
                |> Maybe.map Tuple.first

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


container : String -> Bool -> List (Html (Msg a)) -> Html (Msg a)
container id isOpened =
    div
        [ attribute "role" "combobox"
        , attribute "aria-labelledby" ("combobox-" ++ id ++ "-label")
        , attribute "aria-expanded" (toString isOpened |> String.toLower)
        , attribute "aria-haspopup" "true"
        , css [ Css.container ]
        ]


listboxContainer : List (Html (Msg a)) -> Html (Msg a)
listboxContainer =
    div
        [ attribute "class" "combobox-listbox-container"
        , css [ Css.listboxContainer ]
        ]


label : String -> String -> Html (Msg a)
label id labelText =
    Html.Styled.label
        [ attribute "id" ("combobox-" ++ id ++ "-label")
        , attribute "for" ("combobox-" ++ id)
        , css [ Css.label ]
        ]
        [ text labelText ]


input : String -> String -> Html (Msg a)
input id optionLabel =
    Html.Styled.input
        [ attribute "id" ("combobox-" ++ id)
        , attribute "type" "text"
        , attribute "aria-autocomplete" "list"
        , attribute "aria-controls" ("combobox-" ++ id ++ "-listbox")
        , attribute "aria-activedescendant" ("combobox-" ++ id ++ "-selected-option")
        , attribute "value" optionLabel
        , -- TODO: Maybe remove this because it causes the whole page to scroll when using arrow keys
          attribute "readonly" "readonly"
        , css [ Css.input ]
        , onBlur Close
        , onClick Toggle
        , onKeyDown KeyDown
        ]
        []


listbox : String -> Bool -> ValuesWithLabels a -> a -> Maybe a -> Html (Msg a)
listbox id isOpened valuesWithLabels selectedValue hoveredValue =
    let
        this =
            ul
                [ attribute "role" "listbox"
                , attribute "id" ("combobox-" ++ id ++ "-listbox")
                , css [ Css.listbox ]
                , style [ ( "display", visibilityDisplay ) ]
                ]
                options

        options =
            List.map (tupleToOptionModel >> listboxOption) valuesWithLabels

        tupleToOptionModel ( value, label ) =
            { value = value
            , label = label
            , isSelected = value == selectedValue
            , isHovered = Just value == hoveredValue
            }

        visibilityDisplay =
            if isOpened then
                "block"
            else
                "none"
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
            li
                ([ attribute "role" "option"
                 , attribute "aria-selected" (isSelected |> toString |> String.toLower)
                 , css [ Css.listboxOption ]
                 , onMouseDown (OptionSelected value)
                 , onMouseOver (OptionMouseOver value)
                 , onMouseOut OptionMouseOut
                 ]
                    ++ hoverRelatedAttributes
                )
                [ optionSelectedMarker
                , text label
                ]

        hoverRelatedAttributes =
            [ css hoverCss
            , classList [ ( "test-hover", isHovered ) ]
            ]

        hoverCss =
            if isHovered then
                Css.listboxOptionHover
            else
                []

        optionSelectedMarker =
            span
                [ css [ Css.optionSelectedMarker ] ]
                [ text
                    (if isSelected then
                        "✓"
                     else
                        ""
                    )
                ]
    in
    this


onKeyDown : (Int -> msg) -> Html.Styled.Attribute msg
onKeyDown tagger =
    Html.Styled.Events.on "keydown" (Json.Decode.map tagger Html.Styled.Events.keyCode)
