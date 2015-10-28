> module Chapter4_10 where
> import Prelude hiding (or, and)

Chapter 4_10
============

Exercise 19
-----------
Assume that `xss` is a finite list of type `[[a]]`, that it is of length n
and that `xs` is a finite list and an arbitrar element of `xss`.
Prove that `length (concat xss) = sum (map length xss)`

**Base case**  

	  length (concat [])
	= length [] 				{ concat.1 }
	= 0							{ length.1 }
	= sum [] 					{ sum.1 }
	= sum (map length []) 		{ map.1 }
										☐	
	
**Inductive case**
Assume that `length (concat xss) = sum (map length xss)`  
Prove that  `length (concat (xs:xss) = sum (map length (xs:xss))`

	  length (concat (xs:xss))
	= length (xs ++ concat xss) 				{ concat.2 }
	= length xs + length (concat xss) 			{ Theorem 16 }
	= length xs + sum (map length xss) 			{ hypothesis }
	= sum (length xs : map length xss) 			{ sum.2 }
	= sum (map length (xs:xss)) 				{ map.2 }
												☐

Exercise 20
-----------	
Prove that `or` defined over an argument that has an arbitrary
number of elements delivers the value `True` if `True` occurs as one of
the elements of its argument.

> or :: [Bool] -> Bool
> or [] = False
> or (True:xs) = True
> or (x:xs) = or xs

We will prove that $or(xs) = True$ where $length(xs) > 0$ and $True \in xs$ 

**Base case**

	  or [True]
	= True
				☐	

**Inductive case**  
Assume hypothesis `or xs == True where length xs == 1 && True ∈ xs`

	  or (x:xs)
	= True 			{ if x == True }
	= or xs 		{ if x == False }
	= True 			{ hypothesis }
									☐	

Exercise 21
-----------
Prove that `and` defined over an argument that has an arbitrary
number of elements delivers the value `True` if all of the elements in its
argument are `True`

> and :: [Bool] -> Bool
> and [] = True
> and (False:xs) = False
> and (True:xs)  = True && and xs

**Base case** 
Assume `xs` is a `[Bool]` of length $(n + 1)$ and $False \notin xs$

	  and [True]
	= True && and [] 				{ and.3 }
	= True && True 					{ and.1 }
	= True 							{ (&&).2 }
									☐	

**Inductive case**
Assume hypothesis `and xs = True` where $False \notin xs$
	 
	  and (x:xs)
	= and (True:xs) 			{ constraint }
	= True && and xs 			{ and.3 }
	= True && True 				{ hypothesis }
	= True 						{ (&&).2 }
									☐	

Exercise 22
-----------
Assume there is a function called `max` that delivers the larger
of its two arguments.

	max x y = x 		if x >= y
	max x y = y 		if y >= x
	
Write a function `maximum` that, given a non-empty sequence of values
whose sizes can be compared (that is, values from a type of class `Ord`),
delivers the largest value in the sequence.

> maximum :: Ord a => [a] -> a
> maximum (x:xs) = foldr max x xs

Exercise 23
-----------
Assume that the list `xs` is of type `Ord a => [a]` and that `x`
is an arbitrary element of `xs`.  
Prove that `maximum` has the following property:  
`(maximum xs) >= x`

**Base case**  
Given an `xs = [x]`

	  maximum [x]
	= maximum (x:[]) 			{ (:).1 }
	= foldr max x [] 			{ maximum.1 }
	= x 						{ foldr.1 }
	= x >= x = True 			{ (>=).1 }
	
**Inductive case**
Assume `(maximum (x:xs)) >= x`  
Prove  `(maximum (x:x':xs) >= x`

	  maximum (x:x':xs)
	= foldr max x (x':xs) 		{ maximum.1 }
	= max x' (foldr max x xs) 	{ xs = (y:ys)}
	= max x' (maximum (x:xs)) 	{ maximum.1 }
	= if x' >= (maximum (x:xs))
		x 						{ case 1 }
	  else
	  	(maximum (x:xs)) 		{ case 2 }
	
	(maximum (x:xs)) is true by the hypothesis
	If case 1, then x' must be >= x
	Case 2 is proven by the hypothesis

Exercise 24
-----------
Write a function that, given a sequence containing only non-empty
sequences, delivers the sequence made up of the first elements
of each of thos non-empty sequences

> heads :: [[a]] -> [a]
> heads [] 	   = []
> heads ((x:xs):xss) = x : heads xss