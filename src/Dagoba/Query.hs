module Dagoba.Query
    ( Query
    , runQuery
    , val
    , out
    , in_
    ) where

import Dagoba.Elements
import Dagoba.Graph

import Control.Monad.Reader
import Control.Monad.State
import Data.Maybe (mapMaybe)

type Query a = StateT [Vertex a] (Reader (Graph a)) ()

runQuery :: Graph a -> Query a -> [Vertex a]
runQuery g f = runReader (execStateT f []) g

val :: Eq a => a -> Query a
val a = put . filterVertices (== a) =<< ask

out :: Query a
out = followEdges vOut eIn

in_ :: Query a
in_ = followEdges vIn eOut

followEdges :: (Vertex a -> [Edge]) -> (Edge -> Id) -> Query a
followEdges fv fe = do
    g <- ask
    modify $ mapMaybe (findVertextById g . fe) . concatMap fv
