module Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios exposing (DeclaratieContractNonLitigios, newValue)


type DeclaratieContractNonLitigios a
    = DeclaratieContractNonLitigios a


newValue : a -> DeclaratieContractNonLitigios a
newValue contract =
    DeclaratieContractNonLitigios contract
