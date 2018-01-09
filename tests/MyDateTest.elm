module MyDateTest exposing (..)

import Date exposing (Date)
import Expect
import Test exposing (..)
import Utils.MyDate as MyDate


suite : Test
suite =
    let
        parseDateString s =
            MyDate.parse s
    in
    describe "MyDate"
        [ describe "parse"
            [ test "handles invalid strings" <|
                \_ ->
                    Expect.equal (MyDate.validationMessage (parseDateString "magic")) "Data trebuie sa aiba formatul DD.LL.AAAA"
            , test "handles clearly invalid date days" <|
                \_ ->
                    Expect.equal (MyDate.validationMessage (parseDateString "42.07.2007")) "Ziua datei este incorecta: 42"
            , test "handles subtly invalid date days" <|
                \_ ->
                    Expect.equal (MyDate.validationMessage (parseDateString "29.02.2007")) "Luna februarie are 28 de zile in 2007"
            , test "handles invalid date months" <|
                \_ ->
                    Expect.equal (MyDate.validationMessage (parseDateString "29.42.2007")) "Luna datei este incorecta: 42"
            , test "years up to 9999 are considered valid" <|
                \_ ->
                    Expect.equal (MyDate.date (parseDateString "01.01.9999")) (Result.toMaybe (Date.fromString "9999-01-01"))
            , test "handles valid strings" <|
                \_ ->
                    Expect.equal (MyDate.date (parseDateString "24.07.2007")) (Result.toMaybe (Date.fromString "2007-07-24"))
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
