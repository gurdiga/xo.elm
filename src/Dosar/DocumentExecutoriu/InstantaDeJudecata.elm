module Dosar.DocumentExecutoriu.InstantaDeJudecata exposing (InstantaDeJudecata, newValue, view)

import Html exposing (Html, label, text)
import Widgets.Select as Select


type InstantaDeJudecata
    = CurteaSupremaDeJustitie
    | CurteaDeApelChisinau
    | CurteaDeApelBalti
    | CurteaDeApelCahul
    | CurteaDeApelComrat
    | JudecatoriaBalti
    | JudecatoriaAneniiNoi
    | JudecatoriaCahul
    | JudecatoriaCauseni
    | JudecatoriaCimislia
    | JudecatoriaComrat
    | JudecatoriaCriuleni
    | JudecatoriaDrochia
    | JudecatoriaEdinet
    | JudecatoriaHincesti
    | JudecatoriaOrhei
    | JudecatoriaSoroca
    | JudecatoriaStraseni
    | JudecatoriaUngheni
    | JudecatoriaChisinau


newValue : InstantaDeJudecata
newValue =
    CurteaSupremaDeJustitie


view : InstantaDeJudecata -> (InstantaDeJudecata -> msg) -> Html msg
view instantaDeJudecata callback =
    label []
        [ text "Instanța de judecată:"
        , Select.fromValuesWithLabels valuesWithLabels newValue callback
        ]


valuesWithLabels : List ( InstantaDeJudecata, String )
valuesWithLabels =
    [ ( CurteaSupremaDeJustitie, "Curtea Supremă de Justiție" )
    , ( CurteaDeApelChisinau, "Curtea de Apel Chișinău" )
    , ( CurteaDeApelBalti, "Curtea de Apel Bălți" )
    , ( CurteaDeApelCahul, "Curtea de Apel Cahul" )
    , ( CurteaDeApelComrat, "Curtea de Apel Comrat" )
    , ( JudecatoriaBalti, "Judecătoria Bălți" )
    , ( JudecatoriaAneniiNoi, "Judecătoria Anenii Noi" )
    , ( JudecatoriaCahul, "Judecătoria Cahul" )
    , ( JudecatoriaCauseni, "Judecătoria Căușeni" )
    , ( JudecatoriaCimislia, "Judecătoria Cimișlia" )
    , ( JudecatoriaComrat, "Judecătoria Comrat" )
    , ( JudecatoriaCriuleni, "Judecătoria Criuleni" )
    , ( JudecatoriaDrochia, "Judecătoria Drochia" )
    , ( JudecatoriaEdinet, "Judecătoria Edineț" )
    , ( JudecatoriaHincesti, "Judecătoria Hîncești" )
    , ( JudecatoriaOrhei, "Judecătoria Orhei" )
    , ( JudecatoriaSoroca, "Judecătoria Soroca" )
    , ( JudecatoriaStraseni, "Judecătoria Strășeni" )
    , ( JudecatoriaUngheni, "Judecătoria Ungheni" )
    , ( JudecatoriaChisinau, "Judecătoria Chișinău" )
    ]
