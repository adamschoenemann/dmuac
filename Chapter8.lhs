8. Set Theory
=============

> {-# LANGUAGE FlexibleInstances #-}
> import Test.QuickCheck

Definition 18 (Subset)
----------------------
Let $A$ and $B$ be sets. Then $A ⊆ B$ if and only if

$$
    ∀x. (x ∈ A → x ∈ B)
$$

Definition 19 (Set equality)
----------------------------
Let $A$ and $B$ be sets. Then $A = B$ if and only if $A ⊆ B ∧ B ⊆ A$

Definition 20 (Proper subset)
-----------------------------
Let $A$ and $B$ be sets. Then $A ⊂ B$ if and only if $A ⊆ B ∧ A ≠ B$


Definition 21. Union, Intersection and Difference
----------------------------------
$$
\begin{align}
A ∪ B & = \\{x\ |\ x ∈ A ∨ x ∈ B\\} \\\
A ∩ B & = \\{x\ |\ x ∈ A ∧ x ∈ B\\} \\\
A - B & = \\{x\ |\ x ∈ A ∧ x ∉ B\\}
\end{align}
$$

Example 11
----------
Let $A = \\{1,2,3\\}, B = \\{3,4,5\\}$ and $C = \\{4,5,6\\}$. Then

$$
\begin{align}
A ∪ B & = \\{1,2,3,4,5\\} \\\
A ∩ B & = \\{3\\} \\\
A - B & = \\{1,2\\}
\end{align}
$$

$$
\begin{align}
A ∪ C & = \\{1,2,3,4,5,6\\} \\\
A ∩ C & = ∅ \\\
A - C & = \\{1,2,3\\}
\end{align}
$$

Example 12
----------
Let
$$
\begin{align}
I & = \\{...,-2,-1,0,1,2,...\\} \\\
N & = \\{0,1,2,...\\} \\\
H & = \\{-2^15,...,-2,-1,0,1,2,...,2^15 - 1\\} \\\
W & = \\{-2^31,...,-2,-1,0,1,2,...,2^31 - 1\\}
\end{align}
$$

This $I$ is the set of integers, $N$ is the set of natural numbers,
$H$ is the set of integers that are representable on a computer with
a 16-bit word using 2's complement number representation, and $W$
is the set of integers that are representable in a 32-bit word.
We can use these definitions to create new sets. For example,
$I - W$ is the set of integers that are not representable in a word.

Union and Intersection are associative.

Definition 22
-------------
Let $C$ be a non-empty collection (set) of subsets of the universe
$U$. Let $I$ be a non-empty set, and for each $i ∈ I$ let
$A_i ⊆ C$. Then

$$
\begin{align}
\bigcup_{i ∈ I} A_i & = \\{x\ |\ ∃i ∈ I . x ∈ A_i\\}, \\\ \\\
\bigcap_{i ∈ I} A_i & = \\{x\ |\ ∀i ∈ I . x ∈ A_i\\}
\end{align}
$$

Definition 23
-------------
For ant two sets $A$ and $B$, if $A ∩ B = ∅$ then $A$ and $B$ are disjoint sets.

Exercise 1
----------
Given the sets $A = \\{1,2,3,4,5\\}$ and $B = \\{2,4,6\\}$, calculate the
following sets:

(a): $A ∪ (B ∩ c) = A ∪ \\{2,4\\} = A$
(b): $(A ∩ B) ∪ B = \\{2,4\\} ∪ B = B$
(c): $A - B = \\{1,3,5\\}$
(d): $(B - A) ∩ B = \\{6\\} ∩ B = \\{6\\}$
(e): $A ∪ (B - A) = A ∪ \\{6\\} = \\{1,2,3,4,5,6\\}$

8.2.3 Complement and Power
==========================

Definition 24
-------------
Let $U$ be the universe of discourse, and $A$ be a set.
The *complement* of $A$, written $A'$, is the set $U - A$.

Example 13
----------
Given the universe of alphanumeric characters, the complement
of the set of digits is the set of letters.

Example 14
----------
If the universe is $\\{1,2,4,5\\}$, then $\\{1,2\\}'$ = $\\{3,4,5\\}$


A set that contains a lot of elements will have an even larger number of subsets.
These subsets are themselves objects, and it is often useful to define a new
set containg all of them. The set of all subsets of $A$ is called a *powerset*
of $A$. (In contrast, the set of all *elements* of $A$ is just $A$ itself).

Definition 25
-------------
Let $A$ be a set. The *powerset* of $A$, written $P(A)$, is the set of all
subsets of $A$:
$$
P(A) = \\{S\ |\ S ⊆ A\\}
$$

Example 15 (Powersets)
----------------------
- $P(Ø) = \\{\\{\\}\\}$
- $P(\\{a\\}) = \\{ Ø, \\{a\\}\\}$
- $P(\\{a,b\\}) = \\{Ø, \\{a\\}, \\{b\\}, \\{a,b\\}\\}$
- $P(\\{a,b,c\\}) = \\{Ø,\\{a\\},\\{b\\},\\{c\\},\\{a,b\\},\\{a,c\\},\\{b,c\\},\\{a,b,c\\}\\}$

Notice that if $A$ contains $n$ elements, then its powerset contains $2^n$ elements.
These examples show that fact, as $2^0 = 1, 2^1 = 2, 2^2 = 4$ and $2^3 = 8$

8.3 Finite Sets with Equality
=============================
In computing, finite sets with equality are very useful. Finite means no infinite loops,
and equality is important in order to compare and work with elements of sets, and to
determine if a given value is a member of a set.

In Haskell, things that exhibit equality are instances of the `Eq` typeclass.

    class Eq a where
        (==) :: a -> a -> Bool
        (/=) :: a -> a -> Bool
        (/=) = not . (==)

We can implement sets using lists in Haskell, but lists and sets differ
in two important aspecs: 1) lists can contain duplicates and 2) lists
are ordered, while sets are unordered.

