module Select3Test exposing (..)

import Expect
import Html
import Html.Attributes exposing (attribute)
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
                renderWithModel initialModel
                    |> Query.has
                        [ Selector.attribute <| attribute "role" "combobox"
                        , Selector.attribute <| attribute "aria-expanded" "false"
                        , Selector.attribute <| attribute "aria-haspopup" "true"
                        ]
        , test "label" <|
            \_ ->
                renderWithModel initialModel
                    |> Query.find [ Selector.tag "label" ]
                    |> Query.has [ Selector.text "A dropdown:" ]
        , test "input" <|
            \_ ->
                renderWithModel initialModel
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
                renderWithModel initialModel
                    |> Query.find [ Selector.tag "input" ]
                    |> Event.simulate Event.click
                    |> Event.expect Select3.Toggle
        , describe "Toggle message"
            (let
                updatedModel =
                    Select3.update Select3.Toggle initialModel

                rendered =
                    renderWithModel updatedModel
             in
             [ test "sets model’s isOpened to True (because it’s initially False)" <|
                \_ ->
                    Select3.isOpened updatedModel
                        |> Expect.equal True
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
                    renderWithModel initialModel
                        |> Query.find [ Selector.tag "input" ]
                        |> Event.simulate (keyDownEvent 40)
                        |> Event.expect (Select3.KeyDown 40)
            , test "opens the dropdown, initially" <|
                \_ ->
                    Select3.update (Select3.KeyDown 40) initialModel
                        |> Select3.isOpened
                        |> Expect.equal True
            , describe "when it’s opened, and there was initially no hovered option"
                (let
                    modelOpened =
                        Select3.update Select3.Open initialModel
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
                 , test "the hover state is cleared when closed" <|
                    \_ ->
                        initialModel
                            |> Select3.update Select3.Open
                            |> Select3.update (Select3.KeyDown 40)
                            |> Select3.update Select3.Close
                            |> Select3.hoveredValue
                            |> Expect.equal Nothing
                 ]
                )
            ]
        , describe "arrow up"
            (let
                modelOpened =
                    Select3.update Select3.Open initialModel
             in
             [ test "sets the first option as the hovered one" <|
                \_ ->
                    modelOpened
                        |> -- hover the first option
                           Select3.update (Select3.KeyDown 40)
                        |> -- hover the second option
                           Select3.update (Select3.KeyDown 40)
                        |> -- back to the first option
                           Select3.update (Select3.KeyDown 38)
                        |> Select3.hoveredValue
                        |> Expect.equal (Just 1)
             ]
            )
        , describe "pressing Enter"
            (let
                modelSelected =
                    Select3.update Select3.Open initialModel
                        |> -- hover the first option
                           Select3.update (Select3.KeyDown 40)
                        |> -- hover the second option
                           Select3.update (Select3.KeyDown 40)
                        |> -- Enter to select the second option
                           Select3.update (Select3.KeyDown 13)
             in
             [ test "marks the hovered option as selected" <|
                \_ ->
                    Select3.selectedValue modelSelected |> Expect.equal 2
             , test "marks the select ar closed" <|
                \_ ->
                    Select3.isOpened modelSelected |> Expect.equal False
             , test "renders the listbox hidden" <|
                \_ ->
                    renderWithModel modelSelected
                        |> Query.find [ Selector.attribute <| attribute "role" "listbox" ]
                        |> Query.has [ Selector.style [ ( "display", "none" ) ] ]
             ]
            )
        , describe "pressing Esc"
            (let
                modelClosed =
                    Select3.update Select3.Open initialModel
                        |> Select3.update (Select3.KeyDown 27)
             in
             [ test "marks the select as closed" <|
                \_ ->
                    modelClosed
                        |> Select3.isOpened
                        |> Expect.equal False
             , test "renders the listbox hidden" <|
                \_ ->
                    renderWithModel modelClosed
                        |> Query.find [ Selector.attribute <| attribute "role" "listbox" ]
                        |> Query.has [ Selector.style [ ( "display", "none" ) ] ]
             ]
            )
        , describe "pressing a letter"
            (let
                modelOpened =
                    Select3.update Select3.Open initialModel
             in
             [ test "selects the option that begins wit that letter" <|
                \_ ->
                    modelOpened
                        |> -- press “t”
                           Select3.update (Select3.KeyDown 116)
                        |> Select3.selectedValue
                        |> Expect.equal 2
             , test "selects the option that begins wit that letter (case insensitively)" <|
                \_ ->
                    modelOpened
                        |> -- press “T”
                           Select3.update (Select3.KeyDown 84)
                        |> Select3.selectedValue
                        |> Expect.equal 2
             , test "disregards any other letter" <|
                \_ ->
                    modelOpened
                        |> -- press “A”
                           Select3.update (Select3.KeyDown 65)
                        |> Select3.selectedValue
                        |> Expect.equal (Select3.selectedValue initialModel)
             ]
            )
        ]


renderWithModel : Select3.Model a -> Query.Single (Select3.Msg a)
renderWithModel model =
    Select3.view "A dropdown:" model
        |> Query.fromHtml


initialModel : Select3.Model number
initialModel =
    Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ]
