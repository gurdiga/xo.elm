module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare
    exposing
        ( MasuriDeAsigurare
        , empty
        , view
        )

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare as MasuraDeAsigurare exposing (MasuraDeAsigurare)
import Html exposing (Html, button, fieldset, legend, li, text, ul)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList


type MasuriDeAsigurare
    = MasuriDeAsigurare (List MasuraDeAsigurare)


empty : MasuriDeAsigurare
empty =
    MasuriDeAsigurare [ MasuraDeAsigurare.empty ]


view : MasuriDeAsigurare -> (MasuriDeAsigurare -> Cmd msg -> Sub msg -> msg) -> Html msg
view (MasuriDeAsigurare items) callback =
    let
        c data =
            callback (MasuriDeAsigurare data) Cmd.none Sub.none

        addItem item =
            c (items ++ [ item ])

        deleteItem item _ =
            c (List.filter ((/=) item) items)

        itemView i item =
            li []
                [ MasuraDeAsigurare.view item
                    (\v ->
                        MyList.replace items i v
                            |> MasuriDeAsigurare
                            |> callback
                    )
                , button
                    [ onClick (deleteItem item) ]
                    [ text "Șterge" ]
                ]
    in
    fieldset []
        [ legend [] [ text "MasuriDeAsigurare" ]
        , ul [] (List.indexedMap itemView items)
        , MasuraDeAsigurare.addView addItem
        ]
