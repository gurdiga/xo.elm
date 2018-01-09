module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        , Data
        , data
        , editForm
        , empty
        , view
        )

import Html exposing (Html, br, button, div, fieldset, input, label, legend, p, small, span, strong, text)
import Html.Attributes exposing (style)
import Utils.Money as Money exposing (Currency(MDL), Money(Money))
import Utils.MyHtmlEvents exposing (onClick)
import Widgets.Fields exposing (largeTextField, moneyField, textField)


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


view : BunUrmarit -> Html msg
view (BunUrmarit { denumire, valoare, note }) =
    let
        mainStyle =
            [ ( "margin", "0" ) ]

        noteStyle =
            [ ( "margin", "0" )
            , ( "color", "gray" )
            ]
    in
    div []
        [ p [ style mainStyle ]
            [ span [] [ text denumire ]
            , text " "
            , strong [] [ text (Money.format valoare) ]
            ]
        , p [ style noteStyle ] [ small [] [ text note ] ]
        ]
