module Main exposing (..)

import Html.App as Html
import Joystick exposing (..)


main : Program Never
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
