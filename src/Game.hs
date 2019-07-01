module Game where

import Data.List
import Data.Maybe

import qualified Config
import Debug.Trace


import Graphics.Gloss.Game


data Mode = ModeSplash | ModeAnimate | ModeEnd deriving (Show,Eq)


data State = State  { cene_trojki :: [[Int]]
                    , mode :: Mode
                    , windowSize :: (Int,Int)
                    , contentScale :: Float
                    , pocetna_tabla :: [String]
                    , krajnja_tabla :: [String]
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

update :: Float -> State -> State
update seconds oldState = oldState { pocetna_tabla = fst (zameni (pocetna_tabla oldState) (krajnja_tabla oldState)),
                                     krajnja_tabla = snd (zameni (pocetna_tabla oldState) (krajnja_tabla oldState))
                                   }


                                                  
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


zameni::[String] -> [String] -> ([String],[String]) 
zameni prva druga
    | (i == 0) = (setAorB prva druga par) 
    | (i == 6) = (setAorB prva druga par)
    | otherwise = (setC prva druga par)
      where i = fst $ charAtPosition druga '?'
            par = charAtPosition druga '?'

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


    

    
    
