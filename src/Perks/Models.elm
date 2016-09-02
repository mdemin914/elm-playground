module Perks.Models exposing (..)


type alias PerkId =
    Int


type alias Perk =
    { id : PerkId
    , name : String
    , attribute : String
    , bonus : String
    }


type alias Model =
    { perks : List Perk
    , newPerkName : String
    , newPerkAttribute : String
    , newPerkBonus : String
    , formErrors : String
    }


initialModel : Model
initialModel =
    { perks = []
    , newPerkName = ""
    , newPerkAttribute = ""
    , newPerkBonus = ""
    , formErrors = ""
    }
