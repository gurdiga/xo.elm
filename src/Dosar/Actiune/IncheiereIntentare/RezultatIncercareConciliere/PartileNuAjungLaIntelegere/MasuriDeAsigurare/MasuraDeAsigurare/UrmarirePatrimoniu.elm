module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite exposing (BunuriUrmarite(BunuriUrmarite), Selectable(Selectable))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestrare as Sechestrare exposing (Sechestrare)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : BunuriUrmarite
        , sechestrare : Maybe Sechestrare
        }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = BunuriUrmarite.empty
        , sechestrare = Nothing
        }


view : UrmarirePatrimoniu -> (UrmarirePatrimoniu -> Cmd msg -> Sub msg -> msg) -> Html msg
view (UrmarirePatrimoniu data) callback =
    let
        c data =
            callback (UrmarirePatrimoniu data) Cmd.none Sub.none

        (BunuriUrmarite itemData) =
            data.bunuriUrmarite
    in
        fieldset []
            [ legend [] [ text "UrmarirePatrimoniu" ]
            , button
                [ onClick
                    (\_ ->
                        c { data | sechestrare = BunuriUrmarite.bunuriUrmarite data.bunuriUrmarite |> Sechestrare.new |> Just }
                    )
                ]
                [ text "Aplică sechestrare 2.0" ]
            , case data.sechestrare of
                Just sechestrare ->
                    Sechestrare.view sechestrare
                        (\v ->
                            { data | sechestrare = Just v }
                                |> UrmarirePatrimoniu
                                |> callback
                        )

                Nothing ->
                    BunuriUrmarite.view data.bunuriUrmarite (\v -> { data | bunuriUrmarite = v } |> UrmarirePatrimoniu |> callback)
            ]
