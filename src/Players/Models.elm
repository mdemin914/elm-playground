module Players.Models exposing (..)


type alias PlayerId =
    Int


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


type alias Model =
    { players : List Player
    , newPlayerName : String
    , formErrors : String
    }


initialModel : Model
initialModel =
    { players = []
    , newPlayerName = ""
    , formErrors = ""
    }


new : Player
new =
    { id = 0
    , name = ""
    , level = 1
    }
