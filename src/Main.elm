module Main exposing (main)

import Browser
import Css as Css
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Element.Utils exposing (input, newPassword, row1, row2, textLink)
import Html exposing (Html, div, img)
import Html.Attributes as HA
import Html.Styled as Styled
import Html.Styled.Attributes as StyledA


type alias Model =
    { hoverBox : Bool }


type Msg
    = NoOp
    | BoxHovered Bool


init : Model
init =
    { hoverBox = False }


main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        BoxHovered state ->
            { model | hoverBox = state }

        NoOp ->
            model


view : Model -> Html Msg
view model =
    layout [] <|
        row
            [ height fill
            , width fill
            , Background.color <| rgb255 240 240 240
            ]
            [ box model
            ]


box : Model -> Element Msg
box model =
    el
        [ centerX
        , centerY
        , padding 24
        , width (fill |> maximum 505)
        , baseFont
        , Background.color <| rgb255 255 255 255
        , Border.rounded 16
        , Border.glow (rgba255 0 0 0 0.3) 6
        , mouseOver [ Border.glow (rgba255 0 0 0 0.3) 12 ]
        ]
    <|
        column
            [ width fill ]
            [ boxHeader
            , boxBody
            ]


baseFont =
    Font.family <|
        List.map Font.typeface
            [ "-apple-system"
            , "BlinkMacSystemFont"
            , "Segoe UI"
            , "Roboto"
            , "Helvetica Neue"
            , "Arial"
            , "sans-serif"
            , "Apple Color Emoji"
            , "Segoe UI Emoji"
            , "Segoe UI Symbol"
            ]


boxHeader : Element msg
boxHeader =
    column
        [ padding 16, spacing 8 ]
        [ el
            [ Font.size 12
            ]
            (text "CRIE A SUA CONTA")
        , paragraph
            [ Font.size 14
            ]
            [ text "Ou faça o login com a sua "
            , textLink
                []
                "#"
                "conta já existente"
            ]
        ]


boxBody : Element msg
boxBody =
    column
        [ width fill
        , padding 16
        , spacing 16
        , Font.size 16
        ]
        [ row1
            []
            (input [] "Nome completo")
        , row2
            [ spacing 8 ]
            ( 1, input [] "Code" )
            ( 3, input [] "Telefone" )
        , row1 []
            (input [] "Palavra passe")
        , paragraph []
            [ text "Ao criar uma conta aceita "
            , link [ Font.color <| rgb255 56 151 240 ] { url = "#", label = text "os nossos termos e condições" }
            ]
        , row []
            [ Input.button [] { onPress = Nothing, label = text "CRIAR CONTA" } ]
        ]
