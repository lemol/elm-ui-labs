module Element.Utils exposing (basicLink, input, newPassword, row1, row2, textLink)

import Element exposing (Attribute, Element, el, fill, fillPortion, link, mouseOver, rgb255, row, spacing, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


commonControlsAttrs : List (Attribute msg)
commonControlsAttrs =
    [ spacing 12
    , Border.rounded 100
    , Border.width 0
    , Background.color <| rgb255 241 243 244
    ]


row1 : List (Attribute msg) -> Element msg -> Element msg
row1 attrs =
    el
        (width fill :: attrs)


row2 : List (Attribute msg) -> ( Int, Element msg ) -> ( Int, Element msg ) -> Element msg
row2 attrs ( size1, el1 ) ( size2, el2 ) =
    row
        (width fill :: attrs)
        [ el [ width <| fillPortion size1 ] el1
        , el [ width <| fillPortion size2 ] el2
        ]


input : List (Attribute msg) -> String -> Element msg
input attrs label =
    Input.text
        (commonControlsAttrs
            ++ attrs
        )
        { onChange = Debug.todo, text = "", placeholder = Just <| Input.placeholder [] (text label), label = Input.labelHidden label }


newPassword : List (Attribute msg) -> String -> Element msg
newPassword attrs label =
    Input.newPassword
        (commonControlsAttrs
            ++ attrs
        )
        { onChange = Debug.todo, text = "", placeholder = Just <| Input.placeholder [] (text label), label = Input.labelHidden label, show = False }


basicLink : List (Attribute msg) -> String -> Element msg -> Element msg
basicLink attrs url label =
    link
        (Font.color (rgb255 56 151 240) :: attrs)
        { url = url, label = label }


textLink : List (Attribute msg) -> String -> String -> Element msg
textLink attrs url label =
    basicLink attrs url (text label)
