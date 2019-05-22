module Config where

windowSize = (600,600) :: (Int,Int)

windowPosition = (300,300) :: (Int,Int)

blockSize = 32 :: Float


boardHeight = length boardData

boardWidth = length $ boardData !! 0


boardOffsetVertical   = - blockSize / 2.0 * (fromIntegral boardHeight)
boardOffsetHorizontal = - blockSize / 2.0 * (fromIntegral boardWidth)


boardData = ["###o###o###o###o",
             "___*___*___*___*",
             "___*___*___*___*",
             "___*___*___*___*",
             "###o###o###o###o"]
