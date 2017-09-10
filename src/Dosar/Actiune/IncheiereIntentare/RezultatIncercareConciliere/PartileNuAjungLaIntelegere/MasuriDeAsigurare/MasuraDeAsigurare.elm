module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare
    exposing
        ( MasuraDeAsigurare
        , empty
        , valuesWithLabels
        , view
        )

import Html exposing (Html, fieldset, legend, text)
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


valuesWithLabels : List ( MasuraDeAsigurare, String )
valuesWithLabels =
    [ ( UrmarirePatrimoniu UrmarirePatrimoniu.empty, "UrmarirePatrimoniu" )
    , ( Evacuare, "Evacuare" )
    , ( EfectuareActeObligatorii, "EfectuareActeObligatorii" )
    , ( RestabilireSalariat, "RestabilireSalariat" )
    , ( StabilireDomiciliuCopil, "StabilireDomiciliuCopil" )
    ]


view : MasuraDeAsigurare -> Html msg
view masuraDeAsigurare =
    case masuraDeAsigurare of
        UrmarirePatrimoniu v ->
            UrmarirePatrimoniu.view v

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
