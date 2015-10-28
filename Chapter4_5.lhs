Chapter 4.5
===========
Induction on lists

> module Chapter4_5 where

> import Prelude hiding (sum, (++), length, map, (.), foldr)

> sum :: Num a => [a] -> a
> sum [] = 0
> sum (x:xs) = x + sum xs

> (++) :: [a] -> [a] -> [a]
> [] ++ xs 		= xs
> (x:xs) ++ ys  = x : (xs ++ ys)

> length :: [a] -> Integer
> length [] = 0
> length (x:xs) = 1 + length xs

> map :: (a -> b) -> [a] -> [b]
> map _ [] 	 = []
> map f (x:xs) = f x : map f xs

> (.) :: (b -> c) -> (a -> b) -> (a -> c)
> (f . g) x = f (g x)

> foldr :: (a -> b -> b) -> b -> [a] -> [b]
> foldr _ x [] = x
> foldr f x (y:ys) = f y (foldr f x ys)

> concat :: [[a]] -> [a]
> concat [] = []
> concat (x:xs) = x ++ (concat xs)



Theorem 15
----------
`sum (xs ++ ys) = sum xs + sum ys`




Induction over xs

**Base case**  

	  sum (xs ++ ys)
	= sum ([] ++ ys) 		
	= sum ys 			 { (++).1 }
	= 0 + sum ys	     { sum.1 }
	= sum [] + sum ys    { sum.1 }
	= sym ys 			 { arithmetic }
												☐

**Inductive case**  
Assume `sum (xs ++ ys) = sum xs + sum ys`  
Proof  `sum ((x:xs) ++ ys) = sum (x:xs) + sum ys`

	  sum ((x:xs) ++ ys)
	= sum (x : (xs ++ ys)) 		{ (++).2 }
	= x + sum (xs ++ ys) 		{ sum.2 }
	= x + sum xs + sum ys 		{ hypothesis }
	= sum (x:xs) + sum ys 		{ sum.2 }
												☐	


Theorem 16
----------
`length (xs ++ ys) = length xs + length ys`

Proof by induction over xs
**Base Case**  

	  length ([] ++ ys)
	= length ys 			{ (++).1 }
	= 0 + length ys 		{ 0 + x = x}
	= length [] + length ys { length.1 }
										☐	

**Inductive case**  
Assume hypothesis `length (xs ++ ys) = length xs + length ys`  
Proof that `length ((x:xs) ++ ys) = length (x:xs) + length ys`

	  length ((x:xs) ++ ys)
	= length (x:xs) + length ys 	 { hypothesis }
										☐

Theorem 17
----------
`length (map f xs)) = length xs`

Proof by induction over xs
**Base case**  

	  length (map f []) 
	= length [] 		 { map.1 }		
													☐

**Inductive case**  
Assume `length (map f xs) = length xs`  
Proof that `length (map f (x:xs)) = length (x:xs)`
	
	  length (map f (x:xs))
	= length (f x : map f xs) 		{ map.2 }
	= 1 + length (map f xs) 		{ length.2 }
	= 1 + length xs 				{ hypothesis }
	= length (x:xs) 				{ length. 2}
													☐

Theorem 18
----------
`map f (xs ++ ys) = map f xs ++ map f ys`  
Proof by induction over xs

**Base case**  

	  map f ([] ++ ys)
	= map f ys 						{ (++).1 }
	= [] ++ map f ys 				{ (++).1 }
	= map f [] ++ map f ys 			{ map.1 }
													☐

**Inductive case**  
Assume `map f (xs ++ ys) = map f xs ++ map f ys`  
Proof that `map f ((x:xs) ++ ys) = map f (x:xs) ++ map f ys`

	  map f ((x:xs) ++ ys)
	= map f (x : (xs ++ ys)) 		{ (++).2 }
	= f x : map f (xs ++ ys) 		{ map.2 }
	= f x : (map f xs ++ map f ys)  { hypothesis }
	= (f x : map f xs) ++ map f ys 	{ (++).2 }
	= map f (x:xs) ++ map f ys 		{ map.2 }
													☐

Theorem 19
----------
`(map f . map g) xs = map (f . g) xs`  
Induction over xs 

**Base case**

	  (map f . map g) []
	= \x -> map f (map g x) 	  { (.).1 }
	= map f (map g []) 			  { application }
	= map f [] 					  { map.1 }
	= [] 						  { map.1 }
	= map (f . g) [] 			  { map.1 }
												☐	

**Inductive case**  
Assume `(map f . map g) xs = map (f . g) xs`  
Proof that `(map f . map g) (x:xs) = map (f . g) (x:xs)`

	  (map f . map g) (x:xs)
    = map f (map g (x:xs)) 					{ (.).1 }
	= map f (g x : map g xs) 		 		{ map.2 }
	= f (g x) : map f (map g xs) 	 		{ map.2 }
	= f (g x) : (map f . map g) xs 			{ (.).1 }
	= f (g x) : map (f . g) xs 				{ hypothesis }
	= (f . g) x : map (f . g) xs 			{ (.).1 }
	= map (f . g) (x:xs) 					{ map.2 }
												☐											
	

Theorem 20
----------
`sum (map (1+) xs) = length xs + sum xs`  
Induction over xs

**Base case**

	  sum (map (1+) [])
	= sum [] 				{ map.1 }
	= 0  					{ sum.0 }
	= 0 + sum [] 			{ 0 + x = x }
	= length [] + sum [] 	{ length.1 }
											☐
