module Main exposing (main)

import App as App
import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, div)


type alias Model =
    { app : App.Model
    }


type Msg
    = AppMsg App.Msg


init : Model
init =
    { app = App.defaultModel }


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    model


view : Model -> Html Msg
view model =
    let
        app =
            App.view model.app
    in
    div []
        [ ui
        , Html.map AppMsg app.topAppBar
        , ui
        ]


channelPanel : Element msg
channelPanel =
    column
        [ height fill
        , width <| fillPortion 1
        , Background.color <| rgb255 92 99 118
        , Font.color <| rgb255 255 255 255
        ]
        [ text "channels" ]


chatPanel : Element msg
chatPanel =
    column [ height fill, width <| fillPortion 5 ]
        [ text "chat2" ]


ui : Html msg
ui =
    layout [] <|
        row [ height fill, width fill ]
            [ channelPanel
            , chatPanel
            ]