8.3.1 Computing with Sets

First an import, to use `sort`

> import Data.List (sort)

Now create the constructor. This constructor should be *private*.
Sets should be constructed from lists using the `fromList` smart constructor
defined below.

> newtype Set a = Set [a]

A Show instance

> instance Show a => Show (Set a) where
>   show (Set []) = "{}"
>   show (Set xs) = "{" ++ show' xs ++ "}" where
>       show' []  = ""
>       show' [x] = show x
>       show' (x:xs) = show x ++ ", " ++ show' xs

A Eq instance

> instance (Eq a, Ord a) => Eq (Set a) where
>   (Set x) == (Set y) = (sort . deduplicate) x == (sort . deduplicate) y

An Ord instance

> instance (Ord a) => Ord (Set a) where
>   compare (Set xs) (Set ys) = compare xs ys

Define a universe we will use for this chapter's purposes

> _U = Set [-100..100]

An Arbitrary instance for testing (Ints only)

> instance Arbitrary (Set Int) where
>    arbitrary = do
>       n <- choose (0, 100)
>       xs <- vectorOf n (choose (-100,100))
>       return $ fromList xs

Some helpers to ensure that any set is de-duplicated.

> deduplicate :: Eq a => [a] -> [a]
> deduplicate xs = dedup xs [] where
>   dedup []     res = res
>   dedup (x:xs) res = if x `elem` res
>                            then dedup xs res
>                            else dedup xs (res ++ [x])

And constructors

> fromList :: (Ord a, Eq a) => [a] -> Set a
> fromList xs = Set ((sort . deduplicate) xs)

And some operators

> union :: (Eq a, Ord a) => Set a -> Set a -> Set a
> union (Set xs) (Set ys) = fromList (xs ++ ys)

> (+++) :: (Eq a, Ord a) => Set a -> Set a -> Set a
> (+++) = union

> intersection :: (Eq a, Ord a) => Set a -> Set a -> Set a
> intersection (Set xs) (Set ys) = fromList $ filter pred (xs ++ ys)
>   where pred x = x `elem` xs && x `elem` ys

> (***) :: (Eq a, Ord a) => Set a -> Set a -> Set a
> (***) = intersection

> difference :: (Eq a, Ord a) => Set a -> Set a -> Set a
> difference (Set xs) (Set ys) = fromList [x | x <- xs, not $ x `elem` ys]

> (~~~) :: (Eq a, Ord a) => Set a -> Set a -> Set a
> (~~~) = difference

cmpl requires the universe to be known, so is quite restricted

> cmpl :: Set Int -> Set Int
> cmpl x = _U ~~~ x

And some queries

> subset :: (Eq a) => Set a -> Set a -> Bool
> subset (Set xs) (Set ys) = all (`elem` ys) xs

