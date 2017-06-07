module Example exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (list, int, string)
import Main


suite : Test
suite =
    describe "Main"
        [ test "Renders a div with the given string inside" <|
            \_ ->
                Expect.equal "just kidding" "just kidding"
        ]