**Inductive case**  
Assume `sum (map (1+) xs) = length xs + sum xs`  
Proof  `sum (map (1+) (x:xs) = length (x:xs) + sum (x:xs)`

	  sum (map (1+) (x:xs))
	= sum (1 + x : map (1+) (x:xs))	 		{ map.2 }
	= (1 + x) + sum (map (1+) xs) 		{ sum.2 }
	= (1 + x) + length xs + sum xs 		{ hypothesis }
	= (1 + length xs) + (x + sum xs) 	{ associative (+) }
	= length (x:xs)   + sum (x:xs) 		{ length.2, sum.2 }
											☐

Theorem 21
----------
`foldr (:) [] xs = xs`  
Induction over xs

**Base case**  

	  foldr (:) [] [] = []
	= [] 						{ foldr.1 }
											☐

**Inductive case**  
Assume `foldr (:) [] xs = xs`
Proof  `foldr (:) [] (x:xs) = (x:xs)`

	  foldr (:) [] (x:xs)
	= x : (foldr (:) [] xs) 	{ foldr.2 }
	= (x:xs)
											☐

Theorem 22
----------
`map f (concat xss) = concat (map (map f) xss)`
Induction over xss

**Base case**  

	  map f (concat [])
	= map f [] 						{ concat.1 }
	= concat (map f []) 			{ concat.1 }
	= concat (map (map f) xss) 		{ map.1 }
											☐
**Inductive case**  
Assume hypothesis `map f (concat xss) = concat (map (map f) xss)`
Proof that `map f (concat (xs:xss)) = concat (map (map f) (xs:xss))`

	  map f (concat (xs:xss))
	= map f (xs ++ concat xss) 				  		 { concat.2 }
	= map f xs ++ map f (concat xss) 		  		 { Theorem 18 }
	= map f xs ++ concat (map (map f) xss) 	  		 { hypothesis }
	= concat (map f xs ++ concat (map (map f) xss))  { concat.2 }
	= concat (map (map f) xss) 						 { map.2 }
											☐

Theorem 23
----------
`length (xs ++ (y:ys)) = 1 + length xs + length ys`
Instead of proving by induction, we can simply reuse a previous theorem
`length (xs ++ ys) = length xs + length ys` to reorganize the equation
into a proof

	  length (xs ++ (y:ys))
	= length xs + length (y:ys)  { theorem above }
	= length xs + 1 + length ys  { length.2 }
	= 1 + length xs + length ys
											☐


Exercises
---------

**Exercise 8**  
*Recall theorem 20 which says*
	
	sum (map (1+) xs) = length xs + sum xs

*Explain in English what this theorem says. Using the definitions
of the functions involved (sum, length and map), calculate the 
values of the left and right-hand sides of the equation using 
xs = [1,2,3,4]*

In English: Adding 1 to every number in a set of numbers,
and then summing this set of numbers, equals the length
of this set plus the sum of the original set of numbers

Left side:  
	
	  sum (map (1+) [1,2,3,4])
	= sum (1 + 1 : map (1+) [2,3,4])
	= sum (1 + 1 : 1 + 2 : map (1+) [3,4])
	= sum (1 + 1 : 1 + 2 : 1 + 3 : map (1+) [4])
	= sum (1 + 1 : 1 + 2 : 1 + 3 : 1 + 4 : map (1+) [])
	= sum (1 + 1 : 1 + 2 : 1 + 3 : 1 + 4 : [])
	= sum [2,3,4,5]
	= 2 + sum [3,4,5]
	= 2 + 3 + sum [4,5]
	= 2 + 3 + 4 + sum [5]
	= 2 + 3 + 4 + 5 + sum []
	= 2 + 3 + 4 + 5 + 0
	= 14
	
Right side:

	  length [1,2,3,4] + sum [1,2,3,4]
	= 1 + length [2,3,4] + 1 + sum [2,3,4]
	= 1 + 1 + length [3,4] + 1 + 2 + sum [3,4]
	= 2 + 1 + length [4] + 3 + 3 + sum [4]
	= 3 + 1 + length [] + 6 + 4 + sum []
	= 4 + 0 + 10 + 0
	= 14

**Exercise 9**  
*Invent a new theorem similar to Theorem 20, where (1+)
is replaced by (k+). Test it on one or two small examples.
Then prove your theorem*

Theorem: `sum (map (k+) xs) = k * length xs + sum xs`

Example 1: `[2,3]`

	  sum (map (k+) [2,3])
	= sum (k + 2 : map (k+) [3])
	= sum (k + 2 : k + 3 : map [])
	= sum (k + 2 : k + 3 : [])
	= sum [k+2, k+3]
	= k+2 + sum [k+3]
	= k + 2 + k + 3 + sum []
	= k + 2 + k + 3 + 0
	= 2 * k + 5
	
	  k * length [2,3] + sum [2,3]
	= k * 2 + 5
	= 2 * k + 5
	
**Proof by induction**  
_Base case:_  

	  sum (map (k+) [])
	= sum []
	= 0
	= k * length [] + sum []
	= k * 0
	= 0

_Induction case:_  
Assume that `sum (map (k+) xs) = k * length xs + sum xs`.  
Proof that  `sum (map (k+) (x:xs) = k * length (x:xs) + sum (x:xs)`

	  sum (map (k+) (x:xs))
	= sum (k + x : map (k+) xs) 			{ map.2 }
	= k + x + sum (map (k+) xs) 			{ sum.2 }
	= k + x + k * length xs + sum xs 		{ hypothesis }
	= k + k * length xs + sum (x:xs) 		{ algebra }
	= k * (1 + length xs) + sum (x:xs) 		{ algebra }
	= k * length (x:xs) + sum (x:xs) 		{ length.2 }
											☐	

