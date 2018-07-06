module Utils.RichTextEditor2 exposing (Model, Msg, initialModel, update, view)

import Html.Styled exposing (Html, fieldset, label, legend, map, text, textarea)
import Html.Styled.Attributes exposing (value)
import Html.Styled.Events exposing (onInput)


type alias Model =
    { text : String
    }


initialModel : Model
initialModel =
    { text = "" }


view : String -> Model -> Html Msg
view labelText model =
    fieldset []
        [ legend [] [ text "RichTextEditor2" ]
        , label []
            [ text labelText
            , textarea [ onInput SetText, value model.text ] []
            ]
        ]


type Msg
    = SetText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetText string ->
            { model | text = string }
