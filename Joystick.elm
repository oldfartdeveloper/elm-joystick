module Joystick
    exposing
        ( Model
        , update
        , model
        , view
        )

import Html exposing (Html, div, button, text)
import Html.App as Html
import Html.Events exposing (onClick)
import Debug exposing (log)


-- MODEL


type alias Model =
    { position : Msg
    }


-- UPDATE


model : Model
model =
    { position = None }



-- UPDATE


type Msg
    = None
    | Left
    | Right
    | Up
    | Down


update : Msg -> Model -> Model
update msg model =
    let
        dummy =
            log "Clicks" msg
    in
        { model
            | position = msg
        }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Left ] [ text "Left" ]
        , button [ onClick Up ] [ text "Up" ]
        , button [ onClick Right ] [ text "Right" ]
        , button [ onClick Down ] [ text "Down" ]
        ]
