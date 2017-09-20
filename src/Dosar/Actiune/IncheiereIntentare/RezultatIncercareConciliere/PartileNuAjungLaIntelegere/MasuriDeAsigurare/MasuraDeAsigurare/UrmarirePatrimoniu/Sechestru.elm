module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru
    exposing
        ( Sechestru
        , view
        )

import Html exposing (Html, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit exposing (BunUrmarit)


type Sechestru
    = Sechestru
        { bunuri : List BunUrmarit
        , procesVerbal : String
        }


view : List BunUrmarit -> Html msg
view =
    toString >> text



{--

Maybe Sechestru should have its own view, given the list of available items.
Its container will decide when to display it.

--}
