module Players.List exposing (..)

import Html exposing (..)
import String
import Html.Attributes exposing (class)
import Players.Messages exposing (..)
import Players.Models exposing (Player)
import Html.Events exposing (onClick)


view : Players.Models.Model -> Html Msg
view model =
    div []
        [ list model
        , Html.p [] [ text (toString model) ]
        ]


list : Players.Models.Model -> Html Msg
list model =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [] [ text "Id" ]
                    , th [] [ text "Name" ]
                    , th [] [ text "Level" ]
                    , th [] [ text "Actions" ]
                    ]
                ]
            , tbody [] (List.map playerRow model.players)
            ]
        , playerForm model
        ]


playerRow : Player -> Html Msg
playerRow player =
    tr []
        [ td [] [ text (toString player.id) ]
        , td [] [ text player.name ]
        , td [] [ text (toString player.level) ]
        , td []
            [ editBtn player
            , removeBtn player
            ]
        ]


editBtn : Player -> Html Msg
editBtn player =
    button
        [ class "btn regular"
        , onClick (ShowPlayer player.id)
        ]
        [ i [ class "fa fa-pencil mr1" ] [], text "Edit" ]


removeBtn : Player -> Html Msg
removeBtn player =
    button
        [ class "btn regular"
        , onClick (DeletePlayer player.id)
        ]
        [ i [ class "fa fa-trash mr1" ] [], text "Remove" ]


validationErrors : Players.Models.Model -> Html Msg
validationErrors model =
    if String.isEmpty model.formErrors then
        div [ class "validation-error" ] []
    else
        div [ class "validation-error bg-red" ] [ text model.formErrors ]


playerForm : Players.Models.Model -> Html Msg
playerForm model =
    Html.form [ Html.Events.onSubmit ValidatePlayer ]
        [ input
            [ Html.Attributes.type' "text"
            , Html.Events.onInput PlayerNameInput
            , Html.Attributes.value model.newPlayerName
            ]
            []
        , validationErrors model
        , button [ Html.Attributes.type' "submit" ] [ text "Save" ]
        , button [ Html.Attributes.type' "button" ] [ text "Cancel" ]
        ]
