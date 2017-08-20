module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, empty, view)

import Html exposing (Html, fieldset, legend, div, button, br, text)
import Html.Events exposing (onClick)
import MyDate exposing (MyDate)
import Utils.List as ListUtils
import Widgets.Fields exposing (largeTextField)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.DocumentExecutoriu.Pricina as Pricina exposing (Pricina)
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata exposing (InstantaDeJudecata)
import Dosar.DocumentExecutoriu.DocumenteAplicareMasuriAsigurare as DocumenteAplicareMasuriAsigurare exposing (DocumenteAplicareMasuriAsigurare)


type DocumentExecutoriu
    = DocumentExecutoriu Data


type alias Data =
    { instantaEmitatoare : InstantaDeJudecata
    , pricina : Pricina
    , dataPronuntareHotarire : MyDate
    , dispozitivul : String
    , dataRamineriiDefinitive : MyDate
    , debitori : List Persoana
    , dataEliberarii : MyDate
    , documenteAplicareMasuriAsigurare : DocumenteAplicareMasuriAsigurare
    , mentiuniPrivindPatrundereaFortata : String
    , note : String
    }


empty : DocumentExecutoriu
empty =
    DocumentExecutoriu
        { instantaEmitatoare = InstantaDeJudecata.empty
        , pricina = Pricina.empty
        , dataPronuntareHotarire = MyDate.empty
        , dispozitivul = ""
        , dataRamineriiDefinitive = MyDate.empty
        , debitori = [ Persoana.empty ]
        , dataEliberarii = MyDate.empty
        , documenteAplicareMasuriAsigurare = DocumenteAplicareMasuriAsigurare.empty
        , mentiuniPrivindPatrundereaFortata = ""
        , note = ""
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
            , MyDate.view "Data eliberării:" data.dataEliberarii (\v -> c { data | dataEliberarii = v })
            , DocumenteAplicareMasuriAsigurare.view
                data.documenteAplicareMasuriAsigurare
                (\v -> c { data | documenteAplicareMasuriAsigurare = v })
            , largeTextField "Mențiuni privind autorizarea pătrunderii forțate:"
                data.mentiuniPrivindPatrundereaFortata
                (\v -> c { data | mentiuniPrivindPatrundereaFortata = v })
            , br [] []
            , largeTextField "Note:" data.note (\v -> c { data | note = v })
            ]


debitoriView : List Persoana -> (List Persoana -> msg) -> Html msg
debitoriView debitori callback =
    fieldset []
        ([ legend [] [ text "Debitori" ] ]
            ++ List.indexedMap
                (\i debitor ->
                    Persoana.view debitor (\v -> callback (ListUtils.replace debitori i v))
                )
                debitori
            ++ [ button [ onClick (callback (debitori ++ [ Persoana.empty ])) ] [ text "+" ] ]
        )
