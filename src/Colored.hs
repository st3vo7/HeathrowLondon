module Colored where

import Data.List

inic_tabela = ["","","","","","",""]

ispeglaj :: [(String,String)]-> [String]
ispeglaj [] = []
ispeglaj (x:xs) = (fst(x) ++ snd(x)) : ispeglaj xs 

ceovi :: [String]->[String]
ceovi [] = []
ceovi (x:xs) = promeni_zadnji x : ceovi xs

promeni_zadnji:: String -> String
promeni_zadnji x = reverse ('?' :  (tail $ reverse x))

napravi_novu :: [String] -> String -> [String]
napravi_novu tabela xs
    | xs == [] = tabela
    | head xs == 'B' = napravi_novu ( ispeglaj $ zip tabela ["####o","____*","____*","____*","____*","____*","????o"]) (tail xs)
    | head xs == 'A' = napravi_novu ( ispeglaj $ zip tabela ["????o","____*","____*","____*","____*","____*","####o"]) (tail xs)
    | head xs == 'C' = napravi_novu ( reverse( last(tabela) : reverse (head(tabela) : ceovi(take 5 $ repeat $ tabela !! 1))) ) (tail xs)
    | otherwise = tabela

izmeni_novu :: [String] -> [String]
izmeni_novu t = (take 3 t) ++ [map (\x -> if x == '_' then '_' else '-') (t !! 3)] ++ reverse((take 3 (reverse t)))
