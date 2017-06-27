module Dosar.Temei.CerereCreditorIpotecă.DeclarațieContractNonLitigios exposing (DeclarațieContractNonLitigios, newValue)


type DeclarațieContractNonLitigios a
    = DeclarațieContractNonLitigios a


newValue : a -> DeclarațieContractNonLitigios a
newValue contract =
    DeclarațieContractNonLitigios contract
