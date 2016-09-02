module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing ((:=))
import Task
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)
import Json.Encode as Encode


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ (toString playerId)


saveTask : Player -> Task.Task Http.Error Player
saveTask player =
    let
        _ =
            Debug.log "Saving player: " player

        body =
            playerEncoder player
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "PATCH"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = saveUrl player.id
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson playerDecoder


save : Player -> Cmd Msg
save player =
    saveTask player
        |> Task.perform SaveFail SaveSuccess


createUrl : String
createUrl =
    "http://localhost:4000/players/"


createTask : Player -> Task.Task Http.Error Player
createTask player =
    let
        body =
            playerEncoder player
                |> Encode.encode 0
                |> Http.string

        config =
            { verb = "POST"
            , headers = [ ( "Content-Type", "application/json" ) ]
            , url = createUrl
            , body = body
            }
    in
        Http.send Http.defaultSettings config
            |> Http.fromJson playerDecoder


create : Player -> Cmd Msg
create player =
    createTask player
        |> Task.perform CreateFail CreateSuccess


deleteUrl : Int -> String
deleteUrl playerId =
    "http://localhost:4000/players/" ++ (toString playerId)


deleteTask : PlayerId -> Task.Task Http.RawError Http.Response
deleteTask id =
    let
        config =
            { verb = "DELETE"
            , headers = []
            , url = deleteUrl id
            , body = Http.empty
            }

        _ =
            Debug.log "config" config
    in
        Http.send Http.defaultSettings config



-- |> handleDeleteResponse
-- |> Http.fromJson playerDecoder
-- handleDeleteResponse : Task.Task Http.RawError Http.Response -> Cmd Msg
-- handleDeleteResponse rawError response =
--     if 200 <= response.status && response.status < 300 then
--         -- Cmd.none
--     else
--         Task.fail (Http.BadResponse response.status response.statusText)


delete : PlayerId -> Cmd Msg
delete id =
    let
        t =
            deleteTask id

        _ =
            Debug.log "task" t
    in
        Task.perform DeleteFail DeleteSuccess t



-- |> Task.perform DeleteFail DeleteSuccess
--
-- deleteResponseDecoder : Task RawError Response -> Task Error a
-- deleteResponseDecoder =
--     let
--         error =
-- stringDecoder : Decode.Decoder String
-- stringDecoder =
--     Decode.decodeString Decode.string


playerDecoder : Decode.Decoder Player
playerDecoder =
    Decode.object3 Player
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("level" := Decode.int)


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list playerDecoder


playerEncoder : Player -> Encode.Value
playerEncoder player =
    let
        list =
            [ ( "id", Encode.int player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
