module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite exposing (BunuriUrmarite(BunuriUrmarite), Selectable(Selectable))
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Sechestru as Sechestru exposing (Sechestru)


type UrmarirePatrimoniu
    = UrmarirePatrimoniu
        { bunuriUrmarite : BunuriUrmarite
        , sechestru : Maybe Sechestru
        }


empty : UrmarirePatrimoniu
empty =
    UrmarirePatrimoniu
        { bunuriUrmarite = BunuriUrmarite.empty
        , sechestru = Nothing
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
                        c { data | sechestru = BunuriUrmarite.bunuriUrmarite data.bunuriUrmarite |> Sechestru.new |> Just }
                    )
                ]
                [ text "Aplică sechestru 2.0" ]
            , case data.sechestru of
                Just sechestru ->
                    Sechestru.view sechestru
                        (\v ->
                            { data | sechestru = Just v }
                                |> UrmarirePatrimoniu
                                |> callback
                        )

                Nothing ->
                    BunuriUrmarite.view data.bunuriUrmarite (\v -> { data | bunuriUrmarite = v } |> UrmarirePatrimoniu |> callback)
            ]
