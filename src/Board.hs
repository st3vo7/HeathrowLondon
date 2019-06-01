module Board where
  
import qualified Config
import qualified Pictures

import Graphics.Gloss

import Data.Maybe
import Data.List

data Field = RoadH | RoadV | BlankF | Node deriving (Show, Eq)

-- Funkcije za prikaz na tabli

fieldForChar :: Char -> Field
fieldForChar '#' = RoadH
fieldForChar '*' = RoadV
fieldForChar 'o' = Node
fieldForChar  _  = BlankF


--mapira redove karaktera iz tabele u tipove
boardFields = [ map fieldForChar row
                | row <- Config.boardData ]

--mapira tipove u slike
fieldPicture RoadH = Pictures.roadH
fieldPicture RoadV = Pictures.roadV
fieldPicture Node = Pictures.node
fieldPicture BlankF = Pictures.blank

--------------------------------------------------------------------------------------------------------------
--tek kad proradi png od gloss gejma

--rowPicture :: [Field] -> Picture
--rowPicture fields =
--    let combine = \ current previous -> pictures [
--                translate Config.blockSize 0 previous,
--                current ]
--    in  foldr1 combine $ map fieldPicture fields

--picture :: Picture
--picture = let combine = \ current previous -> pictures [ translate 0 Config.blockSize previous, current ]
--          in  foldl1 (flip combine) $ map rowPicture boardFields

---------------------------------------------------------------------------------------------------------------
