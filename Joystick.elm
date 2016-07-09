module Joystick
    exposing
        ( Model
        , update
        , model
        , view
        )

import Html exposing (Html, div, button)
import Html.App as Html


-- import Html.Events exposing (onClick)

import Debug exposing (log)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onMouseDown, onMouseUp)
import Color exposing (..)


-- MODEL


type alias Model =
    { position : Msg
    }



-- UPDATE


model : Model
model =
    { position = None
    }



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
        { model |
            position = msg
        }


-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ svg
            [ version "1.1"
            , x "0"
            , y "0"
            , viewBox "0 0 100 100"
            ]
            [ polygon
                [ fill (doBackground model Left)
                , points "0 0, 30 30, 30 70, 0 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                , onMouseDown Left
                , onMouseUp None
                ]
                []
            , polygon
                [ fill (doBackground model Up)
                , points "0 0, 30 30, 70 30, 100 0"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                , onMouseDown Up
                , onMouseUp None
                ]
                []
            , polygon
                [ fill (doBackground model Right)
                , points "100 0, 70 30, 70 70, 100 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                , onMouseDown Right
                , onMouseUp None
                ]
                []
            , polygon
                [ fill (doBackground model Down)
                , points "0 100, 30 70, 70 70, 100 100"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                , onMouseDown Down
                , onMouseUp None
                ]
                []
            , polygon
                [ fill (doBackground model None)
                , points "30 30, 70 30, 70 70, 30 70"
                , stroke "indianred"
                , strokeWidth (toString edgeRatio)
                , onMouseUp None
                ]
                []
            ]
        ]


doBackground : Model -> Msg -> String
doBackground model msg =
    if model.position == msg then
        "red"
    else
        "white"


edgeRatio : Float
edgeRatio =
    1.0
