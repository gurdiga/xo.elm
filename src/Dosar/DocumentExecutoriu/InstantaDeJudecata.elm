module Dosar.DocumentExecutoriu.InstantaDeJudecata exposing (Model, initialModel, valuesWithLabels)


type Model
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


initialModel : Model
initialModel =
    CurteaSupremaDeJustitie


valuesWithLabels : List ( Model, String )
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
