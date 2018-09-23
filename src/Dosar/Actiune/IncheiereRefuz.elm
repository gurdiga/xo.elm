module Dosar.Actiune.IncheiereRefuz exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereRefuz.CauzaRefuz as CauzaRefuz
import Html exposing (Html, button, div, fieldset, h1, legend, map, p, text)
import Widgets.RichTextEditor3 as RichTextEditor3
import Widgets.Select as Select


type alias Model =
    { cauza : CauzaRefuz.Model
    , content : String
    }


initialModel : Model
initialModel =
    { cauza = CauzaRefuz.initialModel
    , content = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereRefuz" ]
        , dropdown model.cauza
        , document model.content
        ]


dropdown : CauzaRefuz.Model -> Html Msg
dropdown cauza =
    Select.view
        { label = "Cauza refuzului:"
        , valuesWithLabels = CauzaRefuz.valuesWithLabels
        , defaultValue = cauza
        , onOptionSelected = SetCauza
        }


document : String -> Html Msg
document content =
    RichTextEditor3.view "Formează borderou de calcul" content SetContent


type Msg
    = SetCauza CauzaRefuz.Model
    | SetContent String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCauza v ->
            { model | cauza = v }

        SetContent v ->
            { model | content = v }
