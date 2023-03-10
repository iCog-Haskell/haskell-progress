-- https://exercism.org/tracks/haskell/exercises/hamming/

module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs ys
    | length xs /= length ys = Nothing
    | otherwise = Just $ length $ filter (uncurry (/=)) $ zip xs ys

