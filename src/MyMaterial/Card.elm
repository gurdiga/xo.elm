module MyMaterial.Card exposing (view)

import Html exposing (Html, section, h1, h2, div, text)
import Html.Attributes exposing (class)


type alias Input msg =
    { title : String
    , maybeSubTitle : Maybe String
    , actionButtons : List (Html msg)
    , children : List (Html msg)
    }


view : Input msg -> Html msg
view { title, maybeSubTitle, actionButtons, children } =
    div [ class "mdc-card" ]
        [ headView title maybeSubTitle
        , contentView children
        , footerView actionButtons
        ]


headView : String -> Maybe String -> Html msg
headView title maybeSubTitle =
    section [ class "mdc-card__primary" ]
        [ h1 [ class "mdc-card__title mdc-card__title--large" ] [ text title ]
        , case maybeSubTitle of
            Just subTitle ->
                h2 [ class "mdc-card__subtitle" ] [ text subTitle ]

            Nothing ->
                text ""
        ]


contentView : List (Html msg) -> Html msg
contentView children =
    section [ class "mdc-card__supporting-text" ] children


footerView : List (Html msg) -> Html msg
footerView actionButtons =
    section [ class "mdc-card__actions" ] actionButtons
