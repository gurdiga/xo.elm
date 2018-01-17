module Select3Test exposing (..)

import Expect
import Html.Attributes exposing (attribute)
import Html.Styled
import Json.Encode as Encode exposing (Value)
import Test exposing (Test, describe, test, todo)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (all, tag)
import Widgets.Select3 as Select3


markupStructure : Test
markupStructure =
    describe "markup structure"
        [ test "wrapping container attributes" <|
            \_ ->
                renderWithModel model
                    |> Query.has
                        [ Selector.attribute <| attribute "role" "combobox"
                        , Selector.attribute <| attribute "aria-expanded" "false"
                        , Selector.attribute <| attribute "aria-haspopup" "true"
                        ]
        , test "label" <|
            \_ ->
                renderWithModel model
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has [ Selector.text "A dropdown:" ]
        , test "input" <|
            \_ ->
                renderWithModel model
                    |> Query.find [ Selector.tag "input" ]
                    |> Query.has
                        [ Selector.attribute <| attribute "aria-autocomplete" "list"
                        , Selector.attribute <| attribute "value" "one"
                        , Selector.attribute <| attribute "readonly" "readonly"
                        ]
        ]


clickingTheField : Test
clickingTheField =
    describe "when clicking the field"
        [ test "emits a Toggle message" <|
            \_ ->
                renderWithModel model
                    |> Query.find [ Selector.tag "input" ]
                    |> Event.simulate Event.click
                    |> Event.expect Select3.Toggle
        , describe "Toggle message"
            (let
                updatedModel =
                    Select3.update Select3.Toggle model

                rendered =
                    renderWithModel updatedModel
             in
             [ test "sets model’s isOpened to True (because it’s initially False)" <|
                \_ ->
                    Expect.equal (Select3.isOpened updatedModel) True
             , test "sets aria-expanded to true" <|
                \_ ->
                    rendered
                        |> Query.has [ Selector.attribute <| attribute "aria-expanded" "true" ]
             , test "makes the listbox visible" <|
                \_ ->
                    rendered
                        |> Query.find [ Selector.attribute <| attribute "role" "listbox" ]
                        |> Query.has [ Selector.style [ ( "display", "block" ) ] ]
             ]
            )
        ]


keyboardSupport : Test
keyboardSupport =
    let
        keyDownEvent keyCode =
            Encode.object [ ( "keyCode", Encode.int keyCode ) ]
                |> Event.custom "keydown"
    in
    describe "Keyboard interaction"
        [ describe "down arrow"
            [ test "emits a KeyDown message with the appropriate key code" <|
                \_ ->
                    renderWithModel model
                        |> Query.find [ Selector.tag "input" ]
                        |> Event.simulate (keyDownEvent 40)
                        |> Event.expect (Select3.KeyDown 40)
            , test "opens the dropdown, initially" <|
                \_ ->
                    Select3.update (Select3.KeyDown 40) model
                        |> Select3.isOpened
                        |> Expect.equal True
            , describe "when it’s opened, and there was initially no hovered option"
                (let
                    modelOpened =
                        Select3.update Select3.Open model
                 in
                 [ test "sets the first option as the hovered one" <|
                    \_ ->
                        modelOpened
                            |> Select3.update (Select3.KeyDown 40)
                            |> Select3.hoveredValue
                            |> Expect.equal (Just 1)
                 , test "renders the hovered option as such" <|
                    let
                        modelHovered =
                            modelOpened
                                |> Select3.update (Select3.KeyDown 40)
                    in
                    \_ ->
                        renderWithModel modelHovered
                            |> Query.findAll [ Selector.tag "li", Selector.classes [ "test-hover" ] ]
                            |> Expect.all
                                [ Query.count (Expect.equal 1)
                                , Query.first >> Query.has [ Selector.text "one" ]
                                ]
                 ]
                )
            ]
        ]


renderWithModel : Select3.Model a -> Query.Single (Select3.Msg a)
renderWithModel model =
    Select3.view "A dropdown:" model
        |> Html.Styled.toUnstyled
        |> Query.fromHtml


model : Select3.Model number
model =
    Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ]
