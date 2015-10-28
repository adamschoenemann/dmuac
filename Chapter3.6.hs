module Chapter3_6 where

import Chapter3_2 (containedIn)

intersection :: Eq a => [a] -> [a] -> [a]
intersection _ [] = []
intersection [] _ = []
intersection xs ys = filter (\x -> x `containedIn` ys) xs

isSubset :: Eq a => [a] -> [a] -> Bool
isSubset _ [] = False
isSubset [] _ = False
isSubset xs ys = all (==True) (check xs ys)
	where
		check [] _ = []
		check xs ys = map (\x -> any (== x) ys) xs

isSorted :: (Ord a, Eq a) => [a] -> Bool
isSorted xs = all (== True) $ isSorted' xs where
	isSorted' [] = []
	isSorted' [x] = []
	isSorted' (x:x':xs)
		| x <= x'   = True : isSorted' (x':xs)
		| otherwise = [False]

factorial :: Int -> Int
factorial 1 = 1
factorial n = n * (factorial $ n - 1)

factorial' :: Int -> Int
factorial' n = foldr (*) 1 [1..n]

last' :: [a] -> Maybe a
last' [] = Nothing
last' [x] = Just x
last' (x:xs) = last' xs

intPart :: String -> String
intPart [] = []
intPart ('.':xs) = []
intPart (x:xs) = x : intPart xs

fracPart :: String -> String
fracPart [] = []
fracPart ('.':xs) = xs
fracPart (x:xs)   = fracPart xs

