module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite exposing (BunuriUrmarite)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru as Sechestru exposing (Sechestru)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : BunuriUrmarite
        , sechestre : List Sechestru
        , regimSechestrare : Bool
        }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = BunuriUrmarite.empty
        , sechestre = []
        , regimSechestrare = False
        }


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> Cmd msg -> Sub msg -> msg) -> Html msg
view (UrmarirePatrimoniu ({ bunuriUrmarite, regimSechestrare } as data)) callback =
    let
        c data =
            callback (UrmarirePatrimoniu data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "UrmarirePatrimoniu" ]
            , button [ onClick (\_ -> c { data | regimSechestrare = True }) ] [ text "Aplică sechestru 2.0" ]
            , if regimSechestrare then
                Sechestru.view (BunuriUrmarite.bunuriUrmarite bunuriUrmarite)
              else
                BunuriUrmarite.view data.bunuriUrmarite (\v -> { data | bunuriUrmarite = v } |> UrmarirePatrimoniu |> callback)
            ]
