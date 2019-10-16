module Main exposing (main)

import Browser
import Css as Css
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html, div, img)
import Html.Attributes as HA
import Html.Styled as Styled
import Html.Styled.Attributes as StyledA


type alias Model =
    Int


type Msg
    = Nop


init : Model
init =
    0


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
    layout [] <|
        column
            [ height fill, width fill ]
            [ header
            , body
            , footer
            ]


header : Element msg
header =
    let
        url =
            Just "https://lh3.googleusercontent.com/-GV9ojxr4eVk/AAAAAAAAAAI/AAAAAAAAALI/syV20LUzuvI/photo.jpg"
    in
    row
        [ height <| px 48
        , width fill
        , Background.color <| rgb255 92 99 11
        ]
        [ el
            [ alignRight, padding 4 ]
            (avatar url "LM")
        ]


avatar : Maybe String -> String -> Element msg
avatar src alt =
    case src of
        Just srcUrl ->
            html <|
                Styled.toUnstyled <|
                    Styled.img
                        [ StyledA.src srcUrl
                        , StyledA.alt alt
                        , StyledA.css
                            [ Css.width (Css.px 32)
                            , Css.height (Css.px 32)
                            , Css.borderRadius (Css.pct 50)
                            ]
                        ]
                        []

        Nothing ->
            el
                [ width <| px 32
                , height <| px 32
                , Border.rounded 50
                , Background.color <| rgb255 15 69 11
                ]
            <|
                el
                    [ centerX, centerY, Font.size 16 ]
                    (text alt)


body : Element msg
body =
    row
        [ centerY
        , height fill
        , width fill
        , padding 10
        , Background.color <| rgb255 92 99 118
        , Font.color <| rgb255 255 255 255
        ]
        [ searchBox "ok" Debug.todo ]


searchBox : String -> (String -> msg) -> Element msg
searchBox value onChange =
    Input.text
        [ width <| fillPortion 4
        , Border.glow (rgb255 200 200 200) 4
        , Border.rounded 10
        , Border.solid
        , Border.color (rgb255 180 180 180)
        ]
        { text = value, onChange = onChange, placeholder = Nothing, label = Input.labelHidden "" }


footer : Element msg
footer =
    row
        [ width fill, height <| px 20, Background.color <| rgb255 55 84 10 ]
        [ text "(c) 2019" ]
