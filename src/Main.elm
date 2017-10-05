port module Main exposing (..)

import Html exposing (Html, text, div, h1, p, ul, li, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { images : List Image
    , arMode : Bool
    }


type alias Image =
    { name : String
    , url : String
    }


init : ( Model, Cmd Msg )
init =
    ( { images =
            [ { name = "Blue Circles", url = "http://res.cloudinary.com/du9exzlar/image/upload/v1492033088/zdd8tdtkdyyjo6dadcto.jpg" }
            , { name = "Abstract Seaside", url = "http://res.cloudinary.com/du9exzlar/image/upload/v1492618920/xyj4jy1rm66ols3tdc39.jpg" }
            , { name = "Charcoal Picasso", url = "http://res.cloudinary.com/du9exzlar/image/upload/v1492033007/dkzmp0yvxscngj2ghnhj.jpg" }
            , { name = "Fire Lines", url = "http://res.cloudinary.com/du9exzlar/image/upload/v1492033057/wujmqxdsdnq3pxiqmjc3.jpg" }
            ]
      , arMode = False
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = SendImageToArjs String
    | DeleteArjs


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendImageToArjs url ->
            ( { model | arMode = True }, sendImageToArjs url )

        DeleteArjs ->
            ( { model | arMode = False }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h1 [ class "text-center" ] [ text "Let's test some ar.js in elm!" ]
        , ul []
            (List.map imageList model.images)
        , p [] [ text "need to create port to send image to arjs" ]
        , if model.arMode then
            button [ class "delete-arjs", onClick DeleteArjs ] [ text "Exit AR" ]
          else
            div [] []
        ]


imageList : Image -> Html Msg
imageList img =
    li [ onClick (SendImageToArjs img.url) ] [ text img.name ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }



-- PORTS --


port sendImageToArjs : String -> Cmd msg
