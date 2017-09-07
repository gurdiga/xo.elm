module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite exposing (BunuriUrmarite, empty, view)

import Html exposing (Html, fieldset, legend, p, button, text, br)
import Utils.MyHtmlEvents exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite Data


type alias Data =
    { items : List BunUrmarit
    , itemToEdit : Maybe BunUrmarit
    }


empty : BunuriUrmarite
empty =
    BunuriUrmarite
        { items = []
        , itemToEdit = Nothing
        }


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view bunuriUrmarite callback =
    let
        (BunuriUrmarite { items, itemToEdit }) =
            bunuriUrmarite

        updateItemToEdit item =
            callback (BunuriUrmarite { items = items, itemToEdit = Just item })

        submitItemCallback item =
            callback (BunuriUrmarite { items = items ++ [ item ], itemToEdit = Nothing })

        cancelEditCallback item =
            callback (BunuriUrmarite { items = items, itemToEdit = Nothing })
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]
            , text (toString bunuriUrmarite)
            , br [] []
            , case itemToEdit of
                Nothing ->
                    text ""

                Just itemToEdit ->
                    -- add a callback for “Cancel” that will set itemToEdit to nothing
                    BunUrmarit.editView itemToEdit updateItemToEdit submitItemCallback cancelEditCallback
            , button [ onClick (\_ -> updateItemToEdit BunUrmarit.empty) ] [ text "+" ]
            ]
