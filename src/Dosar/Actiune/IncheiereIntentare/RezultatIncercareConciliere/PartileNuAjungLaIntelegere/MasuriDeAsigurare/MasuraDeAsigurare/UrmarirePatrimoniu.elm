module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (UrmarirePatrimoniu, empty, view)

import Html exposing (Html, fieldset, legend, div, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyHtml exposing (whenNothing)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunuriUrmarite as BunuriUrmarite exposing (BunuriUrmarite(BunuriUrmarite))
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
        this =
            fieldset []
                [ legend [] [ text "UrmarirePatrimoniu" ]
                , case data.sechestrare of
                    Just sechestrare ->
                        div []
                            [ Sechestrare.view sechestrare
                                (\v ->
                                    { data | sechestrare = Just v }
                                        |> UrmarirePatrimoniu
                                        |> callback
                                )
                            , button
                                [ onClick
                                    (\_ ->
                                        callback (UrmarirePatrimoniu { data | sechestrare = Nothing })
                                            Cmd.none
                                            Sub.none
                                    )
                                ]
                                [ text "Anulează" ]
                            ]

                    Nothing ->
                        BunuriUrmarite.view data.bunuriUrmarite
                            (\v ->
                                { data | bunuriUrmarite = v }
                                    |> UrmarirePatrimoniu
                                    |> callback
                            )
                , whenNothing data.sechestrare (\_ -> actionButtons)
                ]

        actionButtons =
            div [] [ butonAplicareSechestru ]

        butonAplicareSechestru =
            button
                [ onClick
                    (\_ ->
                        callback
                            (UrmarirePatrimoniu
                                { data
                                    | sechestrare =
                                        BunuriUrmarite.bunuriUrmarite data.bunuriUrmarite
                                            |> Sechestrare.fromItems
                                            |> Just
                                }
                            )
                            Cmd.none
                            Sub.none
                    )
                ]
                [ text "Aplică sechestru" ]
    in
        this
