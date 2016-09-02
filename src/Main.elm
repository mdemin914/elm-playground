module Main exposing (..)

import Navigation
import Messages exposing (Msg(..))
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Players.Commands exposing (fetchAll)
import Perks.Commands exposing (fetchAll)
import Routing exposing (Route)


init : Result String Route -> ( Model, Cmd Msg )
init result =
    let
        currentRoute =
            Routing.routeFromResult result
    in
        ( initialModel currentRoute
        , Cmd.map PlayersMsg Players.Commands.fetchAll
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


urlUpdate : Result String Route -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    let
        currentRoute =
            Routing.routeFromResult result

        _ =
            Debug.log "Current Route" currentRoute
    in
        if toString currentRoute == "PerksRoute" then
            ( { model | route = currentRoute }
            , Perks.Commands.fetchAll
            )
        else if toString currentRoute == "PlayersRoute" then
            ( { model | route = currentRoute }
            , Players.Commands.fetchAll
            )
        else
            ( { model | route = currentRoute }, Cmd.none )


main : Program Never
main =
    Navigation.program Routing.parser
        { init = init
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        , subscriptions = subscriptions
        }
