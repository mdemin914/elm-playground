module Players.Messages exposing (..)

import Players.Models exposing (..)
import Http


type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
    | ShowPlayers
    | ShowPlayer PlayerId
    | ChangeLevel PlayerId Int
    | SaveSuccess Player
    | SaveFail Http.Error
    | CreateSuccess Player
    | CreateFail Http.Error
    | AddPlayer
    | ValidatePlayer
    | DeletePlayer PlayerId
    | DeleteSuccess Http.Response
    | DeleteFail Http.RawError
    | PlayerNameInput String
