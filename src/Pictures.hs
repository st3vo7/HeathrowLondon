module Pictures where

import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Game
import Graphics.Gloss

road   = png "data/road.png"
blank  = png "data/blank.png"

itemPicture what = pictures [ color white $ rectangleWire 32 32, png ("data/" ++ what ++ "-001.png") ]