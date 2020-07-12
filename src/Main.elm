module Main exposing (main)

import Browser
import Html exposing (Html, blockquote, button, div, h2, p, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Http exposing (Error(..))


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }



{-
   MODEL
   * Model type
   * Initialize model with empty values
-}


type alias Model =
    { quote : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "", Cmd.none )



{-
   UPDATE
   * Messages
   * Update case
-}


type Msg
    = GetQuote


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetQuote ->
            ( { model | quote = model.quote ++ "A quote! " }, Cmd.none )



{-
   VIEW
   * Get a quote
-}


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ h2 [ class "text-center" ] [ text "Chuck Norris Quotes" ]
        , p [ class "text-center" ]
            [ button [ class "btn btn-success", onClick GetQuote ] [ text "Grab a quote!" ]
            ]

        -- Blockquote with quote
        , blockquote []
            [ p [] [ text model.quote ]
            ]
        ]