> properSubset :: (Eq a) => Set a -> Set a -> Bool
> properSubset a@(Set xs) b@(Set ys) = not (xs == ys) && subset a b

And the powerset function

> -- first a helper on lists
> powerlist :: [a] -> [[a]]
> powerlist []    = [[]]
> powerlist [x]   = [[], [x]]
> powerlist [x,y] = [[], [x], [y], [x, y]]
> powerlist (x:xs) = concat $ map (\z -> [z, x:z]) (powerlist xs)


    An example of applying the powerlist function by hand
      powerlist [1,2,3]
    = concat $ map (\z -> [z, 1:z]) (powerlist [2,3])
    = concat $ map (\z -> [z, 1:z]) [[], [2], [3], [2,3]]
    = concat $ (\z -> [z, 1:z]) [] : map (\z -> [z, 1:z]) [[2], [3], [2,3]]
    = concat $ [[], [1]] : (\z -> [z, 1:z]) [2] : map (\z -> [z, 1:z]) [[3], [2,3]]
    = concat $ [[], [1]] : [[2], [1,2]] : [[3], [1,3]] : [[2,3], [1,2,3]] : []
    = concat $ [[], [1]] : [[2], [1,2]] : [[3], [1,3]] : [[[2,3], [1,2,3]]]
    = concat $ [[], [1]] : [[2], [1,2]] : [[[3], [1,3]], [[2,3], [1,2,3]]]
    = concat $ [[], [1]] : [[[2], [1,2]], [[3], [1,3]], [[2,3], [1,2,3]]]
    = concat $ [[[], [1]], [[2], [1,2]], [[3], [1,3]], [[2,3], [1,2,3]]]
    = [[], [1], [2], [1,2], [3], [1,3], [2,3], [1,2,3]]


> -- just uses powerlist under the hood
> powerset :: (Eq a, Ord a) => Set a -> Set (Set a)
> powerset (Set xs) = Set $ map (Set) $ powerlist xs

Finally, the crossproduct of a set

> crossproduct :: Set a -> Set b -> Set (a,b)
> crossproduct (Set a) (Set b) = Set [(x,y) | x <- a, y <- b]

Exercise 2
----------
Work out the values of the following set expressions, and then
check your answer using the Haskell expression that folows.

a. `[1,2,3] +++ [3] == [1,2,3]`  
b. `[4,2] +++ [2,4] == [4,2]`  
c. `[1,2,3] *** [3] == [3]`  
d. `[] *** [1,3,5]  == []`  
e. `[1,2,3] ~~~ [3] == [1,2]`  
f. `[2,3] ~~~ [1,2,3] == []`  
g. `[1,2,3] *** [1,2] == [1,2]`  
h. `[1,2,3] +++ [4,5,6] == [1,2,3,4,5,6]`  
i. `([4,3] ~~~ [4,5]) *** [1,2] == [3] *** [1,2] == []`  
j. `([3,2,4] +++ [4,2]) ~~~ [2,3]`  
k. `subset [3,4] [4,5,6] == False`  
l. `subset [1,3] [4,1,3,6] == True`  
m. `subset [] [1,2,3] == True`  
n. `setEq [1,2] [2,1] == True`  
o. `setEq [3,4,6] [2,3,5] == False`  
p. `[1,2,3] ~~~ [1] == [2,3]`  
q. `[] ~~~ [1,2] == []`  

Exercise 3
----------
The `powerset` function takes a set and returns its power set. Work out the
values of the following expressions:

   powerset [3,2,4] == [[], [3], [2], [4], [3,2], [3,4], [2,4], [3,2,4]]
   powerset [2] == [[], [2]]

Exercise 4
----------
The *cross product* of two sts $A$ and $B$ is defiend as
$$
A × B = \\{(a,b)\ |\ a ∈ A, b ∈ B \\}
$$

Evaluate these expressions:

    crossproduct [1,2,3] ['a', 'b'] = [(1,'a'),(1,'b'),(2,'a'),(2,'b'),(3,'a'),(3,'b')]
    crossproduct [1] ['a', 'b']     = [(1, 'a'), (1, 'b')]

