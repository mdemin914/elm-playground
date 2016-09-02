module Messages exposing (..)

import Players.Messages
import Perks.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | PerksMsg Perks.Messages.Msg
    | HomeView
    | PlayersView
    | PerksView
