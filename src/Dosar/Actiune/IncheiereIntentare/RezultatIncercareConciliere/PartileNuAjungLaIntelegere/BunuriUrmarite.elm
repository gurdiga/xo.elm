module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite exposing (BunuriUrmarite, empty, view)

import Html exposing (Html, fieldset, legend, p, button, text)
import Html.Events exposing (onClick)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite (List BunUrmarit) (Maybe BunUrmarit)


empty : BunuriUrmarite
empty =
    BunuriUrmarite [] Nothing



{-

   THE IDEA

   There is the existing list, and maybe another one item which can be:
   - the one that I’m adding
   - one of the existing that I’m editing
   - nothing, it’s just the list

-}


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view (BunuriUrmarite list newItem) callback =
    let
        c list newItem =
            callback (BunuriUrmarite list (Just newItem))
    in
        fieldset []
            [ legend [] [ text "BunuriUrmarite" ]

            -- maybe extract this case into a helper function?
            , case newItem of
                Nothing ->
                    text ""

                Just newItem ->
                    -- add a callback for “Cancel” that will set newItem to nothing
                    BunUrmarit.editView newItem (\v -> c list v)
            , button [ onClick (c list BunUrmarit.empty) ] [ text "+" ]
            ]
