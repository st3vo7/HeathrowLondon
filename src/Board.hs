module Board where
  
import qualified Config
import qualified Pictures
import qualified Game

import Graphics.Gloss

import Data.Maybe
import Data.List

data Field = RoadH | RoadV | BlankF | Node | White | RedRoad deriving (Show, Eq)
type Position = (Float, Float)

-- Funkcije za prikaz na tabli

fieldForChar :: Char -> Field
fieldForChar '#' = RoadH
fieldForChar '*' = RoadV
fieldForChar 'o' = Node
fieldForChar '-' = White 
fieldForChar '_'  = BlankF
fieldForChar '?' = RedRoad



--mapira redove karaktera iz tabele u tipove
boardFields state = [ map fieldForChar row
                | row <- Game.pocetna_tabla state ]

--mapira tipove u slike
fieldPicture RoadH = Pictures.roadH
fieldPicture RoadV = Pictures.roadV
fieldPicture Node = Pictures.node
fieldPicture BlankF = Pictures.blank
fieldPicture White = Pictures.whiteB
fieldPicture RedRoad = Pictures.redRoad
--------------------------------------------------------------------------------------------------------------
--tek kad proradi png od gloss gejma

--polje u sliku mapira
--tj jedan niz (horizontalno) polja
rowPicture :: [Field] -> Picture
rowPicture fields =
    let combine = \ current previous -> pictures [
                translate Config.blockSize 0 previous,
                current ]
    in  foldr1 combine $ map fieldPicture fields


--sve u jednu sliku smesta
--tako sto vertikalno kombinuje sve ove horizontalne
picture :: Game.State -> Picture
picture state = let combine = \ current previous -> pictures [ translate 0 Config.blockSize previous, current ]
                in  foldl1 (flip combine) $ map rowPicture ( boardFields state )




---------------------------------------------------------------------------------------------------------------
