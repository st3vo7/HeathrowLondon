module Main where

import System.IO
import Data.List
import Graphics.Gloss
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



--boardDataAB :: Int -> [Char]
--boardDataAB n = concat $ take n $ repeat "###o"

--boardDataC :: Int -> [Char]
--boardDataC n = concat $ take n $ repeat "___*"


--pocistiZaSobom :: String -> String
--pocistiZaSobom fajl = unlines $ init $ lines fajl


--changeChar :: [String] -> String -> [String]
--changeChar tabela (x:xs)
--    | x == 'B' = last 

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
           valuesBoardA  = D.boardValuesA $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 0                                   ---["10", "20", "30", "40"]
           valuesBoardB  = D.boardValuesB $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 1                                   ---["5", "20", "78", "13"]
           valuesBoardC  = D.boardValuesC $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 2                                   ---["17", "4", "37", "70"]
           content      = pictures  [D.board, valuesBoardA,valuesBoardB,valuesBoardC]
           splashScreen = D.splash $ Game.windowSize state
           endScreen = D.end $ Game.windowSize state
      --     valuesBoardA = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 0
      --     valuesBoardB = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 1
      --     valuesBoardC = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 2
            in  case Game.mode state of
                Game.ModeSplash -> splashScreen
                Game.ModeEnd    -> endScreen
                Game.ModeAnimate ->            pictures [content]
                                        --D.background $ Game.windowSize state

main :: IO ()
--  main = do
--     contents <- readFile "src/ulaz.txt"
--     --let threes =  groupsOf 3 (map read $ lines contents)
--     --let threes = map (read (lines contents)) :: Int
--     let niz = (map read $  lines contents) :: [Int]
--     print niz
    
--     let threes = groupsOf 3 niz
--     --print threes 
--     --print $ length threes
--         roadSystem = map (\[a,b,c] -> SP.Section a b c) threes
--         path = SP.optimalPath roadSystem
--         pathString = concat $ map (show . fst ) path
--         pathPrice = sum $ map snd path
--         colored_path = Cld.napravi_novu Cld.inic_tabela pathString
        
        
        
--     putStrLn $ "Najbolja putanja je: " ++ pathString
--     putStrLn $ "i njena cena je: " ++ show pathPrice
    
    
--     print Config.boardData 
--     --putStrLn $ "Obojena tablica je: " ++ colored_path
--     print colored_path
    
--     let size = Config.windowSize
--         positon = Config.windowPosition
--         background = white
--         window = InWindow "From Heathrow to London" size positon
--         drawing = circle 80
        
--         in display window background drawing
    
    
main = 
  do  contents <- readFile "src/ulaz.txt"
      let niz = (map read $  lines contents) :: [Int]
     
    
      let threes = groupsOf 3 niz :: [[Int]]
          roadSystem = map (\[a,b,c] -> SP.Section a b c) threes
          path = SP.optimalPath roadSystem
          pathString = concat $ map (show . fst ) path
          pathPrice = sum $ map snd path
          colored_path = Cld.napravi_novu Cld.inic_tabela pathString

      --print threes
      --print colored_path
      --initialState :: Game.State
      
      --dakle on iz Game-a pozove State i uzme threes da napravi inicijalno stanje
      let initialState = Game.State { Game.cene_trojki  = threes
                          , Game.mode         = Game.ModeSplash
                          , Game.windowSize   = Config.windowSize
                          , Game.contentScale = 1
                          }
      
      
      
      
      let  size       = Config.windowSize
           position   = (600, 0)
           fps        = 30
           background = white
           window     = InWindow "From Heathrow to London" size position
           updates    = \ seconds state -> case Game.mode state of
                                               Game.ModeSplash -> state
                                               Game.ModeEnd    -> state
                                               _                -> state
           
       in Graphics.Gloss.Game.play
              window
              background
              fps
              initialState
              render
              Game.handleEvent
              [updates]
              
















    
    --ovde će da, kao poslednju liniju  u Config.hs, doda boardData
    
    --ideja mi je da kad završi sa radom obriše poslednju liniju u Config-u (kako bi ok radilo i za novi ulaz)
    --to radi tako što u cicsenje upiše sadržaj Config-a ...

  --  ciscenje <- readFile "Config.hs"
    
    
-- ... i pozove f-ju koja pretvori sve u listu po novim redovima, i vrati sve osim poslenjeg reda ...
 --   let nf = pocistiZaSobom ciscenje

    
-- ... i zatim sve to overwrite-uje novim fajlom Config.hs
--    writeFile "Config.hs" (show nf)
    
    --putStrLn threes
    
    --putStrLn contents
    
    
