module Main where

import Dagoba
import Data.Function ((&))
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = describe "Dagoba" $ do
    let graph = empty
            & addVertices
                [ vertex 1 "Me"
                , vertex 2 "Mom"
                , vertex 3 "Dad"
                , vertex 4 "Bro"
                , vertex 5 "Uncle"
                , vertex 6 "Cuz"
                , vertex 7 "Gran"
                ]
            & addEdges
                [ 2 `to` 1, 3 `to` 1
                , 2 `to` 4, 3 `to` 4
                , 7 `to` 2, 7 `to` 5
                , 5 `to` 6
                ]

        queryValues = map vValue . runQuery graph

    it "has a primitive query DSL" $ do
        queryValues (val "Me" >> out)
            `shouldBe` ["Mom", "Dad"]

        queryValues (val "Mom" >> in_)
            `shouldBe` ["Me", "Bro"]

        queryValues (val "Me" >> out >> in_)
            `shouldBe` ["Me", "Bro", "Me", "Bro"]

        queryValues (val "Me" >> out >> out >> in_ >> in_)
            `shouldBe` ["Me", "Bro", "Cuz"]
