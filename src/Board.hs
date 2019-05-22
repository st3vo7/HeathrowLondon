module Board where
  
import qualified Config
import qualified Pictures

import Graphics.Gloss

import Data.Maybe
import Data.List

data Field = Road | Blank | Node deriving (Show, Eq)

-- Funkcije za prikaz na tabli

fieldForChar :: Char -> Field
fieldForChar '#' = Road
fieldForChar '*' = Road
fieldForChar 'o' - Node
fieldForChar  _  = Blank


--mapira karaktere iz tabele u tipove
boardFields = [ map fieldForChar row
                | row <- Config.boardData ]
--mapira tipove u slike
fieldPicture Road = Pictures.road
fieldPicture Blank = Pictures.blank

rowPicture :: [Field] -> Picture
rowPicture fields =
    let combine = \ current previous -> pictures [
                translate Config.blockSize 0 previous,
                current ]
    in  foldr1 combine $ map fieldPicture fields

picture :: Picture
picture = let combine = \ current previous -> pictures [ translate 0 Config.blockSize previous, current ]
          in  foldl1 (flip combine) $ map rowPicture boardFields
