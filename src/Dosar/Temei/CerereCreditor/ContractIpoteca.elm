module Dosar.Temei.CerereCreditor.ContractIpoteca exposing (Model, Msg, empty, update, view)

import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.LargeTextField as LargeTextField


type Msg
    = SetObiect LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetObiect largeTextFieldMsg ->
            { model | obiect = Debug.log "new obiect" (LargeTextField.update largeTextFieldMsg model.obiect) }


type alias Model =
    { obiect : String
    , valoareBunDePiata : Money
    , valoareBunDeInlocuire : Money
    , valoareDeBazaCreanta : Money
    , note : String
    }


empty : Model
empty =
    { obiect = ""
    , valoareBunDePiata = Money 0 MDL
    , valoareBunDeInlocuire = Money 0 MDL
    , valoareDeBazaCreanta = Money 0 MDL
    , note = ""
    }


view : Model -> Html Msg
view contractIpoteca =
    fieldset []
        [ legend [] [ text "ContractIpoteca" ]
        , ul []
            [ li [] [ LargeTextField.view "Obiectul ipotecii:" contractIpoteca.obiect |> map SetObiect ]

            -- , li []
            --     [ moneyField "Valoarea de piaţa a bunului:"
            --         contractIpoteca.valoareBunDePiata
            --         (\v -> callback { contractIpoteca | valoareBunDePiata = v })
            --     ]
            -- , li []
            --     [ moneyField "Valoarea de inlocuire a bunului:"
            --         contractIpoteca.valoareBunDeInlocuire
            --         (\v -> callback { contractIpoteca | valoareBunDeInlocuire = v })
            --     ]
            -- , li []
            --     [ moneyField "Valoarea de baza a creanţei garantate:"
            --         contractIpoteca.valoareDeBazaCreanta
            --         (\v -> callback { contractIpoteca | valoareDeBazaCreanta = v })
            --     ]
            -- , li [] [ largeTextField "Note:" contractIpoteca.note (\v -> callback { contractIpoteca | note = v }) ]
            ]
        ]
