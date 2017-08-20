module MyDate exposing (MyDate(MyDate), empty, view, viewUnlabeled, parse, format)

import Html exposing (Html, label, input, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import Date exposing (Date)
import Regex exposing (regex)


-- LATER: add the ability to validate


type MyDate
    = MyDate Data


type alias Data =
    { string : String
    , date : Maybe Date
    , validationMessage : String
    }


empty : MyDate
empty =
    MyDate
        { string = ""
        , date = Nothing
        , validationMessage = ""
        }


view : String -> MyDate -> (MyDate -> msg) -> Html msg
view labelText defaultValue callback =
    label []
        (text labelText
            :: viewUnlabeled defaultValue callback
        )


viewUnlabeled : MyDate -> (MyDate -> msg) -> List (Html msg)
viewUnlabeled ((MyDate data) as defaultValue) callback =
    let
        ( inputText, validationMessage ) =
            case format defaultValue of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( data.string, errorMessage )
    in
        [ input
            [ value inputText
            , onInput (\v -> callback (parse v))
            ]
            []
        , text validationMessage
        ]


parse : String -> MyDate
parse dateString =
    let
        data : Data
        data =
            { string = dateString
            , date = Nothing
            , validationMessage = ""
            }
    in
        -- LATER: How do I model this as a series of transformations? Split,
        -- then look at each piece, etc. ??
        MyDate
            (if not (Regex.contains (regex "^\\d{2}\\.\\d{2}\\.\\d{4}$") dateString) then
                { data | validationMessage = "Data trebuie sa aiba formatul DD.LL.AAAA" }
             else
                let
                    dayString =
                        -- DD.LL.AAAA
                        -- ^^
                        String.slice 0 2 dateString

                    monthString =
                        -- DD.LL.AAAA
                        --    ^^
                        String.slice 3 5 dateString

                    yearString =
                        -- DD.LL.AAAA
                        --       ^^^^
                        String.slice 6 10 dateString
                in
                    case
                        ( validateDayString dayString
                        , validateMonthString monthString
                        , validateYearString yearString
                        )
                    of
                        ( Err e, _, _ ) ->
                            { data | validationMessage = "Ziua datei este incorecta: " ++ dayString }

                        ( Ok _, Err e, _ ) ->
                            { data | validationMessage = "Luna datei este incorecta: " ++ monthString }

                        ( Ok _, Ok _, Err e ) ->
                            { data | validationMessage = "Anul datei este incorect: " ++ yearString }

                        ( Ok day, Ok month, Ok year ) ->
                            case validateDayForMonthAndYear day month year of
                                Err errorMessage ->
                                    { data | validationMessage = errorMessage }

                                Ok day ->
                                    let
                                        isoDateString =
                                            yearString ++ "-" ++ monthString ++ "-" ++ dayString
                                    in
                                        case Date.fromString isoDateString of
                                            Ok date ->
                                                { data | date = Just date }

                                            Err errorMessage ->
                                                { data | validationMessage = errorMessage }
            )


validateDayString : String -> Result String Int
validateDayString dayString =
    case String.toInt dayString of
        Err e ->
            Err e

        Ok day ->
            if day > 31 then
                Err dayString
            else
                Ok day


validateMonthString : String -> Result String Int
validateMonthString monthString =
    case String.toInt monthString of
        Err e ->
            Err e

        Ok monthNumber ->
            if monthNumber > 13 then
                Err monthString
            else
                Ok monthNumber


validateYearString : String -> Result String Int
validateYearString yearString =
    String.toInt yearString



-- LATER: consider having a MyDateParsingError union type with
-- members for each possible error, then let the client code
-- attach text labels for every one of them.


validateDayForMonthAndYear : Int -> Int -> Int -> Result String Int
validateDayForMonthAndYear day month year =
    let
        monthsWith31Days =
            [ 1, 3, 5, 7, 8, 10, 12 ]

        monthsWith30Days =
            [ 4, 6, 9, 11 ]
    in
        if List.member month monthsWith31Days then
            if day < 32 then
                Ok day
            else
                Err ("Luna " ++ (toString month) ++ " are 31 de zile")
        else if List.member month monthsWith30Days then
            if day < 31 then
                Ok day
            else
                Err ("Luna " ++ (toString month) ++ " are 30 de zile")
        else if isLeapYear year then
            -- February
            if day < 30 then
                Ok day
            else
                Err ("Luna februarie are 29 de zile in " ++ (toString year))
        else if day < 29 then
            Ok day
        else
            Err ("Luna februarie are 28 de zile in " ++ (toString year))


isLeapYear : Int -> Bool
isLeapYear year =
    if year % 400 == 0 then
        True
    else if year % 100 == 0 then
        False
    else if year % 4 == 0 then
        True
    else
        False


format : MyDate -> Result String String
format (MyDate data) =
    case data.date of
        Just date ->
            Ok
                ((String.padLeft 2 '0' (toString (Date.day date)))
                    ++ "."
                    ++ (String.padLeft 2 '0' (toString (monthNumber date)))
                    ++ "."
                    ++ (toString (Date.year date))
                )

        Nothing ->
            if data.string == "" then
                Err ""
            else if data.validationMessage == "" then
                Err ("Data invalida: " ++ data.string)
            else
                Err data.validationMessage


monthNumber : Date -> Int
monthNumber date =
    case Date.month date of
        Date.Jan ->
            1

        Date.Feb ->
            2

        Date.Mar ->
            3

        Date.Apr ->
            4

        Date.May ->
            5

        Date.Jun ->
            6

        Date.Jul ->
            7

        Date.Aug ->
            8

        Date.Sep ->
            9

        Date.Oct ->
            10

        Date.Nov ->
            11

        Date.Dec ->
            12
