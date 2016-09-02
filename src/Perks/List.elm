module Perks.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (..)
import Perks.Models exposing (..)
import Perks.Messages exposing (..)


view : Perks.Models.Model -> Html Msg
view model =
    div []
        [ list model
        , perkForm model
        , Html.p [] [ text (toString model) ]
        ]


list : Perks.Models.Model -> Html Msg
list model =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Attribute" ]
                    , th [] [ text "Bonus" ]
                    ]
                ]
            , tbody [] (List.map perkRow model.perks)
            ]
          -- , playerForm model
        ]


perkRow : Perk -> Html Msg
perkRow perk =
    tr []
        [ td [] [ text (toString perk.id) ]
        , td [] [ text perk.name ]
        , td [] [ text (toString perk.attribute) ]
        , td [] [ text (toString perk.bonus) ]
        , td []
            [-- editBtn player
             -- , removeBtn player
            ]
        ]


perkForm : Perks.Models.Model -> Html Msg
perkForm model =
    Html.form [ Html.Events.onSubmit AddPerk ]
        [ div [ class "clearfix mxn2 border" ]
            [ div [ class "col-4 px2 mx-auto" ]
                [ div []
                    [ label [] [ text "Name" ]
                    , input
                        [ Html.Attributes.type' "text"
                        , Html.Events.onInput PerkNameInput
                        , Html.Attributes.value model.newPerkName
                        ]
                        []
                    ]
                , div []
                    [ label [] [ text "Attribute" ]
                    , input
                        [ Html.Attributes.type' "text"
                        , Html.Events.onInput PerkAttributeInput
                        , Html.Attributes.value model.newPerkAttribute
                        ]
                        []
                    ]
                , div []
                    [ label [] [ text "Bonus" ]
                    , input
                        [ Html.Attributes.type' "text"
                        , Html.Events.onInput PerkBonusInput
                          -- , Html.Attributes.value model.newPerkBonus
                        ]
                        []
                    ]
                  -- , validationErrors model
                , button [ Html.Attributes.type' "submit" ] [ text "Save" ]
                , button [ Html.Attributes.type' "button" ] [ text "Cancel" ]
                ]
            ]
        ]
