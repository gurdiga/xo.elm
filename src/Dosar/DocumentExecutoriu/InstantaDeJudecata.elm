module Dosar.DocumentExecutoriu.InstantaDeJudecata exposing (InstantaDeJudecata, empty, view)

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


empty : InstantaDeJudecata
empty =
    CurteaSupremaDeJustitie


view : InstantaDeJudecata -> (InstantaDeJudecata -> msg) -> Html msg
view instantaDeJudecata callback =
    Select.view "Instanța de judecată:" valuesWithLabels empty callback


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
