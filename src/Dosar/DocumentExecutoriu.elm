module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, newValue, view)

import Html exposing (Html, fieldset, legend, br, text)
import MyDate exposing (MyDate)
import Utils.List as ListUtils
import Widgets.Fields exposing (largeTextField)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.DocumentExecutoriu.Pricina as Pricina exposing (Pricina)
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata exposing (InstantaDeJudecata)


type DocumentExecutoriu
    = DocumentExecutoriu Data


type alias Data =
    { instantaEmitatoare : InstantaDeJudecata
    , pricina : Pricina
    , dataPronuntareHotarire : MyDate
    , dispozitivul : String
    , dataRamineriiDefinitive : MyDate
    , debitori : List Persoana
    }


newValue : DocumentExecutoriu
newValue =
    DocumentExecutoriu
        { instantaEmitatoare = InstantaDeJudecata.newValue
        , pricina = Pricina.newValue
        , dataPronuntareHotarire = MyDate.newValue
        , dispozitivul = ""
        , dataRamineriiDefinitive = MyDate.newValue
        , debitori = [ Persoana.newValue ]
        }


view : DocumentExecutoriu -> (DocumentExecutoriu -> msg) -> Html msg
view documentExecutoriu callback =
    let
        (DocumentExecutoriu data) =
            documentExecutoriu

        c data =
            callback (DocumentExecutoriu data)
    in
        fieldset []
            [ legend [] [ text "DocumentExecutoriu" ]
            , InstantaDeJudecata.view data.instantaEmitatoare (\v -> c { data | instantaEmitatoare = v })
            , br [] []
            , Pricina.view data.pricina (\v -> c { data | pricina = v })
            , br [] []
            , MyDate.view "Data pronunțării hotărîrii:" data.dataPronuntareHotarire (\v -> c { data | dataPronuntareHotarire = v })
            , br [] []
            , largeTextField "Dispozitivul:" data.dispozitivul (\v -> c { data | dispozitivul = v })
            , br [] []
            , MyDate.view "Data rămînerii definitive:" data.dataRamineriiDefinitive (\v -> c { data | dataRamineriiDefinitive = v })
            , debitoriView data.debitori (\v -> c { data | debitori = v })
            ]


debitoriView : List Persoana -> (List Persoana -> msg) -> Html msg
debitoriView debitori callback =
    fieldset []
        ((legend [] [ text "Debitori" ])
            :: (List.indexedMap
                    (\i debitor ->
                        fieldset []
                            [ legend [] [ text (toString i) ]
                            , text (toString debitor)
                            , Persoana.view debitor (\v -> ListUtils.replace debitor i v)
                            ]
                    )
                    debitori
               )
        )
