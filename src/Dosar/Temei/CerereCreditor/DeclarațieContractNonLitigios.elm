module Dosar.Temei.CerereCreditor.DeclarațieContractNonLitigios exposing (DeclarațieContractNonLitigios, newValue)


type DeclarațieContractNonLitigios a
    = DeclarațieContractNonLitigios a


newValue : a -> DeclarațieContractNonLitigios a
newValue contract =
    DeclarațieContractNonLitigios contract
