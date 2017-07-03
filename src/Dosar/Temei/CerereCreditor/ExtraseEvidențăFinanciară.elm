module Dosar.Temei.CerereCreditor.ExtraseEvidențăFinanciară exposing (ExtraseEvidențăFinanciară, newValue, view)

import Html exposing (Html, fieldset, legend, text)
import Dosar.Temei.CerereCreditor.ÎnregistrareEvidențăFinanciară as ÎnregistrareEvidențăFinanciară exposing (ÎnregistrareEvidențăFinanciară)


type ExtraseEvidențăFinanciară
    = ExtraseEvidențăFinanciară (List ÎnregistrareEvidențăFinanciară)


newValue : ExtraseEvidențăFinanciară
newValue =
    ExtraseEvidențăFinanciară [ ÎnregistrareEvidențăFinanciară.newValue ]


view : ExtraseEvidențăFinanciară -> (ExtraseEvidențăFinanciară -> msg) -> Html msg
view extraseEvidențăFinanciară callback =
    fieldset []
        [ legend [] [ text "ExtraseEvidențăFinanciară" ]
        , text (toString extraseEvidențăFinanciară)
        ]
