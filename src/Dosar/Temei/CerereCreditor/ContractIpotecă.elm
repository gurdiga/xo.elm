module Dosar.Temei.CerereCreditor.ContractIpotecă exposing (ContractIpotecă, newValue, view)

import Html exposing (Html, fieldset, ul, li, legend, text)
import Widgets.Fields exposing (textField, largeTextField, moneyField)
import Money exposing (Money(..), Currency(..))


type alias ContractIpotecă =
    { obiect : String
    , valoareBunDePiață : Money
    , valoareBunDeÎnlocuire : Float
    , valoareDeBazăCreanță : Float
    , note : String
    }


newValue : ContractIpotecă
newValue =
    { obiect = ""
    , valoareBunDePiață = Money.newValue
    , valoareBunDeÎnlocuire = 0
    , valoareDeBazăCreanță = 0
    , note = ""
    }


view : ContractIpotecă -> (ContractIpotecă -> msg) -> Html msg
view contractIpotecă callback =
    fieldset []
        [ legend [] [ text "ContractIpotecă" ]
        , ul []
            [ li [] [ largeTextField "Obiectul ipotecii:" contractIpotecă.obiect (\v -> callback { contractIpotecă | obiect = v }) ]
            , li []
                [ moneyField "Valoarea de piaţă a bunului:"
                    (Money.amount contractIpotecă.valoareBunDePiață)
                    (\v -> callback { contractIpotecă | valoareBunDePiață = (Money v MDL) })
                ]
            , li []
                [ moneyField "Valoarea de înlocuire a bunului:"
                    contractIpotecă.valoareBunDeÎnlocuire
                    (\v -> callback { contractIpotecă | valoareBunDeÎnlocuire = v })
                ]
            , li []
                [ moneyField "Valoarea de bază a creanţei garantate:"
                    contractIpotecă.valoareDeBazăCreanță
                    (\v -> callback { contractIpotecă | valoareDeBazăCreanță = v })
                ]
            , li [] [ largeTextField "Note" contractIpotecă.note (\v -> callback { contractIpotecă | note = v }) ]
            ]
        ]
