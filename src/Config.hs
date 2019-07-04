module Config where

windowSize = (800,800) :: (Int,Int)

windowPosition = (300,300) :: (Int,Int)

blockSize = 30 :: Float

gap = 150 :: Float


boardHeight = length boardData

boardWidth = length $ boardData !! 0


boardOffsetVertical   = - blockSize / 2.0 * (fromIntegral boardHeight)
boardOffsetHorizontal = - blockSize / 2.0 * (fromIntegral boardWidth)


boardData = ["####o####o####o####o",
             "____*____*____*____*",
             "____*____*____*____*",
             "____-____-____-____-",
             "____*____*____*____*",
             "____*____*____*____*",
             "####o####o####o####o"]
