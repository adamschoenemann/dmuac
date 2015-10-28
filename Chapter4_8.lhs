> module Chapter4_8 where
> import Prelude hiding (reverse)

> reverse :: [a] -> [a]
> reverse [] = []
> reverse (x:xs) = reverse xs ++ [x]


Theorem 27
----------
`reverse . reverse = id`

Exercise 14
-----------
*State the requirements on finite lengt hthat the proof of P
impose on the arguments on `concat`, wher eP is defined as*

	P(n) = concat xss = foldr (++) [] xss

The length of xss must be finite, otherwise the operation would never terminate
and the result would never be reached.

Exercise 15
-----------
Check that theorem 27 hold for the argument [1,2,3]

	  reverse . reverse [1,2,3]
	= reverse (reverse [1,2,3])
	= reverse (reverse [2,3] ++ [1])
	= reverse (reverse [3] ++ [2] ++ [1])
	= reverse ([3] ++ [2] ++ [1])
	= reverse [3,2,1]
	= reverse [2,1] ++ [3]
	= reverse [1] ++ [2] ++ [3]
	= [1] ++ [2] ++ [3]
	= [1,2,3]
	☐	

Exercise 16
-----------
Prove the following theorem, using induction

	reverse (xs ++ ys) = reverse ys ++ reverse xs

Then decide whether this theorem happens to be true for inifnite lists
like [1..]. Try to give a good argument for your conclusion, but you dont
have to prove it.

**Answer**  
Induction over xs
**Base case:**

	  reverse ([] ++ ys)
	= reverse ys 				{ (++).1 }
	= [] ++ reverse ys 			{ (++).1 }
	= reverse [] ++ reverse ys  { reverse.1 }
								☐	

**Inductive case:**  
Assume `reverse (xs ++ ys) = reverse ys ++ reverse xs`  
Prove that `reverse ((x:xs) ++ ys) = reverse ys ++ reverse (x:xs)`  

	  reverse ((x:xs) ++ ys)
	= reverse (x : (xs ++ ys)) 				{ (++).2 }
	= reverse (xs ++ ys) ++ [x]				{ reverse.2 }
	= (reverse ys ++ reverse xs) ++ [x] 	{ hypothesis }
	= reverse ys ++ (reverse xs ++ [x])		{ (++) associative }
	= reverse ys ++ reverse (x:xs)	 		{ reverse.2 }
											☐	

Exercise 17
-----------
Use induction to prove Theorem 27. `reverse (reverse xs) = xs`

**Base case**

	  reverse (reverse [])
	= reverse [] 				{ reverse.1 }
	= [] 						{ reverse.1 }
											☐	

**Inductive case**
Assume that `reverse (reverse xs) = xs`
Prove that  `reverse (reverse (x:xs) = (x:xs)`

	  reverse (reverse (x:xs))
	= reverse (reverse xs ++ [x]) 			{ reverse.2 }
	= reverse [x] ++ reverse (reverse xs)	{ Exercise 16 }
	= reverse [x] ++ xs 					{ hypothesis }
	= reverse (x:([] ++ xs)) 				{ (++).2 }
	= reverse (x:xs) 						{ (++).1 }
											☐	
											
Exercise 18
-----------
Explain why Theorem 27 does not hold for infinite lists.  
**Answer**  
Reversing an infinite list will never terminate.
