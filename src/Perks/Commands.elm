module Perks.Commands exposing (..)

import Json.Encode as Encode
import Json.Decode as Decode exposing ((:=))
import Http
import Task
import Perks.Models exposing (..)
import Perks.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get collectionDecoder fetchAllUrl
        |> Task.perform FetchAllFail FetchAllDone


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


createPerk : Perk -> Cmd Msg
createPerk perk =
    createTask perk
        |> Task.perform AddPerkFail AddPerkSuccess


createTask : Perk -> Task.Task Http.Error Perk
createTask perk =
    let
        body =
            perkEncoder perk
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
            |> Http.fromJson perkDecoder


createUrl : String
createUrl =
    "http://localhost:4000/perks/"


collectionDecoder : Decode.Decoder (List Perk)
collectionDecoder =
    Decode.list perkDecoder


perkEncoder : Perk -> Encode.Value
perkEncoder perk =
    let
        list =
            [ ( "id", Encode.int perk.id )
            , ( "name", Encode.string perk.name )
            , ( "attribute", Encode.string perk.attribute )
            , ( "bonus", Encode.string perk.bonus )
            ]
    in
        list
            |> Encode.object


perkDecoder : Decode.Decoder Perk
perkDecoder =
    Decode.object4 Perk
        ("id" := Decode.int)
        ("name" := Decode.string)
        ("attribute" := Decode.string)
        ("bonus" := Decode.string)
