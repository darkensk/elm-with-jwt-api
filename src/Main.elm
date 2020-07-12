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
    ( Model "", fetchRandomQuoteCmd )



{-
   UPDATE
   * API routes
   * GET
   * Messages
   * Update case
-}
-- API request URLs


api : String
api =
    "http://localhost:3001/"


randomQuoteUrl : String
randomQuoteUrl =
    api ++ "api/random-quote"



-- GET a random quote (unauthenticated)


fetchRandomQuoteCmd : Cmd Msg
fetchRandomQuoteCmd =
    Http.get
        { url = randomQuoteUrl
        , expect = Http.expectString FetchRandomQuoteCompleted
        }


fetchRandomQuoteCompleted : Model -> Result Http.Error String -> ( Model, Cmd Msg )
fetchRandomQuoteCompleted model result =
    case result of
        Ok newQuote ->
            ( { model | quote = newQuote }, Cmd.none )

        Err _ ->
            ( model, Cmd.none )



-- Messages


type Msg
    = GetQuote
    | FetchRandomQuoteCompleted (Result Http.Error String)



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetQuote ->
            ( model, fetchRandomQuoteCmd )

        FetchRandomQuoteCompleted result ->
            fetchRandomQuoteCompleted model result



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
