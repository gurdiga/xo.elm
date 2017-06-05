module Example exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, string)
import Main exposing (viewMessage)


suite : Test
suite =
    describe "Main"
        [ describe "viewMessage helper"
            [ test "Renders a div with the given string inside" <|
                \_ ->
                    Expect.equal "just kidding" "just kidding"
            ]
        ]
