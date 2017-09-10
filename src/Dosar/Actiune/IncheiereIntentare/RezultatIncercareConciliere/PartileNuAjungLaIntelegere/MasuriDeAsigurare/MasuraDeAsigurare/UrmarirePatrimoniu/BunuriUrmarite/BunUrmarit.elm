module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        , Data
        , empty
        , data
        , view
        , editForm
        )

import Html exposing (Html, fieldset, legend, p, label, input, button, span, strong, small, text, br)
import Html.Attributes exposing (style)
import Utils.MyHtmlEvents exposing (onClick)
import Widgets.Fields exposing (textField, largeTextField, moneyField)
import Utils.Money as Money exposing (Money(Money), Currency(MDL))


type BunUrmarit
    = BunUrmarit Data


type alias Data =
    { denumire : String
    , valoare : Money
    , note : String
    }


empty : BunUrmarit
empty =
    BunUrmarit
        { denumire = ""
        , valoare = Money 0 MDL
        , note = ""
        }


data : BunUrmarit -> Data
data (BunUrmarit data) =
    data


editForm : BunUrmarit -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
editForm bunUrmarit updateCallback submitCallback cancelCallback =
    let
        (BunUrmarit data) =
            bunUrmarit

        c =
            updateCallback << BunUrmarit
    in
        fieldset []
            [ legend [] [ text "Detalii bun:" ]
            , textField "Denumire:" data.denumire (\v -> c { data | denumire = v })
            , br [] []
            , moneyField "Valoare:" data.valoare (\v -> c { data | valoare = v })
            , br [] []
            , largeTextField "Note:" data.note (\v -> c { data | note = v })
            , br [] []
            , button [ onClick (\_ -> submitCallback bunUrmarit) ] [ text "Submit" ]
            , button [ onClick (\_ -> cancelCallback bunUrmarit) ] [ text "Cancel" ]
            ]


view : BunUrmarit -> List (Html msg)
view (BunUrmarit { denumire, valoare, note }) =
    let
        mainStyle =
            [ ( "margin", "0" ) ]

        noteStyle =
            [ ( "margin", "0" )
            , ( "color", "gray" )
            ]
    in
        [ p [ style mainStyle ]
            [ span [] [ text denumire ]
            , text " "
            , strong [] [ text (Money.format valoare) ]
            ]
        , p [ style noteStyle ] [ small [] [ text note ] ]
        ]
