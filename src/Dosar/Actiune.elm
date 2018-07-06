module Dosar.Actiune exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare
import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz
import Html.Styled exposing (Html, fieldset, label, legend, map, text)
import Widgets.Select3 as Select3


type Actiune
    = IncheiereIntentare IncheiereIntentare.Model
    | IncheiereRefuz IncheiereRefuz.Model


type alias Model =
    { actiune : Actiune
    , ui : Ui
    }


type alias Ui =
    { select : Select3.Model Actiune
    }


valuesWithLabels : List ( Actiune, String )
valuesWithLabels =
    [ ( IncheiereIntentare IncheiereIntentare.initialModel, "intentare" )
    , ( IncheiereRefuz IncheiereRefuz.initialModel, "refuz" )
    ]


initialActiune : Actiune
initialActiune =
    IncheiereIntentare IncheiereIntentare.initialModel


initialModel : Model
initialModel =
    { actiune = initialActiune
    , ui =
        { select = Select3.initialModel initialActiune valuesWithLabels
        }
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "Actiune" ]
        , dropdown model
        , fields model.actiune
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select3.view "Actiune:" model.ui.select |> map ResetActiune


fields : Actiune -> Html Msg
fields actiune =
    case actiune of
        IncheiereIntentare incheiereIntentare ->
            IncheiereIntentare.view incheiereIntentare |> map SetIncheiereIntentare

        IncheiereRefuz incheiereRefuz ->
            IncheiereRefuz.view incheiereRefuz |> map SetIncheiereIntentare


type Msg
    = ResetActiune (Select3.Msg Actiune)
    | SetIncheiereIntentare IncheiereIntentare.Msg
    | SetIncheiereRefuz IncheiereRefuz.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        ResetActiune actiuneMsgSelect3 ->
            resetActiune model (Select3.update actiuneMsgSelect3 model.ui.select)

        SetIncheiereIntentare msgIncheiereIntentare ->
            case model.actiune of
                IncheiereIntentare modelIncheiereIntentare ->
                    { model | actiune = IncheiereIntentare (IncheiereIntentare.update msgIncheiereIntentare modelIncheiereIntentare) }

                IncheiereRefuz modelIncheiereRefuz ->
                    model

        SetIncheiereRefuz msgIncheiereRefuz ->
            case model.actiune of
                IncheiereRefuz modelIncheiereRefuz ->
                    { model | actiune = IncheiereRefuz (IncheiereRefuz.update msgIncheiereRefuz modelIncheiereRefuz) }

                IncheiereIntentare modelIncheiereIntentare ->
                    model


resetActiune : Model -> Select3.Model Actiune -> Model
resetActiune ({ ui } as model) newSelect =
    { model
        | ui = { ui | select = newSelect }
        , actiune = Select3.selectedValue newSelect
    }
