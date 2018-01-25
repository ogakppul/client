module Types exposing (..)

import Json.Decode as Json
import Html5.DragDrop as DragDrop


type Msg
    = NoOp
    -- === Card Activation ===
    | Activate String
    -- === Card Editing  ===
    | OpenCard String String
    | UpdateContent (String, String)
    | DeleteCard String
    | CancelCard
    -- === Card Insertion  ===
    | InsertAbove String
    | InsertBelow String
    | InsertChild String
    -- === Card Moving  ===
    | DragDropMsg (DragDrop.Msg String DropId)
    -- === History ===
    | Undo
    | Redo
    | Sync
    | SetSelection String Selection String
    | Resolve String
    | CheckoutCommit String
    -- === Ports ===
    | Outside InfoForElm
    | LogErr String
    | ImportJson Json.Value
    | SetHeadRev String
    | RecvCollabState Json.Value
    | CollaboratorDisconnected String


type InfoForOutside
    = Alert String
    | ActivateCards (Int, List (List String))
    | GetText String
    | SaveObjects (Json.Value, Json.Value)
    | SaveLocal Tree
    | UpdateCommits (Json.Value, Maybe String)
    | ConfirmCancel String String
    | New (Maybe String)
    | Save String
    | SaveAs
    | ExportJSON Tree
    | ExportTXT Tree
    | Open (Maybe String)
    | Push
    | Pull
    | SetSaved String
    | SetChanged
    | SocketSend CollabState


type InfoForElm
    = Reset
    | Load (String, Json.Value)
    | Merge Json.Value
-- port merge : (Json.Value -> msg) -> Sub msg
-- port importJson : (Json.Value -> msg) -> Sub msg
-- port setHead : (String -> msg) -> Sub msg
-- port setHeadRev : (String -> msg) -> Sub msg
-- port updateContent : ((String, String) -> msg) -> Sub msg
-- port cancelConfirmed : (() -> msg) -> Sub msg
--| ImportJson Json.Value
--| SetHeadRev String
--| RecvCollabState Json.Value
--| CollaboratorDisconnected String
    | Changed
    | Saved String
-- port collabMsg : (Json.Value -> msg) -> Sub msg
-- port collabLeave : (String -> msg) -> Sub msg
    | DoExportJSON
    | DoExportTXT
    | Keyboard String


type alias OutsideData =
  { tag : String, data: Json.Value }


type alias Tree =
  { id : String
  , content : String
  , children : Children
  }


type Children = Children (List Tree)
type alias Group = List Tree
type alias Column = List (List Tree)



type Op = Ins String String (List String) Int | Mod String (List String) String String | Del String (List String) | Mov String (List String) Int (List String) Int
type Selection = Original | Ours | Theirs | Manual
type alias Conflict =
  { id : String
  , opA : Op
  , opB : Op
  , selection : Selection
  , resolved : Bool
  }


type Status = Bare | Clean String | MergeConflict Tree String String (List Conflict)


type Mode = Active String | Editing String


type DropId = Above String | Below String | Into String


type alias CollabState =
  { uid : String
  , mode : Mode
  , field : String
  }


type alias ViewState =
  { active : String
  , activePast : List String
  , activeFuture : List String
  , descendants : List String
  , editing : Maybe String
  , dragModel : DragDrop.Model String DropId
  , draggedTree : Maybe (Tree, String, Int)
  , collaborators : List CollabState
  }


type alias VisibleViewState =
  { active : String
  , editing : Maybe String
  , descendants : List String
  , dragModel : DragDrop.Model String DropId
  , collaborators : List CollabState
  }


type alias WordCount =
  { card : Int
  , subtree : Int
  , group : Int
  , column : Int
  , document : Int
  }
