module Utils.MyNumber exposing (format)

import Native.Intl


format : Float -> String
format n =
    Native.Intl.formatMoneyAmount "ro-MD" n
