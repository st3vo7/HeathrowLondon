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

render :: Game.State -> Picture
render state =
       let contentScale = Game.contentScale state
           content      = pictures [ D.board ]
       in  case Game.mode state of
                _ ->            pictures [ D.background $ Game.windowSize state
                                        , scale contentScale contentScale content
                                        ]

main :: IO ()
-- main = do
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

    
    
main = let size       = Config.windowSize
           position   = (600, 0)
           fps        = 30
           background = black
           window     = InWindow "Labyrinth" size position
           updates    = \ seconds state -> case Game.mode state of
                                               _                -> state
           
       in Graphics.Gloss.Game.play
              window
              background
              fps
              Game.initialState
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
    
    
