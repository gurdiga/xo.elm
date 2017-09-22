module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru
    exposing
        ( Sechestru
        , new
        , view
        )

import Html exposing (Html, ul, li, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit exposing (BunUrmarit)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selectable as Selectable


type Sechestru
    = Sechestru
        { bunuri : List BunUrmarit
        , procesVerbal : String
        }


type alias Callback msg =
    Sechestru -> Cmd msg -> Sub msg -> msg


new : List BunUrmarit -> Sechestru
new bunuri =
    Sechestru
        { bunuri = bunuri
        , procesVerbal = ""
        }


view : Sechestru -> Callback msg -> Html msg
view (Sechestru data) callback =
    let
        this =
            Selectable.view data.bunuri BunUrmarit.view (\v -> callback (Sechestru { data | bunuri = v }) Cmd.none Sub.none)
    in
        this
