8. Set Theory
=============

Definition 21. Union, Intersection and Difference
----------------------------------
$$
\begin{align}
A ∪ B & = {x\ |\ x ∈ A ∨ x ∈ B} \\\
A ∩ B & = {x\ |\ x ∈ A ∧ x ∈ B} \\\
A - B & = {x\ |\ x ∈ A ∧ x ∉ B}
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
