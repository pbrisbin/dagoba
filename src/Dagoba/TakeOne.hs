module Dagoba.TakeOne where

v :: [Int]
v = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 ]

e :: [(Int, Int)]
e = [ (1,2), (1,3),  (2,4),  (2,5),  (3,6),  (3,7),  (4,8)
    , (4,9), (5,10), (5,11), (6,12), (6,13), (7,14), (7,15)
    ]

parents :: [Int] -> [Int]
parents vertices = foldr go [] e
  where
    go (parent, child) acc
        | child `elem` vertices = acc ++ [parent]
        | otherwise = acc

children :: [Int] -> [Int]
children vertices = foldr go [] e
  where
    go (parent, child) acc
        | parent `elem` vertices = acc ++ [child]
        | otherwise = acc

main :: IO ()
main = print
    $ children
    $ children
    $ children
    $ parents
    $ parents
    $ parents
    $ [8]
