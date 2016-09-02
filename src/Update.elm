module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update
import Perks.Update
import Navigation


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, cmd ) =
                    Players.Update.update subMsg model.playersModel
            in
                ( { model | playersModel = updatedPlayers }, Cmd.map PlayersMsg cmd )

        -- Handles the routing for the Perks messages from the Perks.Update.update function
        PerksMsg subMsg ->
            let
                ( updatedPerks, cmd ) =
                    Perks.Update.update subMsg model.perksModel
            in
                ( { model | perksModel = updatedPerks }, Cmd.map PerksMsg cmd )

        HomeView ->
            ( model, Navigation.newUrl "#players" )

        PlayersView ->
            ( model, Navigation.newUrl "#players" )

        PerksView ->
            ( model, Navigation.newUrl "#perks" )
