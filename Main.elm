module Main exposing (..)

import Html.App as Html
import Joystick exposing (..)


main =
    Html.beginnerProgram
        { model = model
        , view = view
        , update = update
--        , subscriptions = subscriptions
        }
