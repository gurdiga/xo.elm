module Select3Test exposing (..)

import Html
import Html.Attributes exposing (attribute)
import Html.Styled
import Test exposing (describe, test)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector as Selector exposing (all, tag)
import Widgets.Select3 as Select3


tests =
    describe "attributes"
        [ test "when opened" <|
            \_ ->
                Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ]
                    |> Select3.triggerOpen
                    |> render
                    |> Query.has
                        [ Selector.attribute <| attribute "aria-expanded" "true"
                        ]
        , test "wrapping container attributes" <|
            \() ->
                Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ]
                    |> render
                    |> Query.has
                        [ Selector.attribute <| attribute "role" "combobox"
                        , Selector.attribute <| attribute "aria-expanded" "false"
                        ]
        ]


render model =
    Select3.view "A dropdown:" model
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
