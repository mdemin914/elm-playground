module Perks.Update exposing (..)

import Perks.Messages exposing (..)
import Perks.Models exposing (..)
import Perks.Commands exposing (..)


update : Msg -> Perks.Models.Model -> ( Perks.Models.Model, Cmd Msg )
update message model =
    case message of
        FetchAllDone newPerks ->
            ( { model | perks = newPerks }, Cmd.none )

        FetchAllFail error ->
            let
                _ =
                    Debug.log "Error getting perks" error
            in
                ( model, Cmd.none )

        AddPerk ->
            addPerk model

        AddPerkSuccess perk ->
            ( { model | perks = perk :: model.perks }, Cmd.none )

        AddPerkFail error ->
            let
                _ =
                    Debug.log "Error adding perk" error
            in
                ( model, Cmd.none )

        PerkNameInput name ->
            ( { model | newPerkName = name }, Cmd.none )

        PerkAttributeInput attribute ->
            ( { model | newPerkAttribute = attribute }, Cmd.none )

        PerkBonusInput bonus ->
            ( { model | newPerkBonus = bonus }, Cmd.none )


addPerk : Perks.Models.Model -> ( Perks.Models.Model, Cmd Msg )
addPerk model =
    let
        newPerk =
            Perk (List.length model.perks + 1) model.newPerkName model.newPerkAttribute model.newPerkBonus
    in
        ( model, (Perks.Commands.createPerk newPerk) )
