module Dosar.Actiune exposing (Actiune, newValue, view)

import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare exposing (IncheiereIntentare)
import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz exposing (IncheiereRefuz)
import Html exposing (Html, div, label, text)
import Widgets.Select as Select


type Actiune
    = IncheiereIntentare IncheiereIntentare
    | IncheiereRefuz IncheiereRefuz


valuesWithLabels : List ( Actiune, String )
valuesWithLabels =
    [ ( IncheiereIntentare IncheiereIntentare.newValue, "intentare" )
    , ( IncheiereRefuz IncheiereRefuz.newValue, "refuz" )
    ]


newValue : Actiune
newValue =
    IncheiereIntentare IncheiereIntentare.newValue


type alias Callback msg =
    Actiune -> Cmd msg -> Sub msg -> msg


view : Actiune -> Callback msg -> Html msg
view actiune callback =
    div []
        [ dropdown actiune callback
        , fields actiune callback
        ]


dropdown : Actiune -> Callback msg -> Html msg
dropdown actiune callback =
    label []
        [ text "Actiune:"
        , Select.fromValuesWithLabels valuesWithLabels newValue (\v -> callback v Cmd.none Sub.none)
        ]


fields : Actiune -> Callback msg -> Html msg
fields actiune callback =
    case actiune of
        IncheiereIntentare incheiereIntentare ->
            IncheiereIntentare.view incheiereIntentare (\v cmd sub -> callback (IncheiereIntentare v) cmd sub)

        IncheiereRefuz incheiereRefuz ->
            IncheiereRefuz.view incheiereRefuz (\v cmd sub -> callback (IncheiereRefuz v) cmd sub)
