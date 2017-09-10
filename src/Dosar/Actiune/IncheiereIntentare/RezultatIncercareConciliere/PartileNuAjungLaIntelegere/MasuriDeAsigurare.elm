module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare
    exposing
        ( MasuriDeAsigurare
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, ul, li, text)
import Widgets.Select as Select
import Utils.List as List
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare as MasuraDeAsigurare exposing (MasuraDeAsigurare)


type MasuriDeAsigurare
    = MasuriDeAsigurare (List MasuraDeAsigurare)


empty : MasuriDeAsigurare
empty =
    MasuriDeAsigurare []


view : MasuriDeAsigurare -> (MasuriDeAsigurare -> msg) -> Html msg
view (MasuriDeAsigurare items) callback =
    let
        c =
            callback << MasuriDeAsigurare

        addItem item =
            c (items ++ [ item ])

        itemView i item =
            li [] [ MasuraDeAsigurare.view item (\v -> c (List.replace items i v)) ]
    in
        fieldset []
            [ legend [] [ text "MasuriDeAsigurare" ]
            , ul [] (List.indexedMap itemView items)
            , MasuraDeAsigurare.addView addItem
            ]
