module Main where

import System.IO
import Data.List
import Data.Maybe
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
    


--prvo pojavljivanje karaktera zipovano sa indeksima (lista, indeks_pojavljivanja)
charAtPosition::[[Char]] -> Char -> (Int, Int)
charAtPosition lista kar = minim $ zip [0..n] $ map (fromMaybeToInt kar) lista
  where n = (length lista) - 1


fromMaybeToInt::Char -> [Char] -> Int
fromMaybeToInt kar lista = if n == Nothing then (maxBound :: Int) else fromJust $ n
  where n = (elemIndex kar lista)

--vraca par indeks vrednost minimalnog pojavljivanja karaktera 
minim :: [(Int,Int)] -> (Int,Int)
minim [x]      = x
minim (x:xs)   = minM x $ minim xs


--fja za poredjenje dve torke (r_br_liste,indeks_u_listi) po drugoj koordinati 
minM :: (Int,Int) -> (Int,Int) -> (Int,Int)
minM a b
    | (snd a) > (snd b)  = b
    | (snd a) < (snd b)  = a
    | (snd a) == (snd b) = a



insertAt :: a -> Int -> [a] -> [a]
insertAt newElement 0 as = newElement:as
insertAt newElement i (a:as) = a : insertAt newElement (i - 1) as


zameni::[String] -> [String] -> (Int, Int) -> ([String],[String]) 
zameni prva druga par
    | (i == 0) = (setAorB prva druga par) 
    | (i == 6) = (setAorB prva druga par)
    | otherwise = (setC prva druga par)
      where i = fst $ charAtPosition druga '?'

setAorB::[String] -> [String] -> (Int, Int) -> ([String], [String])
setAorB prva druga par = (replaceNth (fst par) nova1 prva, replaceNth (fst par) nova2 druga) 
  where (nova1, nova2) = (replaceNth (snd par) '?' (prva !! (fst par)), replaceNth (snd par) 'x' (druga !! (fst par)))


setC::[String] -> [String] -> (Int, Int) -> ([String], [String])
setC prva druga par = (replaceNth (indx) nova1 prva, replaceNth (indx) nova2 druga) 
  where { (nova1, nova2) = (replaceNth (snd par) '?' (prva !! (indx)), replaceNth (snd par) 'x' (druga !! (indx))); 
          indx = if (wasB prva par) then (((length prva) - 1) - (fst par)) else fst par;                                                                                                 }
--setC prva druga par = (["a"], ["a"])


-- insertAt::[a] -> Int -> a -> [a]
-- insertAt lista 

replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x:xs)
  | n == 0 = newVal:xs
  | otherwise = x:replaceNth (n-1) newVal xs


-- //vraca vrednost minimalnog pojavljivanja 
-- vratiPojavljivanje::lista
-- vratiPojavljivanje = min $ map $ elemIIndex ‘?’ llista

wasB::[String] -> (Int, Int) -> Bool
wasB lista koordinate = if ((lista !! n) !! ((snd koordinate)-1)) == '?' then True else False
  where n = (length lista) - 1 



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
      print Config.boardData
      print colored_path
      putStrLn $ "Najbolja putanja je: " ++ pathString
      --initialState :: Game.State

  --        colored_path  = Cld.napravi_novu Cld.inic_tabela pathString::[String]



      --     colored_path1 = tail colored_path' 
      --     colored_path2 = tail colored_path1 
      --     colored_path3 = tail colored_path2
      --     colored_path4 = tail colored_path3 
      --     colored_path5 = tail colored_path4 
      --     colored_path6 = tail colored_path5 

      --     bord = Config.boardData
      --     bord1 = tail bord
      --     bord2 = tail bord1
      --     bord3 = tail bord2
      --     bord4 = tail bord3
      --     bord5 = tail bord4
      --     bord6 = tail bord5

      -- putStrLn []
      -- putStrLn $ head bord
      -- putStrLn $ head bord1
      -- putStrLn $ head bord2
      -- putStrLn $ head bord3
      -- putStrLn $ head bord4
      -- putStrLn $ head bord5
      -- putStrLn $ head bord6
      -- putStrLn []
      -- putStrLn $ head colored_path'
      -- putStrLn $ head colored_path1
      -- putStrLn $ head colored_path2
      -- putStrLn $ head colored_path3
      -- putStrLn $ head colored_path4
      -- putStrLn $ head colored_path5
      -- putStrLn $ head colored_path6

      -- let lista1 = fst $ zameni (Config.boardData) colored_path' (charAtPosition colored_path' '?')
      --     lista2 = snd $ zameni (Config.boardData) colored_path' (charAtPosition colored_path' '?')

      --     lista3 = fst $ zameni lista1 lista2 (charAtPosition lista2 '?')
      --     lista4 = snd $ zameni lista1 lista2 (charAtPosition lista2 '?')

      --     lista5 = fst $ zameni lista3 lista4 (charAtPosition lista4 '?')
      --     lista6 = snd $ zameni lista3 lista4 (charAtPosition lista4 '?')

      --     lista7 = fst $ zameni lista5 lista6 (charAtPosition lista6 '?')
      --     lista8 = snd $ zameni lista5 lista6 (charAtPosition lista6 '?')

      --     lista9 = fst $ zameni lista7 lista8 (charAtPosition lista8 '?')
      --     lista10 = snd $ zameni lista7 lista8 (charAtPosition lista8 '?')





      --     colored_path0 = lista9
      --     colored_path1 = tail colored_path0
      --     colored_path2 = tail colored_path1 
      --     colored_path3 = tail colored_path2
      --     colored_path4 = tail colored_path3 
      --     colored_path5 = tail colored_path4 
      --     colored_path6 = tail colored_path5 

      --     bord = lista10
      --     bord1 = tail bord
      --     bord2 = tail bord1
      --     bord3 = tail bord2
      --     bord4 = tail bord3
      --     bord5 = tail bord4
      --     bord6 = tail bord5

      -- putStrLn []
      -- putStrLn $ head bord
      -- putStrLn $ head bord1
      -- putStrLn $ head bord2
      -- putStrLn $ head bord3
      -- putStrLn $ head bord4
      -- putStrLn $ head bord5
      -- putStrLn $ head bord6
      -- putStrLn []
      -- putStrLn $ head colored_path0
      -- putStrLn $ head colored_path1
      -- putStrLn $ head colored_path2
      -- putStrLn $ head colored_path3
      -- putStrLn $ head colored_path4
      -- putStrLn $ head colored_path5
      -- putStrLn $ head colored_path6

      -- print $ charAtPosition lista8 '?'

      
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
    
    
