module Models exposing (..)

import Players.Models exposing (..)
import Perks.Models exposing (..)
import Routing


type alias Model =
    { playersModel : Players.Models.Model
    , perksModel : Perks.Models.Model
    , route : Routing.Route
    }


initialModel : Routing.Route -> Model
initialModel route =
    { playersModel = Players.Models.initialModel
    , perksModel = Perks.Models.initialModel
    , route = route
    }
