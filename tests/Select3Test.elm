module Select3Test exposing (..)

import Html
import Html.Attributes exposing (attribute, title)
import Html.Styled
import Test exposing (describe, test)
import Test.Html.Query as Query
import Test.Html.Selector as Selector
import Widgets.Select3 as Select3


tests =
    describe "attributes"
        [ test "the welcome <h1> says hello!" <|
            \() ->
                Select3.view "A dropdown:" (Select3.initialModel 1 [ ( 1, "one" ), ( 2, "two" ) ])
                    |> Html.Styled.toUnstyled
                    |> Query.fromHtml
                    |> Query.has
                        [ Selector.attribute <| attribute "role" "combobox"
                        , Selector.attribute <| attribute "aria-expanded" "false"
                        ]
        ]
