Foooo!
Chapter 4
=========

> module Chapter4 where
> import Chapter3_3
> import Test.QuickCheck

Theorem 9
---------
`sub (add x y) y = y`

**Base case**  
Induction over x

	sub (add Zero y) Zero = sub y Zero = y

**Inductive case**  
Assume hypothesis `sub (add x y) y = y`

	  sub (add (Succ x) y) (Succ x)
	= sub (Succ (add x y)) (Succ x) 	{ add.2 }
	= sub (add x y) x 					{ sub.3 }
	= y 								{ hypothesis }


Theorem 10
----------
Add is associative `add x (add y z) = add (add x y) z`

**Base case**  
Induction over x.

	  add Zero (add y z) = add (add Zero y) z
	= add y z 			 = add y z

**Inductive case**  
Proof `add (Succ x) (add y z) = add (add (Succ x) y) z`
Assume hypothesis `add x (add y z) = add (add x y) z`

	  add (Succ x) (add y z)
	= Succ (add x (add y z)) 	{ add.2 }
	= Succ (add (add x y) z)	{ hypothesis }
	= add (Succ (add x y) z)    { add.2 }
	= add (add (Succ x) y) z 	{ add.2 }

Theorem 11
----------
`add x Zero = x`

**Base case**  
`add Zero Zero = Zero`

**Inductive case**  
Assume hypothesis `add x Zero = x`
Proof `add (Succ x) Zero = Succ x`

	  add (Succ x) Zero
	= Succ (add x Zero) { add.1 }
	= Succ Zero 		{ hypothesis }


Theorem 12
----------
`add (Succ x) y = add x (Succ y)`

**Base case**  
Induction over x

	  add (Succ Zero) y
	= Succ (add Zero y) { add.2 }
	= Succ y 			{ add.1 }
	= add Zero (Succ y) { add.1 }

**Induction**  
Assume hypothesis `add (Succ x) y = add x (Succ y)`
Proof that `add (Succ (Succ x)) y = add (Succ x) (Succ y)`

	  add (Succ (Succ x)) y
	= Succ (add (Succ x) y)    { add.2 }
	= Succ (add x (Succ y))    { hypothesis }
	= add (Succ x) (Succ y)    { add.2 }

> prop_theorem12 x y = add (Succ x) y == add x (Succ y)

Theorem 13
----------
Add is commutative
`add x y = add y x`
Proof by induction over x

**Base case**  

	  add Zero y
	= y
	= add y Zero

**Inductive case**  
`add (Succ x) y = add y (Succ x)`

	  add (Succ x) y
	= Succ (add x y)   { add.2 }
	= Succ (add y x)   { hypothesis }
	= add (Succ y) x   { add.2 }
	= add y (Succ x)   { Theorem 12 }

> prop_commutative x y = add x y == add y x

> main = do
>    quickCheck prop_theorem12;
> 	 quickCheck prop_commutative