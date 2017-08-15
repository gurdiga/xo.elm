module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunurileUrmarite.BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        , Data
        , newValue
        , data
        )

import Money exposing (Money(Money), Currency(MDL))


type BunUrmarit
    = BunUrmarit Data


type alias Data =
    { denumire : String
    , valoare : Money
    , note : String
    }


newValue : BunUrmarit
newValue =
    BunUrmarit
        { denumire = ""
        , valoare = Money 0 MDL
        , note = ""
        }


data : BunUrmarit -> Data
data (BunUrmarit data) =
    data
