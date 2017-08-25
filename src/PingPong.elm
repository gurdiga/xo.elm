port module PingPong exposing (view)

import Html exposing (Html, button, text)
import Html.Events exposing (onClick)


view : (String -> Cmd msg -> Sub msg -> msg) -> Html msg
view callback =
    let
        cmd =
            ping "Ping!"

        pongCallback : String -> msg
        pongCallback s =
            Debug.log "pongCallback" (callback s Cmd.none Sub.none)
    in
        button
            [ onClick
                (callback "sending ping"
                    cmd
                    (pong pongCallback)
                )
            ]
            [ text "Ping me!" ]


port ping : String -> Cmd msg


port pong : (String -> msg) -> Sub msg