Exercise 5
----------
In the following exercise, let `u` be `[1,2,3,4,5,6,7,8,9,10]`,
`a` be `[2,3,4]`, `b` be `[5,6,7]` and `c` be `[1,2]`. Give the elements of each set:

    a +++ b == [2,3,4,5,6,7]
    u ~~~ a *** (b +++ c) == [1,5,6,7,8,9,10] *** [5,6,7,1,2] = [1,5,6,7]
    c ~~~ b == [1,2]
    (a +++ b) +++ c == [2,3,4,5,6,7] +++ [1,2] = [1,2,3,4,5,6,7]
    u ~~~ a = [1,5,6,7,8,9,10]
    u ~~~ (b *** c) = u ~~~ [] = u

Exercise 6
----------
What are the elements of the set $\\{ x + y\ |\ x ∈ \\{1,2,3\\} ∧ y ∈ \\{4,5\\}\\}$

$$
\\{ 1+4,1+5,2+4,2+5,3+4,3+5 \\} = \\{ 5,6,6,7,7,8 \\}
$$

Exercise 7
----------
Write and evaluate a list comprehension that expresses the set
$\\{ x\ |\ x ∈ \\{1,2,3,4,5\\} ∧ x < 0\\}$

    [x | x <- [1,2,3,4,5], x < 0] = []

Exercise 8
----------
Write and evaluate a list comprehension that expresses the set
$\\{ x + y\ |\ x ∈ \\{1,2,3\\} ∧ y ∈ \\{4,5\\} \\}$

    [x + y | x <- [1,2,3], y <- [4,5]] = [1+4,1+5,2+4,2+5,3+4,3+5] = [5,6,6,7,7,8]

Exercise 9
----------
Write and evaluate a list comprehension that expresses the set
$\\{ x \ |\ x ∈ \\{1,2,3,4,5,6,7,8,9,10\\} ∧ \textit{even } x  \\}$

    [x | x <- [1,2,3,4,5,6,7,8,9,10], even x] = [2,4,6,8,10]

Exercise 10
-----------
What is the value of each of the following expressions?

    subset [1,3,4] [4,3] == False
    subset [] [2,3,4] == True
    
    setEq [2,3] [4,5,6] == False
    setEq [1,2] [1,2,3] == False

8.4 Set Laws
============

Theorem 68
----------
Let $A$, $B$ and $C$ be sets. If $A ⊆ B$ and $B ⊆ C$, then $A ⊆ C$.
*Proof*

$$
\begin{align}
1. & A ⊆ B          & \\{\text{Premise}\\} \\\
2. & x ∈ A → x ∈ B  & \\{\text{Def.} ⊆ \\} \\\
3. & B ⊆ C          & \\{\text{Premise}\\} \\\
4. & x ∈ B → x ∈ C  & \\{\text{Def.} ⊆ \\} \\\
5. & x ∈ A → x ∈ C & \\{\text{Implication}\\} \\\
6. & ∀x. (x ∈ A → x ∈ C) & \\{ ∀I \\} \\\
7. & A ⊆ C          & \\{\text{Def.} ⊆ \\}
\end{align}
$$

Exercise 11
-----------
Let $A,B$ and $C$ be sets. Prove that if $A ⊂ B$ and $B ⊂ C$ then $A ⊂ C$

First we prove that $A ⊆ C$ and then that $A ≠ C$
$$
\begin{align}
1. & A ⊆ B ∧ A ≠ B & \\{\text{Premise}\\} \\\
2. & A ⊆ B          & \\{ ∧ E_L \\} \\\
3. & B ⊆ C ∧ B ≠ C & \\{\text{Premise}\\} \\\
4. & B ⊆ C          & \\{ ∧ E_L \\} \\\
5. & x ∈ A → x ∈ B  & \\{\text{Def.} ⊆ \\} \\\
6. & x ∈ B → x ∈ C  & \\{\text{Def.} ⊆ \\} \\\
7. & x ∈ A → x ∈ C & \\{\text{Implication}\\} \\\
8. & ∀x. (x ∈ A → x ∈ C) & \\{ ∀I \\} \\\
9. & A ⊆ C          & \\{\text{Def.} ⊆ \\}
\end{align}
$$

We know that $A ≠ B ↔ ¬(A ⊆ B ∧ B ⊆ A)$
and $B ≠ C ↔ ¬(B ⊆ C ∧ C ⊆ B)$.

Since we also know that $a ⊂ b → a ⊆ b$, we know that
$A ⊆ B$ and $B ⊆ C$.
Furthermore, we know that $a, ¬(a ∧ b) ⊢ ¬b$, so we can infer
that $¬(C ⊆ B)$ and $¬(B ⊆ A)$.
If $C$ is not subset-or-equal to $B$, and $B$ is not subset-or-equal
to $A$, then $A$ cannot be subset-or-equal-to $C$.


