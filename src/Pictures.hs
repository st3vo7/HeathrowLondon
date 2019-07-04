module Pictures where

import Graphics.Gloss
import Graphics.Gloss.Data.Picture
import Graphics.Gloss.Game


roadH = png "data/roadh.png"
roadV = png "data/roadv.png"
node =  png "data/node.png"
blank = png "data/blank.png"
redRoadH = png "data/redroadH.png"
redRoadV = png "data/redroadV.png"

splash = png "data/HTL_splash.png"
end = png "data/HTL_end.png"

whiteB = color white $ scale 0.01 0.01 (text "0")


