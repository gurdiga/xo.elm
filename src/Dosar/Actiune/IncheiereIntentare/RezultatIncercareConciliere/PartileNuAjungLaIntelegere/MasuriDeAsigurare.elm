module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare
    exposing
        ( MasuriDeAsigurare
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, ul, li, text)
import Widgets.Select as Select
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare as MasuraDeAsigurare exposing (MasuraDeAsigurare)


type MasuriDeAsigurare
    = MasuriDeAsigurare (List MasuraDeAsigurare)


empty : MasuriDeAsigurare
empty =
    MasuriDeAsigurare [ MasuraDeAsigurare.empty ]


view : MasuriDeAsigurare -> (MasuriDeAsigurare -> msg) -> Html msg
view (MasuriDeAsigurare items) callback =
    let
        itemView v =
            li [] [ MasuraDeAsigurare.view v ]
    in
        fieldset []
            [ legend [] [ text "MasuriDeAsigurare" ]
            , ul [] (List.map itemView items)
            , Select.view "Adauga:"
                MasuraDeAsigurare.valuesWithLabels
                MasuraDeAsigurare.empty
                (\v -> callback (MasuriDeAsigurare (items ++ [ v ])))
            ]
