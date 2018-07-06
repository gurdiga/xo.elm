module Dosar.Actiune.IncheiereIntentare exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere as RezultatIncercareConciliere exposing (RezultatIncercareConciliere)
-- import Utils.RichTextEditor as RichTextEditor

import Html.Styled exposing (Html, button, div, fieldset, h1, legend, map, p, text)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField


type alias Model =
    { html : String
    , borderouDeCalcul : String
    , copieIncheiere : DocumentScanat
    , termenConciliere : MyDate.Model

    -- , rezultatIncercareConciliere : RezultatIncercareConciliere
    }


initialModel : Model
initialModel =
    { html = ""
    , borderouDeCalcul = ""
    , copieIncheiere = DocumentScanat.empty
    , termenConciliere = MyDate.empty

    -- , rezultatIncercareConciliere = RezultatIncercareConciliere.empty
    }


view : Model -> Html Msg
view (data as incheiereIntentare) =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]

        -- , RichTextEditor.view
        --     { buttonLabel = "Editează"
        --     , content = template data
        --     , onOpen = callback incheiereIntentare
        --     , onResponse = \s -> c { data | html = s }
        --     }
        -- , RichTextEditor.view
        --     { buttonLabel = "Formează borderou de calcul"
        --     , content = borderouDeCalculTemplate data
        --     , onOpen = callback incheiereIntentare
        --     , onResponse = \s -> c { data | borderouDeCalcul = s }
        --     }
        -- , DocumentScanat.view
        --     { labelText = "Copia încheierii:"
        --     , documentScanat = data.copieIncheiere
        --     , callback = \v -> c { data | copieIncheiere = v }
        --     }
        , -- LATER: Check that the date is reasonable? In the near future?
          DateField.view "Termen de conciliere:" data.termenConciliere |> map SetTermenConciliere

        -- , RezultatIncercareConciliere.view
        --     data.rezultatIncercareConciliere
        --     (\v -> callback (Model { data | rezultatIncercareConciliere = v }))
        ]


template : Model -> List (Html Msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| data ]
    ]


borderouDeCalculTemplate : Model -> List (Html Msg)
borderouDeCalculTemplate data =
    -- TODO: find the real template
    [ h1 [] [ text "Borderou de calcul pentru cheltuielile de intentare" ]
    , p [] [ text <| toString <| data ]
    ]


type Msg
    = SetTermenConciliere DateField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTermenConciliere dateFieldMsg ->
            { model | termenConciliere = DateField.update dateFieldMsg model.termenConciliere }
