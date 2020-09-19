module Main exposing (..)

import Browser exposing (Document, UrlRequest, application)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url exposing (Url)


main : Program () Model Msg
main =
    application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }



-- MODEL


type alias Model =
    { title : String
    , url : Url
    , navKey : Nav.Key
    }


init : () -> Url -> Nav.Key -> ( Model, Cmd msg )
init _ url navKey =
    ( { title = "Hello World"
      , url = url
      , navKey = navKey
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LinkClicked UrlRequest
    | UrlChanged Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( LinkClicked urlRequest, _ ) ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Url.toString url |> Nav.pushUrl model.navKey )

                Browser.External href ->
                    ( model, Nav.load href )

        ( UrlChanged url, _ ) ->
            ( { model | url = url }, Cmd.none )



-- VIEW


view : Model -> Document Msg
view model =
    { title = model.title
    , body =
        [ div [ style "margin" "auto", style "text-align" "center" ]
            [ div [ style "background-color" "#2F4F4F", style "height" "5vh" ] []
            , h1 [] [ text model.title ]
            , p [] [ text ("url = " ++ Url.toString model.url) ]
            , a [ href "/" ] [ text "Home" ]
            , br [] []
            , a [ href "/anything" ] [ text "Anything" ]
            ]
        ]
    }
