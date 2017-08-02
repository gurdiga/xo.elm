module Dosar.Actiune exposing (Actiune, newValue, view)

import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare exposing (IncheiereIntentare)
import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz exposing (IncheiereRefuz)
import Html exposing (Html, div, label, text)
import Widgets.Select as Select


type Actiune
    = IncheiereIntentare (Maybe IncheiereIntentare)
    | IncheiereRefuz (Maybe IncheiereRefuz)


newValue : Actiune
newValue =
    IncheiereRefuz Nothing


view : Actiune -> (Actiune -> Cmd msg -> Sub msg -> msg) -> Html msg
view actiune c =
    let
        callback v =
            c v Cmd.none Sub.none
    in
        div []
            [ dropdown actiune callback
            , fields actiune c
            ]


dropdown : Actiune -> (Actiune -> msg) -> Html msg
dropdown actiune callback =
    label []
        [ text "Actiune:"
        , Select.fromValuesWithLabels valuesWithLabels newValue callback
        ]


valuesWithLabels : List ( Actiune, String )
valuesWithLabels =
    [ ( IncheiereIntentare (Just IncheiereIntentare.newValue), "intentare" )
    , ( IncheiereRefuz (Just IncheiereRefuz.newValue), "refuz" )
    ]


fields : Actiune -> (Actiune -> Cmd msg -> Sub msg -> msg) -> Html msg
fields actiune callback =
    case actiune of
        IncheiereIntentare incheiereIntentare ->
            IncheiereIntentare.view incheiereIntentare (\v cmd sub -> callback (IncheiereIntentare v) cmd sub)

        IncheiereRefuz incheiereRefuz ->
            IncheiereRefuz.view incheiereRefuz (\v cmd sub -> callback (IncheiereRefuz v) cmd sub)
