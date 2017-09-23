module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare
    exposing
        ( Sechestrare
        , fromItems
        , view
        )

import Html exposing (Html, fieldset, legend, ul, li, text)
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


fromItems : List BunUrmarit -> Sechestrare
fromItems bunuri =
    Sechestrare
        { bunuri = bunuri
        , procesVerbal = ""
        , selection = Selection.empty
        }


view : Sechestrare -> Callback msg -> Html msg
view (Sechestrare data) callback =
    let
        this =
            fieldset []
                [ legend [] [ text "Selecteză bunurile de sechestrat" ]
                , Selection.view (Selection.fromItems data.bunuri)
                    BunUrmarit.view
                    (\v -> callback (Sechestrare { data | selection = v }) Cmd.none Sub.none)
                ]
    in
        this
