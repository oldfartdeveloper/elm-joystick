module Joystick
    exposing
        ( Model
        , update
        , init
        , subscriptions
        , view
        )

import Html exposing (Html, div, button)
import Html.App as Html


-- import Html.Events exposing (onClick)

import Debug exposing (log)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, millisecond)
import Svg.Events exposing (onMouseDown, onMouseUp)
import Color exposing (..)


-- MODEL


type Direction
    = None
    | Left
    | Up
    | Right
    | Down


type alias Model =
    { position : Direction
    }



-- UPDATE


init : ( Model, Cmd Msg )
init =
    ( { position = None
      }
    , Cmd.none
    )


-- UPDATE


type Msg
    = Tick Time
    | ActionNone
    | ActionLeft
    | ActionRight
    | ActionUp
    | ActionDown


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        dummy =
            log "Clicks" msg
    in
        case msg of
            Tick newTime ->
                ( model, Cmd.none )

            ActionNone ->
                ( { model
                    | position = None
                  }
                , Cmd.none
                )

            ActionLeft ->
                ( { model
                    | position = Left
                  }
                , Cmd.none
                )

            ActionUp ->
                ( { model
                    | position = Up
                  }
                , Cmd.none
                )

            ActionRight ->
                ( { model
                    | position = Right
                  }
                , Cmd.none
                )

            ActionDown ->
                ( { model
                    | position = Down
                  }
                , Cmd.none
                )


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (100 * millisecond) Tick



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
                , stroke borderColor
                , strokeWidth (toString edgeRatio)
                , onMouseDown ActionLeft
                , onMouseUp ActionNone
                ]
                []
            , polygon
                [ fill (doBackground model Up)
                , points "0 0, 30 30, 70 30, 100 0"
                , stroke borderColor
                , strokeWidth (toString edgeRatio)
                , onMouseDown ActionUp
                , onMouseUp ActionNone
                ]
                []
            , polygon
                [ fill (doBackground model Right)
                , points "100 0, 70 30, 70 70, 100 100"
                , stroke borderColor
                , strokeWidth (toString edgeRatio)
                , onMouseDown ActionRight
                , onMouseUp ActionNone
                ]
                []
            , polygon
                [ fill (doBackground model Down)
                , points "0 100, 30 70, 70 70, 100 100"
                , stroke borderColor
                , strokeWidth (toString edgeRatio)
                , onMouseDown ActionDown
                , onMouseUp ActionNone
                ]
                []
            , polygon
                [ fill (doBackground model None)
                , points "30 30, 70 30, 70 70, 30 70"
                , stroke borderColor
                , strokeWidth (toString edgeRatio)
                , onMouseUp ActionNone
                ]
                []
            ]
        ]


doBackground : Model -> Direction -> String
doBackground model direction =
    if model.position == direction then
        "red"
    else
        "white"


edgeRatio : Float
edgeRatio =
    1.0


borderColor =
    "indianred"
