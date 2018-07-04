module Dosar.Actiune exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereIntentare as IncheiereIntentare exposing (IncheiereIntentare)
-- import Dosar.Actiune.IncheiereRefuz as IncheiereRefuz exposing (IncheiereRefuz)

import Html.Styled exposing (Html, fieldset, label, legend, map, text)
import Widgets.Select3 as Select3


type Actiune
    = IncheiereIntentare
    | IncheiereRefuz


type alias Model =
    { actiune : Actiune
    , ui : Ui
    }


type alias Ui =
    { select : Select3.Model Actiune
    }



-- = IncheiereIntentare IncheiereIntentare
-- | IncheiereRefuz IncheiereRefuz


valuesWithLabels : List ( Actiune, String )
valuesWithLabels =
    [ ( IncheiereIntentare, "intentare" )
    , ( IncheiereRefuz, "refuz" )
    ]


initialActiune : Actiune
initialActiune =
    IncheiereIntentare


initialModel : Model
initialModel =
    { actiune = initialActiune
    , ui =
        { select = Select3.initialModel initialActiune valuesWithLabels
        }
    }


type Msg
    = SetActiune (Select3.Msg Actiune)


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetActiune select3Msg ->
            receivePersoana model (Select3.update select3Msg model.ui.select)


receivePersoana : Model -> Select3.Model Actiune -> Model
receivePersoana ({ ui } as model) newSelect =
    { model
        | ui = { ui | select = newSelect }
        , actiune = Select3.selectedValue newSelect
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "Actiune" ]
        , dropdown model

        -- , fields actiune
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select3.view "Actiune:" model.ui.select |> map SetActiune



--
-- fields : Model ->  Html msg
-- fields actiune  =
--     case actiune of
--         IncheiereIntentare incheiereIntentare ->
--             IncheiereIntentare.view incheiereIntentare (\v cmd sub -> callback (IncheiereIntentare v) cmd sub)
--
--         IncheiereRefuz incheiereRefuz ->
--             IncheiereRefuz.view incheiereRefuz (\v cmd sub -> callback (IncheiereRefuz v) cmd sub)
