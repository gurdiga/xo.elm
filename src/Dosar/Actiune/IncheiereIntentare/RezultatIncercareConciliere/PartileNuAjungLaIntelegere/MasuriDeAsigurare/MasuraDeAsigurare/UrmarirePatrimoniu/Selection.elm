module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.Selection
    exposing
        ( Selection
        , empty
        , view
        )

import Html exposing (Html, ul, li, input, text)
import Html.Attributes exposing (type_, checked)


type Selection a
    = Selection (List (SelectionItem a))


type SelectionItem a
    = SelectionItem
        { item : a
        , isSelected : Bool
        }


empty : Selection a
empty =
    Selection []


view : List a -> (a -> Html msg) -> (List a -> msg) -> Html msg
view items itemRenderer callback =
    let
        this =
            ul [] (List.map renderItem items)

        renderItem item =
            li [] [ checkbox, itemRenderer item ]

        checkbox =
            input [ type_ "checkbox", checked True ] []
    in
        this
