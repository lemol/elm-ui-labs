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
            , link
                [ Font.color <| rgb255 56 151 240
                ]
                { url = "#", label = text "conta já existente" }
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
        [ formRow
            [ commonInput [] 1 "Nome completo" ]
        , formRow
            [ commonInput [] 1 "Code"
            , commonInput [] 3 "Telefone"
            ]
        , formRow
            [ commonNewPassword [] 1 "Palavra passe"
            ]
        , paragraph []
            [ text "Ao criar uma conta aceita "
            , link [ Font.color <| rgb255 56 151 240 ] { url = "#", label = text "os nossos termos e condições" }
            ]
        , row []
            [ Input.button [] { onPress = Nothing, label = text "CRIAR CONTA" } ]
        ]


formRow children =
    row
        [ spacing 8
        , width fill
        ]
        children


commonControlsAttrs : List (Attribute msg)
commonControlsAttrs =
    [ spacing 12
    , Border.rounded 100
    , Border.width 0
    , Background.color <| rgb255 241 243 244
    ]


commonInput : List (Attribute msg) -> Int -> String -> Element msg
commonInput attrs portion label =
    Input.text
        (commonControlsAttrs
            ++ [ width <| fillPortion portion
               ]
            ++ attrs
        )
        { onChange = Debug.todo, text = "", placeholder = Just <| Input.placeholder [] (text label), label = Input.labelHidden label }


commonNewPassword : List (Attribute msg) -> Int -> String -> Element msg
commonNewPassword attrs portion label =
    Input.newPassword
        (commonControlsAttrs
            ++ [ width <| fillPortion portion
               ]
            ++ attrs
        )
        { onChange = Debug.todo, text = "", placeholder = Just <| Input.placeholder [] (text label), label = Input.labelHidden label, show = False }



----------------------


view2 : Model -> Html Msg
view2 model =
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
