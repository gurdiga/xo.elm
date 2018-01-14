module Select3Test exposing (..)

import Html.Attributes exposing (attribute)
import Html.Styled
import Test exposing (Test, describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (all, tag)
import Widgets.Select3 as Select3


tests : Test
tests =
    describe "Select3"
        [ describe "markup structure"
            [ test "wrapping container attributes" <|
                \_ ->
                    renderWithModel model
                        |> Query.has
                            [ Selector.attribute <| attribute "role" "combobox"
                            , Selector.attribute <| attribute "aria-expanded" "false"
                            , Selector.attribute <| attribute "aria-haspopup" "true"

                            -- TODO: How to get the value of the DOM attribute
                            -- value and do assertions on its string value and
                            -- also use that value in the other related tests?
                            ]
            , test "label" <|
                \_ ->
                    renderWithModel model
                        |> Query.find [ Selector.tag "label" ]
                        |> Query.has [ Selector.text "A dropdown:" ]
            ]
        , describe "when clicking the field"
            [ test "emits a Toggle message" <|
                \_ ->
                    renderWithModel (Select3.update Select3.Toggle model)
                        |> Query.find [ Selector.tag "input" ]
                        |> Event.simulate Event.click
                        |> Event.expect Select3.Toggle
            , describe "Toggle message"
                (let
                    rendered =
                        renderWithModel (Select3.update Select3.Toggle model)
                 in
                 [ test "sets aria-expanded to true" <|
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
        ]


renderWithModel : Select3.Model a -> Query.Single (Select3.Msg a)
renderWithModel model =
    Select3.view "A dropdown:" model
        |> Html.Styled.toUnstyled
        |> Query.fromHtml


model : Select3.Model number
model =
    Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ]
