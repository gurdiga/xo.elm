module MyMaterial.Attributes
    exposing
        ( ariaLabel
        , mdcInit
        )

import Html exposing (Html)
import Html.Attributes exposing (attribute)


ariaLabel : String -> Html.Attribute msg
ariaLabel value =
    attribute "aria-label" value


mdcInit : String -> Html.Attribute msg
mdcInit value =
    attribute "data-mdc-auto-init" value
