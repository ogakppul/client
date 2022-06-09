module HelpModal exposing (..)

import Browser
import Doc.HelpScreen as HelpScreen
import Json.Decode exposing (Value)
import Translation exposing (Language(..))


main : Program Value Model Msg
main =
    Browser.document
        { init = init
        , update = \msg mod -> ( mod, Cmd.none )
        , view = \m -> Browser.Document "Help" (HelpScreen.viewShortcuts m.language m.isMac)
        , subscriptions = \_ -> Sub.none
        }



-- MODEL


type alias Model =
    { language : Language, isMac : Bool }


init json =
    ( { language = En
      , isMac = False
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = NoOp