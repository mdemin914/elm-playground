module Players.Update exposing (..)

-- import Http

import Players.Messages exposing (Msg(..))
import Navigation
import Players.Commands exposing (save, create)
import Players.Models exposing (Player, PlayerId)


update : Msg -> Players.Models.Model -> ( Players.Models.Model, Cmd Msg )
update message model =
    case message of
        FetchAllDone newPlayers ->
            Debug.log (toString newPlayers)
                ( handleFetchAllDone newPlayers model, Cmd.none )

        FetchAllFail error ->
            Debug.log (toString error)
                ( model, Cmd.none )

        ShowPlayers ->
            ( model, Navigation.newUrl "#players" )

        ShowPlayer id ->
            ( model, Navigation.newUrl ("#players/" ++ (toString id)) )

        ChangeLevel id howMuch ->
            ( model, changeLevelCommands id howMuch model.players |> Cmd.batch )

        SaveSuccess updatedPlayer ->
            -- Debug.log "save success"
            ( updatePlayer updatedPlayer model, Cmd.none )

        SaveFail error ->
            -- Debug.log (toString error)
            ( model, Cmd.none )

        CreateSuccess updatedPlayer ->
            ( (handleCreateSucccess updatedPlayer model), Cmd.none )

        CreateFail error ->
            ( model, Cmd.none )

        AddPlayer ->
            addNewPlayer model

        ValidatePlayer ->
            validatePlayer model

        DeletePlayer id ->
            (deletePlayer id model)

        DeleteSuccess response ->
            -- Debug.log (toString response)
            ( model, Cmd.none )

        -- ( handleDeletePlayerSuccess model response, Cmd.none )
        DeleteFail error ->
            Debug.log (toString error)
                ( model, Cmd.none )

        PlayerNameInput name ->
            ( handlePlayerNameInput name model, Cmd.none )


validatePlayer : Players.Models.Model -> ( Players.Models.Model, Cmd Msg )
validatePlayer model =
    let
        newPlayer =
            Player ((List.length model.players) + 1) model.newPlayerName 0
    in
        if model.newPlayerName == "" then
            ( { model | formErrors = "Please specify name" }, Cmd.none )
        else
            ( { model | formErrors = "" }, Players.Commands.create newPlayer )


deletePlayer : PlayerId -> Players.Models.Model -> ( Players.Models.Model, Cmd Msg )
deletePlayer playerId model =
    let
        newPlayers =
            List.filter
                (\p -> p.id /= playerId)
                model.players

        _ =
            Debug.log "Deleting player" playerId
    in
        ( { model | players = newPlayers }, Players.Commands.delete playerId )


handleCreateSucccess : Player -> Players.Models.Model -> Players.Models.Model
handleCreateSucccess newPlayer model =
    let
        newPlayers =
            newPlayer
                :: model.players
                |> List.sortBy .name
    in
        { model
            | players = newPlayers
            , newPlayerName = ""
        }


handleFetchAllDone : List Player -> Players.Models.Model -> Players.Models.Model
handleFetchAllDone newPlayers model =
    let
        orderedPlayers =
            List.sortBy .name newPlayers
    in
        { model
            | players = orderedPlayers
        }


handlePlayerNameInput : String -> Players.Models.Model -> Players.Models.Model
handlePlayerNameInput name model =
    { model
        | newPlayerName = name
    }


addNewPlayer : Players.Models.Model -> ( Players.Models.Model, Cmd Msg )
addNewPlayer model =
    let
        newPlayer =
            Player (List.length model.players + 1) model.newPlayerName 0

        newPlayers =
            (newPlayer :: model.players)
                |> List.sortBy .name
    in
        ( { model
            | newPlayerName = ""
          }
        , Players.Commands.create newPlayer
        )


changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch =
    let
        _ =
            Debug.log "Changing Level" playerId

        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer


updatePlayer : Player -> Players.Models.Model -> Players.Models.Model
updatePlayer updatedPlayer model =
    let
        _ =
            Debug.log "Updated player" updatedPlayer

        newPlayers =
            List.map
                (\player ->
                    if player.id == updatedPlayer.id then
                        { player
                            | level = updatedPlayer.level
                        }
                    else
                        player
                )
                model.players
    in
        { model
            | players = newPlayers
        }
