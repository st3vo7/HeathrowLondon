module Main where

import System.IO
import Data.List
import Data.Maybe
import Graphics.Gloss
import Graphics.Gloss.Game
import Graphics.Gloss.Interface.Pure.Simulate

import qualified Config
import qualified ShortestPath as SP
import qualified Board 
import qualified Game
import qualified Colored as Cld
import qualified Display as D

{-# LANGUAGE BlockArguments #-}

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

--ako se nalazi u ModeSplash prikazi splashScreen
--ako se nalazi u ModeEnd prikazi endScreen
--inace radi pictures[content]
--note: Inic stanje je ModeSplash i treba da se klikne space da predje u ModeAnimate

getIntsAtPosition::[[Int]] -> Int -> [Int]
getIntsAtPosition list index = map (!! index) list 

intsToStrings::[Int] -> [String]
intsToStrings ints = map show ints




render :: Game.State -> Picture
render state =
       let 
           valuesBoardA  = D.boardValuesA $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 1

           valuesBoardB  = D.boardValuesB $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 0

           valuesBoardC  = D.boardValuesC $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 2

           content      = pictures  [D.board state, valuesBoardA,valuesBoardB,valuesBoardC ]
           splashScreen = D.splash $ Game.windowSize state
           endScreen = D.end $ Game.windowSize state
           contentScale = Game.contentScale state
            in  case Game.mode state of
                Game.ModeSplash -> splashScreen
                Game.ModeEnd    -> endScreen
                _               -> pictures [scale contentScale contentScale content]
        
                               



main :: IO ()
main = 
  do  contents <- readFile "src/ulaz2.txt"
      let niz = (map read $  lines contents) :: [Int]
     
    
      let threes = groupsOf 3 niz :: [[Int]]
          roadSystem = map (\[a,b,c] -> SP.Section a b c) threes
          path = SP.optimalPath roadSystem
          pathString = concat $ map (show . fst ) path
          pathPrice = sum $ map snd path
          colored_path' = Cld.napravi_novu Cld.inic_tabela pathString
          --izmeni, tako sto doda crtice (-) na odgovarajucim mestima
          colored_path = Cld.izmeni_novu colored_path'

      --print threes
      print Config.boardData
      print colored_path
      putStrLn $ "Najbolja putanja je: " ++ pathString
      --initialState :: Game.State

      
      --dakle on iz Game-a pozove State i uzme threes da napravi inicijalno stanje
      let initialState = Game.State { Game.cene_trojki  = threes
                          , Game.mode         = Game.ModeSplash
                          , Game.windowSize   = Config.windowSize
                          , Game.contentScale = 1
                          , Game.pocetna_tabla = Config.boardData
                          , Game.krajnja_tabla = colored_path
                          }
      
      
      
      
      let  size       = Config.windowSize
           position   = (600, 0)
           fps        = 1
           background = white
           window     = InWindow "From Heathrow to London" size position
           updates    = \ seconds state -> case Game.mode state of
                                               Game.ModeSplash -> state
                                               Game.ModeEnd    -> state
                                               _               -> Game.update seconds state
           
       in Graphics.Gloss.Game.play
              window
              background
              fps
              initialState
              render
              Game.handleEvent
              [updates]
    
    
