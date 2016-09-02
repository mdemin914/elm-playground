module Perks.Messages exposing (..)

import Perks.Models exposing (..)
import Http


type Msg
    = FetchAllDone (List Perk)
    | FetchAllFail Http.Error
    | AddPerk
    | AddPerkSuccess Perk
    | AddPerkFail Http.Error
    | PerkNameInput String
    | PerkAttributeInput String
    | PerkBonusInput String
