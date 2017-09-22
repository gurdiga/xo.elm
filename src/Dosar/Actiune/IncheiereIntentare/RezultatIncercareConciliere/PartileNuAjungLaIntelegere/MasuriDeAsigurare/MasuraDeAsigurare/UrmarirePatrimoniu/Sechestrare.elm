module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare
    exposing
        ( Sechestrare
        , new
        , view
        )

import Html exposing (Html, ul, li, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit exposing (BunUrmarit)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selection as Selection exposing (Selection)


type Sechestrare
    = Sechestrare
        { bunuri : List BunUrmarit
        , procesVerbal : String
        , selection : Selection BunUrmarit
        }


type alias Callback msg =
    Sechestrare -> Cmd msg -> Sub msg -> msg


new : List BunUrmarit -> Sechestrare
new bunuri =
    Sechestrare
        { bunuri = bunuri
        , procesVerbal = ""
        , selection = Selection.empty
        }


view : Sechestrare -> Callback msg -> Html msg
view (Sechestrare data) callback =
    let
        this =
            Selection.view data.bunuri BunUrmarit.view (\v -> callback (Sechestrare { data | bunuri = v }) Cmd.none Sub.none)
    in
        this