And thus, we know that $A ≠ C$, and $A ⊆ C$, so $A ⊂ C$. Q.E.D.


Exercise 12
-----------
Consider the following two claims. For each one, if it is true
give a proof, but if it is false give a counter-example.

(a). If $A ⊆ B$ and $B ⊆ C$, then $A ⊂ C$.  
Not true. Counterexample:

If $A = \\{ 1, 2\\}$ and $B = \\{1,2\\}$ and $C = \\{1,2\\}$,
then $A ⊆ B$ and $B ⊆ C$ but $A ⊄ B$

(b). if $A ⊂ B$ and $B ⊂ C$, then $A ⊆ C$
True. Proof:

$$
\begin{align}
1. & A ⊆ B ∧ A ≠ B & \\{\text{Premise}\\} \\\
2. & A ⊆ B          & \\{ ∧ E_L \\} \\\
3. & B ⊆ C ∧ B ≠ C & \\{\text{Premise}\\} \\\
4. & B ⊆ C          & \\{ ∧ E_L \\} \\\
5. & x ∈ A → x ∈ B  & \\{\text{Def.} ⊆ \\} \\\
6. & x ∈ B → x ∈ C  & \\{\text{Def.} ⊆ \\} \\\
7. & x ∈ A → x ∈ C & \\{\text{Implication}\\} \\\
8. & ∀x. (x ∈ A → x ∈ C) & \\{ ∀I \\} \\\
9. & A ⊆ C          & \\{\text{Def.} ⊆ \\}
\end{align}
$$


8.4.1 Associative and Commutative Set Operations
================================================
The set union and intersection operators and commutative and associative.

Theorem 69
----------
For all sets $A,B$ and $C$,

1. $A ∪ B = B ∪ A$
2. $A ∩ B = B ∩ A$
3. $A ∪ (B ∪ C) = (A ∪ B) ∪ C$
4. $A ∩ (B ∩ C) = (A ∩ B) ∩ C$
5. $A - B = A ∩ B'$


*Proof*. We prove the second equation. Let $x$ be any element of
$U$, Then each line i nthe proof below is logically equivalent
$↔$ to the following line:

$$
\begin{align}
1. & x ∈ A ∩ B     & \\{ Premise \\} \\\
2. & x ∈ A ∧ x ∈ B & \\{ \text{Def.} ∩ \\} \\\
3. & x ∈ B ∧ x ∈ A & \\{ \text{Comm.} ∩ \\} \\\
4. & x ∈ B ∩ A     & \\{ \text{Def.} ∩ \\} \\\
5. & ∀x ∈ U. x ∈ A ∩ B ↔ x ∈ B ∩ A & \\{ ∀I \\} \\\
6. & A ∩ B = B ∩ A & \\{ \text{Def. set equality} \\}
\end{align}
$$

8.4.2 Distributive Laws
=======================
The following theorem states that the union and intersection
operators distribute over each other.

Theorem 70
----------
$A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)$
*Proof*. Let $x$ be an arbitrary element of the universe $U$.
Then the following expressions are equivalent ($↔$):

$$
\begin{align}
1. & A ∩ (B ∪ C)                         & \\{\text{Premise}\\} \\\
2. & x ∈ A ∧ (x ∈ B ∨ x ∈ C)             & \\{\text{Def.} ∪, ∩\\} \\\
3. & (x ∈ A ∧ x ∈ B) ∨ (x ∈ A ∨ x ∈ C)   & \\{ ∧ \text{ over } ∨ \\} \\\
4. & x ∈ (A ∩ B) ∪ (A ∩ C)               & \\{\text{Def.} ∪, ∩\\} \\\
5. & ∀x ∈ U. x ∈ A ∩ (B ∪ C) ↔ x ∈ (A ∩ B) ∪ (A ∩ C) & \\{ ∀ I \\} \\\
6. & A ∩ (B ∪ C) = (A ∩ B) ∪ (A ∩ C)       & \\{\text{Def.} set equality \\}
\end{align}
$$

Theorem 71
----------
$A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)$

*Proof*.

