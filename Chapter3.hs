module Chapter3 where

import Prelude hiding (lookup)
import Debug.Trace (trace)

copy :: [a] -> [a]
copy [] = []
copy (x:xs) = x : copy xs

inverse :: [(a,b)] -> [(b,a)]
inverse [] = []
inverse ((a,b):xs) = (b,a) : inverse xs

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x > y = y : merge (x:xs) ys
    | y > x = x : merge xs  (y:ys)
    | otherwise = x : merge xs  (y:ys)

(!!!) :: [a] -> Int -> Maybe a
[] !!! n           = Nothing
(x:xs) !!! 0       = Just x
(x:xs) !!! (n) = xs !!! (n - 1)

lookup :: Eq a => a -> [(a,b)] -> Maybe b
lookup _ [] = Nothing
lookup a ((k,v):xs) = if a == k
                      then Just v
                      else lookup a xs

count :: Eq a => a -> [a] -> Int
count _ [] = 0
count a (x:xs)
    | a == x = 1 + count a xs
    | otherwise = 0 + count a xs

dropWhere :: Eq a => a -> [a] -> [a]
dropWhere _ [] = []
dropWhere x (y:ys) = if x == y
                     then dropWhere x ys
                     else y : dropWhere x ys

removeAlt :: [a] -> [a]
removeAlt x = removeAlt' 0 x where
	removeAlt' _ [] 	= []
	removeAlt' n (x:xs) =
		case n `mod` 2 of
			0 -> removeAlt' (n+1) xs
			1 -> x : removeAlt' (n+1) xs

extract :: [Maybe a] -> [a]
extract [] 		        = []
extract ((Just x):xs)	= x : extract xs
extract (Nothing:xs) 	= extract xs


isInfixOf :: (Show a, Eq a) => [a] -> [a] -> Bool
[] `isInfixOf` _ 	  = True
_  `isInfixOf` [] 	  = False
xs `isInfixOf` (y:ys) =
	if xs `test` (y:ys)
		then True
		else xs `isInfixOf` ys

test :: (Show a, Eq a) => [a] -> [a] -> Bool
[] `test` _  = True
xs `test` [] = False
(x:xs) `test` (y:ys) =
	if x == y
		then xs `test` ys
		else False

strpos :: String -> String -> Maybe Int
strpos x y = strpos' 0 x y where
	strpos' _ [] _ = Nothing
	strpos' _ _ [] = Nothing
	strpos' i xs (y:ys) =
		if xs `isInfixOf` take (length xs) (y:ys)
			then Just i
			else strpos' (i+1) xs ys


