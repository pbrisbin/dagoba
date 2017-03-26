module Dagoba.Elements
    ( Id
    , Vertex(..)
    , vertex
    , Edge(..)
    , to
    ) where

type Id = Int

data Vertex a = Vertex
    { vId :: Id
    , vValue :: a
    , vIn :: [Edge]
    , vOut :: [Edge]
    }

vertex :: Id -> a -> Vertex a
vertex i a = Vertex i a [] []

data Edge = Edge
    { eIn :: Id
    , eOut :: Id
    }

to :: Id -> Id -> Edge
to = Edge
