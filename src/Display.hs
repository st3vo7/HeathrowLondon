module Display ( showAt,
                background,
                board
               ) where

import qualified Board
--import qualified Game
import Config
import qualified Pictures as P

import Graphics.Gloss
import Graphics.Gloss.Game

showAt :: Board.Position -> Picture -> Picture
showAt (x, y) = translate (blockSize * x + boardOffsetHorizontal) (blockSize * y + boardOffsetVertical)

board :: Picture
board = showAt (0, 0) Board.picture

fullImage :: Picture -> (Int, Int) -> Picture
fullImage picture windowSize =
           let (_, (picWidth, picHeight)) = boundingBox picture
               (winWidth, winHeight)      = (fromIntegral $ fst windowSize, fromIntegral $ snd windowSize)
               horizontalScale            = winWidth / picWidth
               verticalScale              = winHeight / picHeight
               scaleFactor                = max horizontalScale verticalScale
           in scale scaleFactor scaleFactor $ picture

background windowSize = fullImage P.background windowSize

