module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru
    exposing
        ( Sechestru
        , view
        )

import Html exposing (Html, ul, li, text)
import Utils.RichTextEditor as RichTextEditor
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite.BunUrmarit as BunUrmarit exposing (BunUrmarit)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selectable as Selectable


type Sechestru
    = Sechestru
        { bunuri : List BunUrmarit
        , procesVerbal : String
        }


type alias Callback msg =
    List BunUrmarit -> Cmd msg -> Sub msg -> msg


view : List BunUrmarit -> Callback msg -> Html msg
view bunuriUrmarite callback =
    let
        this =
            Selectable.view bunuriUrmarite BunUrmarit.view (\v -> callback bunuriUrmarite Cmd.none Sub.none)
    in
        this
