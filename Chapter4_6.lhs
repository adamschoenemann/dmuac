4.6 unctional Equality
=======================
Theorem 25
----------
`map f . concat = concat (map (map f))`

Exercise 10
-----------
Prove Theorem 25

	  map f . concat xss  							{ arb. xss } 
	= map f (concat xss) 							{ (.).1 }
	= concat (map (map f)) xss 						{ Theorem 22 }
													☐	

Exercise 11
-----------
Proof that the `(++)` operator is associative, i.e.
`(xs ++ ys) ++ zs = xs ++ (ys ++ zs)`  
Proof by induction over xs:

**Base case**

	  ([] ++ ys) ++ zs
	= ys ++ zs 				{ (++).1 }
	= [] ++ (ys ++ zs) 		{ (++).1 }
							☐	
							
**Inductive case**
Assume hypothesis `(xs ++ ys) ++ zs = xs ++ (ys ++ zs)`  
Proof that `((x:xs) ++ ys) ++ zs = (x:xs) ++ (ys ++ zs)`
	  
	  ((x:xs) ++ ys) ++ zs
	= (x : (xs ++ ys)) ++ zs 		{ (++).2 }
	= x : ((xs ++ ys) ++ zs) 		{ (++).2 }
	= x : (xs ++ (ys ++ zs)) 		{ hypothesis }
	= (x:xs) ++ (ys ++ zs) 			{ (++).2 }
									☐	
Exercise 12
-----------
Prove that `sum . map length = length . concat`  
Proof by induction  
**Base case**  

	  sum . map length []
	= sum (map length []) 			{ (.).1 }
	= sum [] 						{ map.1 }
	= 0								{ sum.1 }
	= length []						{ length. 1}
	= length (concat []) 			{ concat.1 }
	= length . concat [] 			{ (.).1 }
							☐	

**Inductive case**  
Assume that `sum (map length xss) = length (concat xss)`
Proof that `sum (map length (xs:xss) = length (concat (xs:xss))`

	  sum (map length (xs:xss))
	= sum (length xs : map length xss) 			{ map.2 }
	= length xs + sum (map length xss) 			{ sum.2 }
	= length xs + length (concat xss)			{ hypothesis }
	= length (xs ++ (concat xss))  				{ theorem 16 }
	= length (concat (xs:xss)) 					{ concat.2 }
												☐	
