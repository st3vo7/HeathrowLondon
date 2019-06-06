module Game where

import qualified Board
import qualified Config
import Debug.Trace

import Graphics.Gloss.Game

data ItemState = ItemState { position  :: Board.Position
                           , speed     :: (Float, Float)
                           } deriving Show

data Mode = ModeIsShort | ModeNotShort
          deriving (Show, Eq)

data State = State { mode         :: Mode
                   , windowSize   :: (Int, Int)
                   , contentScale :: Float
                   } deriving Show


initialState :: State
initialState = State { mode         = ModeNotShort
                     , windowSize   = Config.windowSize
                     , contentScale = 1
                     }


handleEvent :: Event -> State -> State
handleEvent _ state = state
