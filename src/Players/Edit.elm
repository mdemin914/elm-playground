module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Players.Models exposing (..)
import Players.Messages exposing (..)
import Html.Events exposing (onClick)


view : Player -> Html Msg
view model =
    div []
        [ form model
        ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text ("Name: " ++ player.name) ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-1 h2 bold" ] []
        , div [ class "col col-5" ]
            [ span [ class "h2 bold" ] [ text ("Level: " ++ (toString player.level)) ]
            , div []
                [ btnLevelDecrease player
                , btnLevelIncrease player
                ]
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id -1) ]
        [ i [ class "fa fa-minus-circle" ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    a [ class "btn ml1 h1", onClick (ChangeLevel player.id 1) ]
        [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    button
        [ class "btn regular"
        , onClick ShowPlayers
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
