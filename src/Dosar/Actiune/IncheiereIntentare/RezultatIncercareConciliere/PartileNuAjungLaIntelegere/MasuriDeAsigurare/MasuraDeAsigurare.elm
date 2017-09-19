module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare
    exposing
        ( MasuraDeAsigurare
        , empty
        , addView
        , view
        )

import Html exposing (Html, div, fieldset, legend, ul, li, button, text)
import Utils.MyHtmlEvents exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu as UrmarirePatrimoniu exposing (UrmarirePatrimoniu)


type MasuraDeAsigurare
    = UrmarirePatrimoniu UrmarirePatrimoniu
    | Evacuare
    | EfectuareActeObligatorii
    | RestabilireSalariat
    | StabilireDomiciliuCopil


empty : MasuraDeAsigurare
empty =
    UrmarirePatrimoniu UrmarirePatrimoniu.empty


addView : (MasuraDeAsigurare -> msg) -> Html msg
addView callback =
    div []
        [ text "Adaugă măsură:"
        , ul []
            [ li [] [ button [ onClick (\_ -> callback << UrmarirePatrimoniu <| UrmarirePatrimoniu.empty) ] [ text "UrmarirePatrimoniu" ] ]
            , li [] [ button [ onClick (\_ -> callback Evacuare) ] [ text "Evacuare" ] ]
            , li [] [ button [ onClick (\_ -> callback EfectuareActeObligatorii) ] [ text "EfectuareActeObligatorii" ] ]
            , li [] [ button [ onClick (\_ -> callback RestabilireSalariat) ] [ text "RestabilireSalariat" ] ]
            , li [] [ button [ onClick (\_ -> callback StabilireDomiciliuCopil) ] [ text "StabilireDomiciliuCopil" ] ]
            ]
        ]


view : MasuraDeAsigurare -> (MasuraDeAsigurare -> Cmd msg -> Sub msg -> msg) -> Html msg
view masuraDeAsigurare callback =
    case masuraDeAsigurare of
        UrmarirePatrimoniu v ->
            UrmarirePatrimoniu.view v (callback << UrmarirePatrimoniu)

        Evacuare ->
            viewEvacuare

        EfectuareActeObligatorii ->
            viewEfectuareActeObligatorii

        RestabilireSalariat ->
            viewRestabilireSalariat

        StabilireDomiciliuCopil ->
            viewStabilireDomiciliuCopil


viewEvacuare : Html msg
viewEvacuare =
    text "viewEvacuare!"


viewEfectuareActeObligatorii : Html msg
viewEfectuareActeObligatorii =
    text "viewEfectuareActeObligatorii!"


viewRestabilireSalariat : Html msg
viewRestabilireSalariat =
    text "viewRestabilireSalariat!"


viewStabilireDomiciliuCopil : Html msg
viewStabilireDomiciliuCopil =
    text "viewStabilireDomiciliuCopil!"
