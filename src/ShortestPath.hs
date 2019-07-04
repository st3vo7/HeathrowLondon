module ShortestPath where

-- srb:
-- sam grafovski problem HeathrowToLondon se može pronaći u knjizi
-- 'Learn you a Haskell for Great Good!' autora Mirana Lipovače
-- (https://nostarch.com/lyah.htm)
-- kao i u elektronskom formatu na linku 
-- http://learnyouahaskell.com/functionally-solving-problems#heathrow-to-london

-- Kod ovog fajla preuzet sa https://github.com/Robertcdelfin/CS2650_Project3_HeathrowToLondon
-- i predstavlja algoritamsku okosnicu rešenja ovog problema
-- dok je akcenat izrade ovog projekta stavljen na grafičku reprezentaciju pomenutog problema.

-- eng:
-- The simple graph problem HeathrowToLondon itself can be found in the book
-- 'Learn you a Haskell for Great Good!' authored by Miran Lipovaca
-- (https://nostarch.com/lyah.htm)
-- and also as an e-book on
-- http://learnyouahaskell.com/functionally-solving-problems#heathrow-to-london

-- Code in this file was downloaded from https://github.com/Robertcdelfin/CS2650_Project3_HeathrowToLondon
-- and it represents the backbone of solution to this problem,
-- whilst the essence of this project is based on the graphical representation of the mentioned problem.








--sekcija predstavlja  deo puta A, deo puta B paralelnog sa A i deo puta C koji povezuje A i B
data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)



-- lista sekcija koja predstavlja sve moguće deonice puta od Heathrowa do Londona
type RoadSystem = [Section]


--deonica puta - enum za A,B,C
data Label = A | B | C deriving (Show)
--deonica puta, cena prolaska tim delom  - GRANA
type Path = [(Label, Int)]


-- uzima doisadasnje najbolje napravljene puteve i predstojecu sekciju i racuna put za korak (sekciju) dalje
roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
		--dosadasnji putevi do A,B (suma cena)
      let priceA = sum $ map snd pathA
          priceB = sum $ map snd pathB
		  --prolaz do sledeceg A -> pravo, preko B i C
          fowardPriceToA = priceA + a
          crossPriceToA = priceB + b + c
		  		  --prolaz do sledeceg B -> pravo, preko A i C
          fowardPriceToB = priceB + b
          crossPriceToB = priceA + a + c
		  --ispitujemo da li je bolje koristiti crossroad ili ici pravo i apdejtujemo put
          newPathToA = if fowardPriceToA <= crossPriceToA
                          then (A,a):pathA
                          else (C,c):(B,b):pathB
          newPathToB = if fowardPriceToB <= crossPriceToB
                          then(B,b):pathB
                          else(C,c):(A,a):pathA
      in (newPathToA, newPathToB)
--dobijamo  uredjeni par:  lista grana kuda treba ici, S KRAJA liste KA POCETKU - 1. A 2. B


--Optimization tip: when we do priceA = sum $ map snd pathA, we're calculating the price from the path on every step.
-- We wouldn't have to do that if we implemented roadStep as a (Path, Path, Int, Int) -> Section -> (Path, Path, Int, Int)
-- function where the integers represent the best price on A and B.

 

optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
      let (bestAPath, bestBPath) = foldl roadStep ([],[]) roadSystem
      in  if sum (map snd bestAPath) <= sum (map snd bestBPath)
             then reverse bestAPath
             else reverse bestBPath

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)
