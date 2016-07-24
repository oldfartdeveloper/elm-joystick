module Joystick
    exposing
        ( Model
        , update
        , init
        , subscriptions
        , view
        )

{-| This module provides you with a control panel to provide mouse
clicks/touches to indicate direction.  Especially useful for
smart devices missing direction keys.

@docs setMinimumBackgroundFillDuration

-}

import Html exposing (Html, div, button)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onMouseDown, onMouseUp)
import Time exposing (Time, millisecond)


-- MODEL


type Direction
    = None
    | Left
    | Up
    | Right
    | Down


type alias Model =
    { position : Direction
    , backgroundCount : Int
    }



-- UPDATE


init : ( Model, Cmd Msg )
init =
    ( { position = None
      , backgroundCount = 0
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
    case msg of
        Tick newTime ->
            let
                bkgndCount =
                    model.backgroundCount
                        - 1
            in
                if bkgndCount <= 0 then
                    init
                else
                    ( { model
                        | backgroundCount = bkgndCount
                      }
                    , Cmd.none
                    )

        ActionNone ->
            ( { model
                | backgroundCount =
                    setMinimumBackgroundFillDuration
              }
            , Cmd.none
            )

        ActionLeft ->
            updatePosition model Left

        ActionUp ->
            updatePosition model Up

        ActionRight ->
            updatePosition model Right

        ActionDown ->
            updatePosition model Down


updatePosition : Model -> Direction -> ( Model, Cmd Msg )
updatePosition model direction =
    ( { model
        | position = direction
      }
    , Cmd.none
    )


{-| On Macintosh trackpad, tapping the pad (i.e. without
clicking it) is an almost immediate mouse down/up sequence
and most of the time you don't see the background flash
of the polygon you "clicked".  This initial count
connotates the number of Time ticks that must have
passed before the "depressed" fill color is reset.
-}
setMinimumBackgroundFillDuration : Int
setMinimumBackgroundFillDuration =
    2


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
                (setSvgAttributes model
                    "0 0, 30 30, 30 70, 0 100"
                    Left
                    ActionLeft
                )
                []
            , polygon
                (setSvgAttributes model
                    "0 0, 30 30, 70 30, 100 0"
                    Up
                    ActionUp
                )
                []
            , polygon
                (setSvgAttributes model
                    "100 0, 70 30, 70 70, 100 100"
                    Right
                    ActionRight
                )
                []
            , polygon
                (setSvgAttributes model
                    "0 100, 30 70, 70 70, 100 100"
                    Down
                    ActionDown
                )
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


setSvgAttributes :
    Model
    -> String
    -> Direction
    -> Msg
    -> List (Attribute Msg)
setSvgAttributes model svgPoints direction msg =
    [ fill (doBackground model direction)
    , points svgPoints
    , stroke borderColor
    , strokeWidth (toString edgeRatio)
    , onMouseDown msg
    , onMouseUp ActionNone
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


borderColor : String
borderColor =
    "indianred"
