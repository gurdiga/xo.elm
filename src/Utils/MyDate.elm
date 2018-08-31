module Utils.MyDate exposing (Model, date, empty, format, parse, string, validationMessage)

import Regex exposing (fromString)
import Time exposing (utc)


-- LATER: add the ability to validate


type Model
    = Model
        { string : String
        , date : Maybe Time.Posix
        , validationMessage : String
        }


empty : Model
empty =
    Model
        { string = ""
        , date = Nothing
        , validationMessage = ""
        }


validationMessage : Model -> String
validationMessage (Model model) =
    model.validationMessage


date : Model -> Maybe Time.Posix
date (Model model) =
    model.date


string : Model -> String
string (Model model) =
    model.string


parse : String -> Model
parse dateString =
    let
        model =
            { string = dateString
            , date = Nothing
            , validationMessage = ""
            }
    in
    -- LATER: How do I model this as a series of transformations? Split,
    -- then look at each piece, etc. ??
    Model
        (if
            not
                (Regex.contains
                    (Maybe.withDefault Regex.never <|
                        fromString "^\\d{2}\\.\\d{2}\\.\\d{4}$"
                    )
                    dateString
                )
         then
            { model | validationMessage = "Data trebuie sa aiba formatul DD.LL.AAAA" }
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
                    { model | validationMessage = "Ziua datei este incorecta: " ++ dayString }

                ( Ok _, Err e, _ ) ->
                    { model | validationMessage = "Luna datei este incorecta: " ++ monthString }

                ( Ok _, Ok _, Err e ) ->
                    { model | validationMessage = "Anul datei este incorect: " ++ yearString }

                ( Ok day, Ok month, Ok year ) ->
                    case validateDayForMonthAndYear day month year of
                        Err errorMessage ->
                            { model | validationMessage = errorMessage }

                        Ok _ ->
                            let
                                msPerYear =
                                    msPerMonth * 12

                                -- TODO: Figure out how to calculate it correctly.
                                msPerMonth =
                                    msPerDay * 31

                                msPerDay =
                                    24 * 60 * 60 * 1000
                            in
                            { model | date = Just <| Time.millisToPosix <| year * msPerYear + month * msPerMonth + day * msPerMonth }
        )


validateDayString : String -> Result String Int
validateDayString dayString =
    case String.toInt dayString of
        Nothing ->
            Err <| "Not a valid day number " ++ dayString

        Just day ->
            if day > 31 then
                Err dayString
            else
                Ok day


validateMonthString : String -> Result String Int
validateMonthString monthString =
    case String.toInt monthString of
        Nothing ->
            Err <| "Not a valid month number " ++ monthString

        Just m ->
            if m > 13 then
                Err monthString
            else
                Ok m


validateYearString : String -> Result String Int
validateYearString yearString =
    case String.toInt yearString of
        Nothing ->
            Err <| "Not a valid year number " ++ yearString

        Just y ->
            Ok y



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
            Err ("Luna " ++ String.fromInt month ++ " are 31 de zile")
    else if List.member month monthsWith30Days then
        if day < 31 then
            Ok day
        else
            Err ("Luna " ++ String.fromInt month ++ " are 30 de zile")
    else if isLeapYear year then
        -- February
        if day < 30 then
            Ok day
        else
            Err ("Luna februarie are 29 de zile in " ++ String.fromInt year)
    else if day < 29 then
        Ok day
    else
        Err ("Luna februarie are 28 de zile in " ++ String.fromInt year)


isLeapYear : Int -> Bool
isLeapYear year =
    if remainderBy 400 year == 0 then
        True
    else if remainderBy 100 year == 0 then
        False
    else if remainderBy 4 year == 0 then
        True
    else
        False


format : Model -> Result String String
format (Model model) =
    case model.date of
        Just d ->
            Ok
                (String.padLeft 2 '0' (String.fromInt (Time.toDay utc d))
                    ++ "."
                    ++ String.padLeft 2 '0' (String.fromInt (monthNumber d))
                    ++ "."
                    ++ String.fromInt (Time.toYear utc d)
                )

        Nothing ->
            if model.string == "" then
                Err ""
            else if model.validationMessage == "" then
                Err ("Data invalida: " ++ model.string)
            else
                Err model.validationMessage


monthNumber : Time.Posix -> Int
monthNumber d =
    case Time.toMonth utc d of
        Time.Jan ->
            1

        Time.Feb ->
            2

        Time.Mar ->
            3

        Time.Apr ->
            4

        Time.May ->
            5

        Time.Jun ->
            6

        Time.Jul ->
            7

        Time.Aug ->
            8

        Time.Sep ->
            9

        Time.Oct ->
            10

        Time.Nov ->
            11

        Time.Dec ->
            12
