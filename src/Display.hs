module Display ( showAt,
                 board,
                 boardValuesA,
                 boardValuesB,
                 boardValuesC,
                 rowTextPicture
               ) where

import qualified Board
--import qualified Game
import Config
import qualified Pictures as P

import Graphics.Gloss
import Graphics.Gloss.Game

--vraca sliku sa novim koordinatama
showAt :: Board.Position -> Picture -> Picture
showAt (x, y) = translate (blockSize * x + boardOffsetHorizontal) (blockSize * y + boardOffsetVertical)

showAtA :: Board.Position -> Picture -> Picture
showAtA (x, y) = translate (blockSize * x - boardOffsetHorizontal) (blockSize * y + boardOffsetVertical)

showAtB :: Board.Position -> Picture -> Picture
showAtB (x, y) = translate (blockSize * x + boardOffsetHorizontal) (blockSize * y + boardOffsetVertical)

showAtC :: Board.Position -> Picture -> Picture
showAtC (x, y) = translate (blockSize * x + boardOffsetHorizontal) (blockSize * y + boardOffsetVertical)

--prikazuje celu tablu
board :: Picture
board = showAt (0, 0) Board.picture



--za mapiranje vrednosti cena u slike
boardValuesA :: [[Char]] -> Picture
boardValuesA values = showAtA (-19, -1) $ rowPicture $ rowTextPicture values

boardValuesB :: [[Char]] -> Picture
boardValuesB values = showAtB (1.25, 6.5) $ rowPicture $ rowTextPicture values 

boardValuesC :: [[Char]] -> Picture
boardValuesC values = showAtC (3.7, 2.7) $ rowPicture $ rowTextPicture values 
--
rowTextPicture::[[Char]] -> [Picture]
rowTextPicture prices = let pics = map text prices
						in map (scale 0.15 0.15) pics



rowPicture :: [Picture] -> Picture
rowPicture values =
    let combine = \ current previous -> pictures [
                translate Config.gap 0 previous,
                current ]
    in  foldr1 combine values


--fullImage :: Picture -> (Int, Int) -> Picture
--fullImage picture windowSize =
--           let (_, (picWidth, picHeight)) = boundingBox picture
--               (winWidth, winHeight)      = (fromIntegral $ fst windowSize, fromIntegral $ snd windowSize)
--               horizontalScale            = winWidth / picWidth
--               verticalScale              = winHeight / picHeight
--               scaleFactor                = max horizontalScale verticalScale
--           in scale scaleFactor scaleFactor $ picture

--background windowSize = fullImage P.background windowSize

