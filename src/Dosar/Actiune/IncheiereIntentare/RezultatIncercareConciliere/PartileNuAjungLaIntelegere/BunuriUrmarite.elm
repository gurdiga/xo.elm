module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite exposing (BunuriUrmarite, empty, view)

import Html exposing (Html, fieldset, legend, p, button, text)
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

        itemToEditCallback itemToEdit =
            callback (BunuriUrmarite { items = items, itemToEdit = Just itemToEdit })
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]

            -- maybe extract this case into a helper function?
            , case itemToEdit of
                Nothing ->
                    text ""

                Just itemToEdit ->
                    -- add a callback for “Cancel” that will set itemToEdit to nothing
                    BunUrmarit.editView itemToEdit itemToEditCallback
            , button [ onClick (\_ -> itemToEditCallback BunUrmarit.empty) ] [ text "+" ]
            ]
