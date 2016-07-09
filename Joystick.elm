module Joystick
    exposing
        ( Model
        , update
        , model
        , view
        )

import Html exposing (Html, div, button)
import Html.App as Html
import Html.Events exposing (onClick)
import Debug exposing (log)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Color exposing (..)


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
        [ svg
            [ onClick Left
            , version "1.1"
            , x "0"
            , y "0"
            , viewBox "0 0 100 100"
            ]
            [ polygon
                [ fill "white"
                , points "0 0, 30 30, 30 70, 0 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []
            , polygon
                [ fill "white"
                , points "0 0, 30 30, 70 30, 100 0"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []
            , polygon
                [ fill "white"
                , points "100 0, 70 30, 70 70, 100 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []
            , polygon
                [ fill "white"
                , points "0 100, 30 70, 70 70, 100 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []
            , polygon
                [ fill "red"
                , points "30 30, 70 30, 70 70, 30 70"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                ]
                []
            ]
        ]


edgeRatio : Float
edgeRatio =
    4.0