$$
\begin{align}
1. & A ∪ (B ∩ C)                         & \\{\text{Premise}\\} \\\
2. & x ∈ A ∨ (x ∈ B ∧ x ∈ C)             & \\{\text{Def.} ∩, ∪\\} \\\
3. & (x ∈ A ∨ x ∈ B) ∧ (x ∈ A ∧ x ∈ C)   & \\{ ∨ \text{ over } ∧ \\} \\\
4. & x ∈ (A ∪ B) ∩ (A ∪ C)               & \\{\text{Def.} ∩, ∪\\} \\\
5. & ∀x ∈ U. x ∈ A ∪ (B ∩ C) ↔ x ∈ (A ∪ B) ∩ (A ∪ C) & \\{ ∀ I \\} \\\
6. & A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)       & \\{\text{Def.} set equality \\}
\end{align}
$$

8.4.3 DeMorgan's Laws for Sets
==============================

Theorem 72
----------
Let $A$ and $B$ be arbitrary sets. Then
$$
(A ∪ B)' = A' ∩ B'
$$
and
$$
(A ∩ B)' = A' ∪ B'
$$

*Proof*. We prove that $(A ∪ B)' = A' ∩ B'$. Let $x$ be any element
of $U$. Then the following lines are equivalent:

$$
\begin{align}
1.  & x ∈ (A ∪ B)'                   & \\{\text{Premise} \\} \\\
2.  & x ∈ U ∧ ¬(x ∈ A ∪ B)           & \\{\text{Def. comp} \\} \\\
3.  & x ∈ U ∧ ¬(x ∈ A ∨ x ∈ B)       & \\{\text{Def.} ∪ \\} \\\
4.  & x ∈ U ∧ (¬(x ∈ A) ∧ ¬(x ∈ B))  & \\{\text{DeMorgan} \\} \\\
5.  & x ∈ U ∧ x ∈ U ∧ (¬(x ∈ A) ∧ ¬(x ∈ B)) & \\{\text{Idemp. of ∧}\\} \\\
6.  & (x ∈ U ∧ ¬(x ∈ A)) ∧ (x ∈ U ∧ ¬(x ∈ B)) & \\{\text{Comm. of ∧}\\} \\\
7.  & x ∈ U - A ∧ x ∈ U - B          & \\{\text{Def. of diff.} \\} \\\
8.  & x ∈ (U - A) ∩ (U - B)          & \\{\text{Def.} ∪ \\} \\\
9.  & (x ∈ A' ∧ B')                  & \\{\text{Def. of comp.} \\} \\\
10. & ∀x. x ∈ (A ∪ B)' ↔ x ∈ (A' ∧ B') & \\{ ∀ \text{ introduction} \\} \\\
11. & (A ∪ B)' = A' ∩ B'
\end{align}
$$

8.7 Review Exercises
====================

Exercise 13
-----------
For the following questions, give a proof using set laws,
or find a counterexample.

