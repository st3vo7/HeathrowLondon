module Colored where

import Data.List
import Data.Maybe

head' :: [a] -> Maybe a
head' []     = Nothing
head' (x:xs) = Just x


inic_tabela = ["","","","",""]

ispeglaj :: [(String,String)]-> [String]
ispeglaj [] = []
ispeglaj (x:xs) = (fst(x) ++ snd(x)) : ispeglaj xs 

ceovi :: [String]->[String]
ceovi [] = []
ceovi (x:xs) = promeni_zadnji x : ceovi xs

promeni_zadnji:: String -> String
promeni_zadnji x = reverse ('?' :  (tail $ reverse x))

--ovo je moglo lakse (bez  maybeToList-a) samo da sam prvo obradio slucaj
--kada je lista xs prazna (inace head xs puca) ali neka ga za sad ovako. 
napravi_novu :: [String] -> String -> [String]
napravi_novu tabela xs
    | maybeToList (head' xs) == ['B'] = napravi_novu ( ispeglaj $ zip tabela ["###o","___*","___*","___*","???o"]) (tail xs)
    | maybeToList (head' xs) == ['A'] = napravi_novu ( ispeglaj $ zip tabela ["???o","___*","___*","___*","###o"]) (tail xs)
    | maybeToList (head' xs) == ['C'] = napravi_novu ( reverse( last(tabela) : reverse (head(tabela) : ceovi(take 3 $ repeat $ tabela !! 1))) ) (tail xs)
    | otherwise = tabela
