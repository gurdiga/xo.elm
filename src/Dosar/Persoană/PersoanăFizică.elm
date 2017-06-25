module Dosar.Persoană.PersoanăFizică exposing (PersoanăFizică, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, label, input, textarea, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import MyDate exposing (MyDate)


type alias PersoanăFizică =
    { nume : String
    , prenume : String
    , dataNașterii : MyDate
    , cnp : String
    , adresa : String -- Address?
    , note : String
    }


newValue : PersoanăFizică
newValue =
    { nume = ""
    , prenume = ""
    , dataNașterii = Err ""
    , cnp = ""
    , adresa = ""
    , note = ""
    }


view : PersoanăFizică -> (PersoanăFizică -> msg) -> Html msg
view persoană callback =
    fieldset []
        [ legend [] [ text "PersoanăFizică" ]
        , ul []
            [ li [] [ textField "Nume:" persoană.nume (\v -> callback { persoană | nume = v }) ]
            , li [] [ textField "Prenume:" persoană.prenume (\v -> callback { persoană | prenume = v }) ]
            , li [] [ dateField "Data nașterii:" persoană.dataNașterii (\v -> callback { persoană | dataNașterii = v }) ]
            , li [] [ textField "CNP:" persoană.cnp (\v -> callback { persoană | cnp = v }) ]
            , li [] [ largeTextField "Adresa:" persoană.adresa (\v -> callback { persoană | adresa = v }) ]
            , li [] [ largeTextField "Note:" persoană.note (\v -> callback { persoană | note = v }) ]
            ]
        ]


textField : String -> String -> (String -> msg) -> Html msg
textField labelText defaultValue callback =
    label []
        [ text labelText
        , input
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


largeTextField : String -> String -> (String -> msg) -> Html msg
largeTextField labelText defaultValue callback =
    label []
        [ text labelText
        , textarea
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


dateField : String -> MyDate -> (MyDate -> msg) -> Html msg
dateField labelText defaultValue callback =
    let
        ( inputText, validationMessage ) =
            case defaultValue of
                Ok date ->
                    ( MyDate.format (Ok date), "OK" )

                Err errorMessage ->
                    ( "", errorMessage )
    in
        label []
            [ text labelText
            , input
                [ value inputText
                , onInput (\v -> callback (MyDate.parse v))
                ]
                []
            , text validationMessage
            ]
