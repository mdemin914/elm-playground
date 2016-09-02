module Components.Nav exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Messages exposing (..)
import Html.Events exposing (onClick)


nav : Html.Html Msg
nav =
    div
        [ class "clearfix mb2 white bg-black" ]
        [ div
            [ class "left p2"
            , Html.Attributes.style [ ( "cursor", "pointer" ) ]
            , onClick Messages.PlayersView
            ]
            [ text "Players" ]
        , div
            [ class "left p2"
            , Html.Attributes.style [ ( "cursor", "pointer" ) ]
            , onClick Messages.PerksView
            ]
            [ text "Perks" ]
        ]
