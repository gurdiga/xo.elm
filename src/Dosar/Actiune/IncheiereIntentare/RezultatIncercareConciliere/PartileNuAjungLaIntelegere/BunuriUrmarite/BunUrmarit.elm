module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite.BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        , Data
        , empty
        , data
        , editView
        )

import Html exposing (Html, fieldset, legend, label, input, button, text, br)
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


editView : BunUrmarit -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> (BunUrmarit -> msg) -> Html msg
editView bunUrmarit updateCallback submitCallback cancelCallback =
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
