module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara
import Html.Styled exposing (Html, fieldset, legend, p, text)
import Widgets.DateField as DateField
import Widgets.Fields exposing (unlabeledLargeTextField, unlabeledMoneyField)
import Widgets.Table as Table


type Msg
    = Set


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
            model


type Model
    = Model (List Int) --InregistrareEvidentaFinanciara


initialModel : Model
initialModel =
    Model []


view : Model -> Html Msg
view extraseEvidentaFinanciara =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , Table.view
            { recordList = data extraseEvidentaFinanciara
            , callback = callback << fromData
            , columns =
                [ ( "Data", \r c -> MyDate.viewUnlabeled r.data (\v -> c { r | data = v }) )
                , ( "Suma", \r c -> unlabeledMoneyField r.suma (\v -> c { r | suma = v }) )
                , ( "Note", \r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v }) )
                ]
            , emptyView = emptyView
            , empty = InregistrareEvidentaFinanciara.data InregistrareEvidentaFinanciara.empty
            }
        ]


data : Model -> List InregistrareEvidentaFinanciara.Data
data (Model list) =
    List.map InregistrareEvidentaFinanciara.data list


fromData : List InregistrareEvidentaFinanciara.Data -> Model
fromData =
    Model << List.map InregistrareEvidentaFinanciara


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt înregistrări." ]
