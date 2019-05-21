module Main where

import System.IO
import Data.List

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)


boardDataAB :: Int -> [Char]
boardDataAB n = concat $ take n $ repeat "###o"

boardDataC :: Int -> [Char]
boardDataC n = concat $ take n $ repeat "___*"


pocistiZaSobom :: String -> String
pocistiZaSobom fajl = unlines $ init $ lines fajl

main = do
    contents <- readFile "src/ulaz.txt"
    --let threes =  groupsOf 3 (map read $ lines contents)
    --let threes = map (read (lines contents)) :: Int
    let niz = (map read $  lines contents) :: [Int]
    print niz
    let threes = groupsOf 3 niz
    print threes
    --print $ length threes
    
    let boardData = [boardDataAB $ length threes,
                     boardDataC $ length threes,
                     boardDataC $ length threes,
                     boardDataC $ length threes,
                     boardDataAB $ length threes
                         ]
    print boardData
    
    
    --ovde će da, kao poslednju liniju  u Config.hs, doda boardData
    --appendFile "src/Config.hs" (show boardData)
    
    --ideja mi je da kad završi sa radom obriše poslednju liniju u Config-u (kako bi ok radilo i za novi ulaz)
    --to radi tako što u cicsenje upiše sadržaj Config-a ...
  --  ciscenje <- readFile "Config.hs"
    
    
 -- ... i pozove f-ju koja pretvori sve u listu po novim redovima, i vrati sve osim poslenjeg reda ...
 --   let nf = pocistiZaSobom ciscenje
    
    -- ... i zatim sve to overwrite-uje novim fajlom Config.hs
--    writeFile "Config.hs" (show nf)
    
    --putStrLn threes
    
    
    
    --putStrLn contents
    
    
