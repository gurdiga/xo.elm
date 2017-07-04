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
                    Expect.equal (MyDate.parse "magic").validationMessage "Data trebuie sa aiba formatul DD.LL.AAAA"
            , test "handles clearly invalid date days" <|
                \_ ->
                    Expect.equal (MyDate.parse "42.07.2007").validationMessage "Ziua datei este incorecta: 42"
            , test "handles subtly invalid date days" <|
                \_ ->
                    Expect.equal (MyDate.parse "29.02.2007").validationMessage "Luna februarie are 28 de zile in 2007"
            , test "handles invalid date months" <|
                \_ ->
                    Expect.equal (MyDate.parse "29.42.2007").validationMessage "Luna datei este incorecta: 42"
            , test "years up to 9999 are considered valid" <|
                \_ ->
                    Expect.equal (MyDate.parse "01.01.9999").date (Result.toMaybe (Date.fromString "9999-01-01"))
            , test "handles valid strings" <|
                \_ ->
                    Expect.equal (MyDate.parse "24.07.2007").date (Result.toMaybe (Date.fromString "2007-07-24"))
            ]
        , describe "format"
            [ test "returns a string of representation of the given date" <|
                \_ ->
                    Expect.equal (MyDate.format (MyDate.parse "24.07.2007")) (Ok "24.07.2007")
            , test "returns an empty string when the date is not valid" <|
                \_ ->
                    Expect.equal (MyDate.format (MyDate.parse "magic")) (Err "Data trebuie sa aiba formatul DD.LL.AAAA")
            ]
        ]
