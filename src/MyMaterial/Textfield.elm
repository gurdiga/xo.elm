module MyMaterial.Textfield exposing (view)

import Html exposing (Html, div, label, input, text)
import Html.Attributes exposing (class, type_)


type alias Input a msg =
    { labelText : String
    , defaultValue : a
    , callback : a -> msg
    }


view : Input a msg -> Html msg
view { labelText, defaultValue, callback } =
    div [ class "mdc-textfield" ]
        [ input [ type_ "text", class "mdc-textfield__input" ] []

        -- TODO: get the label to float on focus
        -- it seems to need mdc.textfield.MDCTextfield.attachTo('.mdc-textfield');
        , label [ class "mdc-textfield__label" ] [ text labelText ]
        , div [ class "mdc-textfield__bottom-line" ] []
        ]
