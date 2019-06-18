module Game where

import qualified Board
import qualified Config
import Debug.Trace

import Graphics.Gloss.Game


data Mode = ModeSplash | ModeAnimate | ModeEnd deriving (Show,Eq)

data State = State  { cene_trojki :: [[Int]]
                    , mode :: Mode
                    , windowSize :: (Int,Int)
                    , contentScale :: Float
                    } deriving Show


handleEvent :: Event -> State -> State

--spejsom se iz bilo kog moda prelazi u ModeAnimate
--nulom se iz bilo kog moda prelazi u ModeSplash
handleEvent (EventKey (SpecialKey KeySpace) Down _ _) state = state {mode = ModeAnimate}
handleEvent (EventKey (Char '0') Down _ _ ) state = state { mode = ModeSplash }

--1 i 2 su za skejlovanje
handleEvent (EventKey (Char '1') Down _ _ ) state = state { contentScale = 1.0}
handleEvent (EventKey (Char '2') Down _ _ ) state = state { contentScale = 2.0}

--resize
handleEvent (EventResize size) state = state {windowSize = size}

--za bilo koji drugi input ne radi nista
handleEvent _ state = state

--ostaje uraditi f-ju update