(a) $(A' ∪ B)' ∩ C' = A ∩ (B ∪ C)'$  
$$
\begin{align}
1. & (A' ∪ B)' ∩ C' & \\\
2. & A'' ∩ B' ∩ C'  & \\{ \text{DeMorgan} \\} \\\
3. & A ∩ B' ∩ C'    & \\{ \text{Double complement} \\} \\\
4. & A ∩ (B' ∩ C')  & \\{ ∩ \text{ assoc} \\} \\\
5. & A ∩ (B ∪ C)'   & \\{ \text{DeMorgan}\\}
\end{align}
$$

(b) $A − (B ∪ C)' = A ∩ (B ∪ C)$  

$$
\begin{align}
1. & A - (B ∪ C)'                       & \\\
2. & A ∩ ((B ∪ C)')'    & \\{\text{Theorem 69.5}\\} \\\
3. & A ∩ (B ∪ C)        & \\{\text{Double complement}\\}
\end{align}
$$


(c) $(A ∩ B) ∪ (A ∩ B') = A$  

$$
\begin{align}
1. & (A ∩ B) ∪ (A ∩ B') & \\\
2. & A ∩ (B ∪ B')       & \\{ ∩ \text{ over } ∪ \\}  \\\
3. & A ∩ U              & \\{ a ∪ a' = U \\} \\\
4. & A                  & \\{ ∩ \text{ identity } \\} \\\
\end{align}
$$

(d) $A ∪ (B − A) = A ∪ B$  

$$
\begin{align}
1. & A ∪ (B - A)         & \\\
2. & A ∪ (B ∩ A')        & \\{\text{Theorem 69.5}\\} \\\
4. & (A ∪ B) ∩ (A ∪ A')  & \\{ ∪ \text{ over } ∩\\} \\\
5. & (A ∪ B) ∩ U         & \\{a ∪ a' = U \\}  \\\
6. & A ∪ B               & \\{ ∩ \text{domination} \\}
\end{align}
$$

(e) $A − B = B' − A'$  

$$
\begin{align}
1. & A - B         & \\\
2. & A ∩ B'        & \\{\text{Theorem 69.5}\\} \\\
3. & ((A ∩ B')')'  & \\{\text{Double neg} \\} \\\
4. & (A' ∪ B'')'   & \\{\text{DeMorgan}\\} \\\
5. & (B'' ∪ A')'   & \\{ ∪ \text{ commutes}\\} \\\
6. & B''' ∩ A''    & \\{\text{DeMorgan}\\} \\\
7. & B''' - A'     & \\{\text{Theorem 69.5}\\} \\\
8. & B' - A'       & \\{\text{Double neg} \\}
\end{align}
$$

(f) $A ∩ (B − C) = (A ∩ B) − (A ∩ C)$  

$$
\begin{align}
  & A ∩ (B - C)                 & \\\
= & A ∩ (B ∩ C')                & \text{Def. minus} \\\
= & Ø ∪ A ∩ (B ∩ C')            & \text{∪ identity} \\\
= & (Ø ∩ B) ∪ (A ∩ B ∩ C')      & \text{∩ domination} \\\
= & (A ∩ A' ∩ B) ∪ (A ∩ B ∩ C') & \text{a ∩ a = Ø} \\\
= & ((A ∩ B) ∩ A') ∪ ((A ∩ B) ∩ C') & \text{∩ commute and assoc} \\\
= & (A ∩ B) ∩ (A' ∪ C')         & \text{∩ over ∪} \\\
= & (A ∩ B) ∩ (A' ∪ C')''       & \text{Double neg.} \\\
= & (A ∩ B) ∩ (A'' ∩ C'')'      & \text{DeMorgan} \\\
= & (A ∩ B) ∩ (A ∩ C)'          & \text{Double neg.} \\\
= & (A ∩ B) - (A ∩ C)           & \text{Def. minus}
\end{align}
$$

(g) $A − (B ∪ C) = (A − B) ∩ (A − C)$  

$$
\begin{align}
  & (A - B) ∩ (A - C)        & \\\
= & (A ∩ B') ∩ (A ∩ C')      & \text{Def. -} \\\
= & (A ∩ A) ∩ (B' ∩ C')      & \text{∩ assoc} \\\
= & A ∩ (B' ∩ C')            & \text{∩ idempotent} \\\
= & A ∩ (B' ∩ C')''          & \text{Double neg.} \\\
= & A ∩ (B ∪ C)'             & \text{DeMorgan} \\\
= & A - (B ∪ C)              & \text{Def. -}
\end{align}
$$

(h) $A ∩ (A' ∪ B) = A ∩ B$  

$$
\begin{align}
  & A ∩ (A' ∪ B)         & \\\
= & (A ∩ A') ∪ (A ∩ B)   & \text{∩ over ∪} \\\
= & Ø ∪ (A ∪ B)          & a ∩ a' = Ø \\\
= & A ∪ B                & \text{∪ identity}
\end{align}
$$

(i) $(A − B') ∪ (A − C') = A ∩ (B ∩ C)$  

$$
\begin{align}
  & (A - B') ∪ (A - C')         & \\\
= & (A ∩ B'') ∪ (A - C'')       & \text{Def. -} \\\
= & (A ∩ B) ∪ (A ∩ C)           & \text{Double neg.}\\\
= & A ∩ (B ∪ C)                 & \text{∩ over ∪}
\end{align}
$$

Exercise 14
-----------
The function

> smaller :: Ord a => a -> [a] -> Bool
> smaller x [] = True
> smaller x (y:ys) = x < y

takes a value and a list of values and returns `True` if the
value is smaller than the first element in the list. Using this
function, write a function that takes a set and returns its
powerset. Use `foldr`.

> powerlist' :: (Ord a, Eq a) => [a] -> [[a]]
> powerlist' xs = deduplicate $ foldr g [[]] xs where
>   g x acc =
>       [x : epset | epset <- acc
>                  , not (elem x epset) && smaller x epset]
>       ++ acc

Exercise 15
-----------
Prove that $(A ∪ B)' = ((A ∪ A') ∩ A') ∩ ((B ∩ B') ∩ B')$

$$
\begin{align}
  & (A ∪ B)'                                & \\\
= & A' ∩ B'                                 & \text{DeMorgan} \\\
= & (U ∩ A') ∩ (U ∩ B')                     & \text{∩ identity} \\\
= & ((A ∪ A') ∩ A') ∩ ((B ∩ B') ∩ B')       & \text{a ∪ a' = U}
\end{align}
$$

Exercise 16
-----------
Using a list comprehension, write a function that takes two sets
and returns `True` if the first is a subset of the other.

> isSubset' xs ys = [x | x <- xs, x `elem` ys] == xs

Exercise 17
-----------
What is wrong with this definition of `diff`, a function that
takes two sets and returns their difference?

    diff :: Eq a => [a] -> [a] -> [a]
    diff set1 set2 [e | e <- set2, not (elem e set1)]

The arguments are switched - set1 is subtracted from set2

Exercise 18
-----------
What is wrong with this definition of `intersection`,
a function that takes two sets and returns their intersection?

    intersection :: [a] -> [a] -> [a]
    intersection set1 set2 = [e | e <- set1, e <- set2]

This will duplicate all elements on set 1, (length set2) times.
It should be

    intersection :: [a] -> [a] -> [a]
    intersection set1 set2 = [e | e <- set1, e `elem` set2]

Exercise 19
-----------
Write a function using a list comprehension that takes
two sets and returns their union.

> union' xs ys = [x | x <- deduplicate $ xs ++ ys]

Exercise 20
-----------
Is it ever the case that $A ∪ (B - C) = B$

If $A = Ø, C = Ø$ then $A ∪ (B - C) = A ∪ (B - Ø) = A ∪ B = Ø ∪ B = B$
In any case, if $A ⊆ B$ and $B ⊆ C$

Exercise 21
-----------
Give an example in which $(A ∪ C) ∩ (B ∪ C) = Ø$

If $A$ and $B$ are disjoint and $C = Ø$
$A = \\{1\\}, B = \\{2\\}, C = Ø, (A ∪ C) ∩ (B ∪ C) = \\{1\\} ∩ \\{2\\} = Ø$

Exercise 22
-----------
Prove the commutative law of set-intersection, $A ∩ B = B ∩ A$.

$$
\begin{align}
  & A ∩ B                   & \\\
= & x ∈ A ∧ x ∈ B           & \text{Def. ∩} \\\
= & x ∈ B ∧ x ∈ A           & \text{∧ commutes} \\\
= & ∀x. x ∈ B ∧ x ∈ A       & \text{∀ I} \\\
= & B ∩ A                   & \text{Def. ∩}
\end{align}
$$


Exercise 23
-----------
Express the commutative law of set-intersection in terms of the
set operations and Boolean operations defiend in the `Stdm` module.

> intersectionCommutes a b = a *** b == b *** a
> -- quickCheck (intersectionCommutes :: (Set Int -> Set Int -> Bool))

Exercise 24
-----------
Prove the associative law of set-union, $(A ∪ B) ∪ C = A ∪ (B ∪ C)$

$$
\begin{align}
  & (A ∪ B) ∪ C                   & \\\
= & (x ∈ A ∨ x ∈ B) ∨ x ∈ C       & \text{Def. ∪} \\\
= & x ∈ A ∨ (x ∈ B ∨ x ∈ C)       & \text{∨ commutes} \\\
= & A ∪ (B ∪ C)                   & \text{Def. ∪} \\\
\end{align}
$$

Exercise 25
-----------
Prove that the difference between two sets is the intersection of
one with the complement of the other, which can be written as
$A - B = A ∩ B'$.

$$
\begin{align}
  & A - B                        & \\\
= & [x | x ∈ A ∧ x ∉ B]          & \text{Def. -} \\\
= & [x | x ∈ A ∧ x ∈ (U - B)]    & \text{x ∉ A = x ∈ A'}
= & A ∩ B'                       & \text{Def. ∩}
\end{align}
$$

Exercise 26
-----------
Prove that union distributs over intersection.
$$
A ∪ (B ∩ C) = (A ∪ B) ∩ (A ∪ C)
$$

Exercise 27
-----------
Prove DeMorgan's law for the set intersection,
$(A ∩ B)' = A' ∪ B'$