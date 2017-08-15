module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere
    exposing
        ( PartileNuAjungLaIntelegere
        , newValue
        , view
        )

import Html exposing (Html, h1, div, p, text)
import RichTextEditor
import MyDate exposing (MyDate)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunurileUrmarite as BunurileUrmarite exposing (BunurileUrmarite)


type PartileNuAjungLaIntelegere
    = PartileNuAjungLaIntelegere Data


type alias Data =
    { procesVerbalContinuare : String
    , incheiereContinuare : String
    , borderouDeCalcul : String
    , termenDeExecutare : MyDate
    , bunurileUrmarite : BunurileUrmarite
    }


newValue : PartileNuAjungLaIntelegere
newValue =
    PartileNuAjungLaIntelegere
        { procesVerbalContinuare = ""
        , incheiereContinuare = ""
        , borderouDeCalcul = ""
        , termenDeExecutare = MyDate.newValue
        , bunurileUrmarite = BunurileUrmarite.newValue
        }


view : PartileNuAjungLaIntelegere -> (PartileNuAjungLaIntelegere -> Cmd msg -> Sub msg -> msg) -> Html msg
view partileNuAjungLaIntelegere callback =
    let
        (PartileNuAjungLaIntelegere data) =
            partileNuAjungLaIntelegere

        c data =
            callback (PartileNuAjungLaIntelegere data) Cmd.none Sub.none
    in
        div []
            [ MyDate.view "Termen de executare:" data.termenDeExecutare (\v -> c { data | termenDeExecutare = v })
            , RichTextEditor.view
                { buttonLabel = "Formează proces-verbal de continuare"
                , content = templateProcesVerbalContinuare data
                , onOpen = callback partileNuAjungLaIntelegere
                , onResponse = (\v -> c { data | procesVerbalContinuare = v })
                }
            , RichTextEditor.view
                { buttonLabel = "Formează încheiere de continuare"
                , content = templateIncheiereContinuare data
                , onOpen = callback partileNuAjungLaIntelegere
                , onResponse = (\v -> c { data | incheiereContinuare = v })
                }
            , RichTextEditor.view
                { buttonLabel = "Formează borderou de calcul"
                , content = templateBorderouDeCalcul data
                , onOpen = callback partileNuAjungLaIntelegere
                , onResponse = (\v -> c { data | borderouDeCalcul = v })
                }
            , BunurileUrmarite.view data.bunurileUrmarite (\v -> c { data | bunurileUrmarite = v })
            ]


templateProcesVerbalContinuare : Data -> List (Html msg)
templateProcesVerbalContinuare data =
    -- TODO: find the real template
    [ h1 [] [ text "Proces-verbal de continuare" ]
    , p [] [ text <| toString <| data ]
    ]


templateIncheiereContinuare : Data -> List (Html msg)
templateIncheiereContinuare data =
    -- TODO: find the real template
    [ h1 [] [ text "Incheiere de continuare" ]
    , p [] [ text <| toString <| data ]
    ]


templateBorderouDeCalcul : Data -> List (Html msg)
templateBorderouDeCalcul data =
    -- TODO: find the real template
    [ h1 [] [ text "Borderou de calcul" ]
    , p [] [ text <| toString <| data ]
    ]
