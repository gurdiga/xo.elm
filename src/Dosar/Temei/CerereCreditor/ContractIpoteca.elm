module Dosar.Temei.CerereCreditor.ContractIpoteca exposing (ContractIpoteca, empty, view)

import Html exposing (Html, fieldset, legend, li, text, ul)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.Fields exposing (largeTextField, moneyField, textField)


type alias ContractIpoteca =
    { obiect : String
    , valoareBunDePiata : Money
    , valoareBunDeInlocuire : Money
    , valoareDeBazaCreanta : Money
    , note : String
    }


empty : ContractIpoteca
empty =
    { obiect = ""
    , valoareBunDePiata = Money 0 MDL
    , valoareBunDeInlocuire = Money 0 MDL
    , valoareDeBazaCreanta = Money 0 MDL
    , note = ""
    }


view : ContractIpoteca -> (ContractIpoteca -> msg) -> Html msg
view contractIpoteca callback =
    fieldset []
        [ legend [] [ text "ContractIpoteca" ]
        , ul []
            [ li [] [ largeTextField "Obiectul ipotecii:" contractIpoteca.obiect (\v -> callback { contractIpoteca | obiect = v }) ]
            , li []
                [ moneyField "Valoarea de piaţa a bunului:"
                    contractIpoteca.valoareBunDePiata
                    (\v -> callback { contractIpoteca | valoareBunDePiata = v })
                ]
            , li []
                [ moneyField "Valoarea de inlocuire a bunului:"
                    contractIpoteca.valoareBunDeInlocuire
                    (\v -> callback { contractIpoteca | valoareBunDeInlocuire = v })
                ]
            , li []
                [ moneyField "Valoarea de baza a creanţei garantate:"
                    contractIpoteca.valoareDeBazaCreanta
                    (\v -> callback { contractIpoteca | valoareDeBazaCreanta = v })
                ]
            , li [] [ largeTextField "Note:" contractIpoteca.note (\v -> callback { contractIpoteca | note = v }) ]
            ]
        ]
