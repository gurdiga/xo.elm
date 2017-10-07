module MyMaterial.Button exposing (view)

import Html exposing (Html, button, span, i, text)
import Html.Attributes exposing (class)
import MyMaterial.Attributes exposing (mdcInit)


view : List (Html.Attribute msg) -> List (Html msg) -> Html msg
view attributes children =
    button
        ([ class "mdc-button mdc-button--raised", mdcInit "MDCRipple" ] ++ attributes)
        ([ i [ class "material-icons mdc-button__icon" ] [ text "description" ] ] ++ children)
