module Chapter3_2 where

import Prelude hiding(map, zipWith)

map :: (a -> b) -> [a] -> [b]
map _ [] 	  = []
map f (x:xs) = f x : map f xs

zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith _ [] _ = []
zipWith _ _ [] = []
zipWith f (x:xs) (y:ys) = f x y : (zipWith f xs ys)

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ x [] 	  = x
foldr' f x (y:ys) = f y (foldr' f x ys)

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ x [] 	  = x
foldl' f x (y:ys) = foldl' f (f x y) ys

foldrWith :: (a -> b -> c -> c) -> c -> [a] -> [b] -> c
foldrWith _ z [] _ = z
foldrWith _ z _ [] = z
foldrWith f z (x:xs) (y:ys) = let z' = f x y z in foldrWith f z' xs ys

concat' :: [[a]] -> [a]
concat' x = foldr (++) [] x

mappend :: (a -> b) -> [[a]] -> [b]
mappend f xss = foldr' (\xs acc -> (foldr' (\x acc' -> f x : acc') [] xs) ++ acc) [] xss

removeDuplicates :: Eq a => [a] -> [a]
removeDuplicates [] = []
removeDuplicates (x:xs) = x : filter (/= x) (removeDuplicates xs) where

containedIn :: Eq a => a -> [a] -> Bool
containedIn _ [] = False
containedIn x (y:ys) = if x == y then True else containedIn x ys
