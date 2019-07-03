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
           valuesBoardA  = D.boardValuesA $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 1                                   ---["10", "20", "30", "40"]
           valuesBoardB  = D.boardValuesB $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 0                                   ---["5", "20", "78", "13"]
           valuesBoardC  = D.boardValuesC $ intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 2                                   ---["17", "4", "37", "70"]
           content      = pictures  [D.board state, valuesBoardA,valuesBoardB,valuesBoardC ]
           splashScreen = D.splash $ Game.windowSize state
           endScreen = D.end $ Game.windowSize state
           contentScale = Game.contentScale state
      --     valuesBoardA = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 0
      --     valuesBoardB = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 1
      --     valuesBoardC = intsToStrings $ getIntsAtPosition (Game.cene_trojki state) 2
            in  case Game.mode state of
                Game.ModeSplash -> splashScreen
                Game.ModeEnd    -> endScreen
                _               -> pictures [scale contentScale contentScale content]
        
                               



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
          colored_path' = Cld.napravi_novu Cld.inic_tabela pathString
          --izmeni, tako sto doda crtice (-) na odgovarajucim mestima
          colored_path = Cld.izmeni_novu colored_path'

      --print threes
      --print Config.boardData
      --print colored_path
      --putStrLn $ "Najbolja putanja je: " ++ pathString
      --initialState :: Game.State

  --        colored_path  = Cld.napravi_novu Cld.inic_tabela pathString::[String]


      -- let lista1 = fst $ Game.zameni (Config.boardData) colored_path' 
      --     lista2 = snd $ Game.zameni (Config.boardData) colored_path'
      --     lista3 = fst $ Game.zameni lista1 lista2 
      --     lista4 = snd $ Game.zameni lista1 lista2 
        
      --     print lista1
      --     print lista2

      --     lista5 = fst $ Game.zameni lista3 lista4 
      --     lista6 = snd $ Game.zameni lista3 lista4 

      --     lista7 = fst $ Game.zameni lista5 lista6 
      --     lista8 = snd $ Game.zameni lista5 lista6 

      --     lista9 = fst $ Game.zameni lista7 lista8 
      --     lista10 = snd $ Game.zameni lista7 lista8 

      --     lista11 = fst $ Game.zameni lista9 lista10 
      --     lista12 = snd $ Game.zameni lista9 lista10 

      --     lista13 = fst $ Game.zameni lista11 lista12 
      --     lista14 = snd $ Game.zameni lista11 lista12 

      --     lista15 = fst $ Game.zameni lista13 lista14 
      --     lista16 = snd $ Game.zameni lista13 lista14 

      --     lista17 = fst $ Game.zameni lista15 lista16 
      --     lista18 = snd $ Game.zameni lista15 lista16 

      --     lista19 = fst $ Game.zameni lista17 lista18 
      --     lista20 = snd $ Game.zameni lista17 lista18 


      --     colored_path0 = lista19
      --     colored_path1 = tail colored_path0
      --     colored_path2 = tail colored_path1 
      --     colored_path3 = tail colored_path2
      --     colored_path4 = tail colored_path3 
      --     colored_path5 = tail colored_path4 
      --     colored_path6 = tail colored_path5 

      --     bord = lista20
      --     bord1 = tail bord
      --     bord2 = tail bord1
      --     bord3 = tail bord2
      --     bord4 = tail bord3
      --     bord5 = tail bord4
      --     bord6 = tail bord5


      -- putStrLn []
      -- putStrLn $ head colored_path0
      -- putStrLn $ head colored_path1
      -- putStrLn $ head colored_path2
      -- putStrLn $ head colored_path3
      -- putStrLn $ head colored_path4
      -- putStrLn $ head colored_path5
      -- putStrLn $ head colored_path6
      -- putStrLn []
      -- putStrLn $ head bord
      -- putStrLn $ head bord1
      -- putStrLn $ head bord2
      -- putStrLn $ head bord3
      -- putStrLn $ head bord4
      -- putStrLn $ head bord5
      -- putStrLn $ head bord6

      -- print $ Game.charAtPosition lista10 '?'
      
      
      
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
           fps        = 30
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
    
    
