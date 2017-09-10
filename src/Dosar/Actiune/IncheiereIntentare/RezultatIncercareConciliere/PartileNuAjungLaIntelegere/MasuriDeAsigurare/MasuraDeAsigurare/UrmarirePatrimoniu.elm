module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, text)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite exposing (BunuriUrmarite)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu Data


type alias Data =
    { bunuriUrmarite : BunuriUrmarite
    }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = BunuriUrmarite.empty }


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> msg) -> Html msg
view (UrmarirePatrimoniu data) callback =
    let
        c =
            callback << UrmarirePatrimoniu
    in
        fieldset []
            [ legend [] [ text "UrmarirePatrimoniu" ]
            , BunuriUrmarite.view data.bunuriUrmarite (\v -> c { data | bunuriUrmarite = v })
            ]
