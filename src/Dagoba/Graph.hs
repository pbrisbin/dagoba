module Dagoba.Graph
    ( Graph
    , empty
    , findVertextById
    , filterVertices
    , addVertices
    , addEdges
    ) where

import Dagoba.Elements

import Data.Maybe (fromMaybe)

import qualified Data.Map as M

newtype Graph a = Graph
    { gVerticesById :: M.Map Id (Vertex a) }

empty :: Graph a
empty = Graph M.empty

findVertextById :: Graph a -> Id -> Maybe (Vertex a)
findVertextById g i = M.lookup i $ gVerticesById g

filterVertices :: (a -> Bool) -> Graph a -> [Vertex a]
filterVertices p = M.elems . M.filter (p . vValue) . gVerticesById

addVertices :: [Vertex a] -> Graph a -> Graph a
addVertices = flip $ foldr addVertex

addEdges :: [Edge] -> Graph a -> Graph a
addEdges = flip $ foldr addEdge

-- N.B. clobbers existing values
addVertex :: Vertex a -> Graph a -> Graph a
addVertex v g = g
    { gVerticesById = M.insert (vId v) v $ gVerticesById g }

-- Returns graph as-is if identified vertices are not present
addEdge :: Edge -> Graph a -> Graph a
addEdge e@(Edge i o) g = fromMaybe g $ do
    evi <- findVertextById g i
    evo <- findVertextById g o

    let vertices =
            [ evi { vIn = e : vIn evi }
            , evo { vOut = e : vOut evo }
            ]

    return $ addVertices vertices g
