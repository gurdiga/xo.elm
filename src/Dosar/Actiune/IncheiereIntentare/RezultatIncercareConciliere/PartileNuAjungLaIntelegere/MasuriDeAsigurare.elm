module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare
    exposing
        ( MasuriDeAsigurare
        , empty
        , view
        )

import Html exposing (Html, fieldset, legend, ul, li, text)
import Utils.MyList as MyList
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
            li [] [ MasuraDeAsigurare.view item (\v -> c (MyList.replace items i v)) ]
    in
        fieldset []
            [ legend [] [ text "MasuriDeAsigurare" ]
            , ul [] (List.indexedMap itemView items)
            , MasuraDeAsigurare.addView addItem
            ]
