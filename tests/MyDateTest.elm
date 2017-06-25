module MyDateTest exposing (..)

import Test exposing (..)
import Expect
import MyDate exposing (MyDate)
import Date exposing (Date)


suite : Test
suite =
    describe "MyDate"
        [ describe "parse"
            [ test "handles invalid strings" <|
                \_ ->
                    Expect.equal (MyDate.parse "magic") (Err "Data trebuie să aibă formatul DD.LL.AAAA")
            , test "handles valid strings" <|
                \_ ->
                    Expect.equal (MyDate.parse "24.07.2007") (Date.fromString "2007-07-24")
            ]
        , describe "format"
            [ test "returns a string of representation of the given date" <|
                \_ ->
                    Expect.equal (MyDate.format (Date.fromString "2007-07-24")) "24.07.2007"
            , test "returns an empty string when the date is not valid" <|
                \_ ->
                    Expect.equal (MyDate.format (Date.fromString "magic")) ""
            ]
        ]
