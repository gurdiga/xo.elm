module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selectable
    exposing
        ( view
        )

import Html exposing (Html, ul, li, text)


type alias Input a msg =
    { items : List a
    , itemRenderer : a -> Html msg
    , callback : List a -> msg
    }


view : List a -> (a -> Html msg) -> (List a -> msg) -> Html msg
view xs itemRenderer callback =
    let
        this =
            ul [] (List.map renderItem xs)

        renderItem item =
            li [] [ itemRenderer item ]
    in
        this
