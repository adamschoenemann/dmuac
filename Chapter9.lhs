> import Chapter8

9. Inductively Defined Sets
===========================
Set *enumeration*, e.g. $\\{1,2,3\\}$ works fine for small, finite sets,
but it is unhandy with larger finite sets, and does not work with infinite sets.
Using elipses '...' is easier, but it is ambiguous and imprecise.
Instead, we can formally define sets of any shape and size using *set induction*,
which works in a similar way to list induction, explored earlier.

9.1 The Idea Behind Induction
=============================
Like list induction, we have a *base case* and one or more inductive rule(s)
that specify how to reach an element in the set from the base case.
Induction is like a mathematical 'program' that calculates a proof
when needed. The proof asserts that an element is a member of the set 
defined by induction. For example, here are two propositions:

$$
\begin{align}
& 0 ∈ S \\\
& n ∈ s → n + 1 ∈ s
\end{align}
$$

This is an inductive definition of the set of positive integers $(n ∈ \mathbb{Z} ∧ n >= 0)$.
The two propositions lets us prove  that any natural number is in the set $S$.

For example, to show that 2 is an element of $S$. Using the propositions above we can
construct a *chain* that looks like this:

$$
\begin{align}
& 0 ∈ S
& 0 ∈ S → 1 ∈ S
& 1 ∈ S → 2 ∈ S
\end{align}
$$

We then use *Modus Ponens* to deduce that 1 is in fact in $S$,
and from that, using *Modus Ponens* again, we deduce that 2 is in $S$.

In Haskell, we can do something similar.

> imp1 :: Integer -> Integer
> imp1 1 = 2
> imp1 _ = error "premise does not match"
> 
> imp2 :: Integer -> Integer
> imp2 2 = 3
> imp2 _ = error "premise does not match"
> 
> s :: [Integer]
> s = [1, imp1 (s !! 0), imp2 (s !! 1)]

The `!!` operator returns the nth element of a set, counting from 0.
It is of course imperative that a chain is formed, e.g. if a proposition
relies on an element being in the set that is not in the set, then
we cannot prove that that element is in the set.

Exercise 1
----------
Is the following a chain? You can test your conclusions by evaluation `s`
in each case.

    imp1 :: Integer -> Integer
    imp1 1 = 2
    imp1 x = error "imp1: premise does not apply"
    
    imp2 :: Integer -> Integer
    imp2 2 = 3
    imp2 x = error "imp2: premise does not apply"
    
    imp3 :: Integer -> Integer
    imp3 3 = 4
    imp3 x = error "imp3: premise does not apply"
    
    s :: [Integer]
    s = [1, imp1 (s !! 0), imp2 (s !! 1), imp3 (s !! 2)]

**Yes**.

Exercise 2
----------
Is the following a chain?

    imp1 :: Integer -> Integer
    imp1 1 = 2
    imp1 x = error "imp1: premise does not apply"
    
    imp2 :: Integer -> Integer
    imp2 3 = 4
    imp2 x = error "imp2: premise does not apply"
    
    s :: [Integer]
    s = [0, imp1 (s !! 0), imp2 (s !! 1)]

**No. imp1 will throw an error when applied to (s !! 0) = 0**.

Exercise 3
----------
Is the following a chain?

    imp1 :: Integer -> Integer
    imp1 0 = 1
    imp1 x = error "imp1: premise does not apply"
    
    imp2 :: Integer -> Integer
    imp2 3 = 4
    imp2 x = error "imp2: premise does not apply"
    
    s :: [Integer]
    s = [0, imp1 (s !! 0), imp2 (s !! 1)]

**No. imp2 will err**.

Exercise 4
----------
Is the following a chain?

    imp1 :: Integer -> Integer
    imp1 0 = 1
    imp1 x = error "imp1: premise does not apply"
    
    imp2 :: Integer -> Integer
    imp2 1 = 2
    imp2 x = error "imp2: premise does not apply"
    
    s :: [Integer]
    s = [0, imp1 (s !! 1), imp2 (s !! 0)]

**No. imp1 is applied to itself, which is not zero, so errs**.

9.1.1 The Induction Rule
========================
Recall the two propositions we used in the first section:
$$
\begin{align}
& 0 ∈ S
& n ∈ S → n + 1 ∈ S
\end{align}
$$

The first one is called the base case, and the second is called the induction
case, or the induction rule. It is the induction case that generates the links of
the chain which will allow us to reach any number in the set being defined.

We could have an induction rule like this
$$
\begin{align}
& n ∈ S → n + 2 ∈ S
\end{align}
$$

Together with the base case $1 ∈ S$, this would define the odd natural numbers.

Another rule could be

$$
\begin{align}
& n ∈ S → n * 5 ∈ S
\end{align}
$$

Together with the previous base case, this would define the set of powers of 5.
Sometimes, it is not so simple though, and we want to be able to debug our rules.
Enter the computer!

Suppose we have a set defined by the following assertions:

$$
\begin{align}
& 0 ∈ S
& x ∈ S → x + 1 ∈ S
\end{align}
$$

We want to find out if 2 is in the set, and we will use the computer to help us.
We can implement the induction rule as the increment function.

    increment :: Integer -> Integer
    increment x = x + 1
    
    s :: [Integer]
    s = [0, increment (s !! 0), increment (s !! 1)]

We can load this definition and evaluate s; the last element of s is 2.
Now suppose that we want to know whether 50 is in the set. It would
be very tedious to write out each element as we have been doing. The same
function is applied to each element of s, so we can have the following definition
of `s` instead

    s :: [Integer]
    s = 0 : map increment s

This style of programming is known as *data recursion*. `map` proceeds down
`s`, creating eah value it needs and then using it. We can then get
at the fiftieth element by typing `s !! 50`.

Exercise 5
----------
Given the base case $0 ∈ n$ and the induction rule $x ∈ n → x + 1 ∈ n$, fix the
following calculation so that 3 is in the set $n$.

    fun :: Integer -> Integer
    -- fun x = x - 1
    fun x = x + 1
    n :: [Integer]
    n = 0 : map fun n

Alternatively, you could change the last line to `n = 3 : map fun n` instead.

Exercise 6
----------
Using the following definitions, determine whether 4 is in set $s$,
given $1 ∈ s$ and the induction rule $x ∈ s → x + 2 ∈ s$

    fun :: Integer -> Integer
    fun x = x + 2
    
    s :: [Integer]
    s = 1 : map fun s

**Nope, but if s started from 0 it would**.

Exercise 7
----------
Fix this calculation of the positive integers:

    fun :: Integer -> Integer
    --fun x = 0
    fun x = x + 1
    
    p :: [Integer]
    p = 0 : map fun p

Exercise 8
----------
Fix this calculation of the positive multiples of 3:

    fun :: Integer -> Integer
    fun x = x + 3
    
    p :: [Integer]
    --p = map fun p
    p = 0 : map fun p

9.2 How to Define a Set Using Induction
=======================================
When we use induction to define sets, we specify rules for what numbers are
in the set. But how do we know that *something else* is not also in $S$?.
If we don't explicitly say that nothing else is in $S$, then the rules
could be satisfied by lots of different sets.

To exclude all elements that ren't introducted by the base case, or the
instantiations of the induction case, we include a clause (called the
*extremal clause*), in a set difinition that states *Nothing is an element of the
set unless it can be constructed by a finite number of uses of the first two clauses*.

To summarise, an inductive definition of a set consists of thee parts: the *base case*,
the *inductive case*, and the *extremal clause*:

- The base case is a simple statement of some mathematical fact, such as $1 ∈ S$.
- The induction case is a implication in a general form, such as the proposition
  that $∀x ∈ U. x ∈ S → x + 1 ∈ S$
- The extremal clause says that nothing is in the set unless it got there by a 
  finite number of uses of the first two cases.

9.2.1 Inductive Definition of the Set of Natural Numbers
========================================================
We will illustrate the mothod by writing an inductive definition of the
natural numbers.

Definition 26
-------------
The set $N$ of natural numbers is defined as follows:

- Base case: $0 ∈ N$
- Induction case: $x ∈ N → x + 1 ∈ N$
- Extremal clause: nothing is an element of the set $N$ unless it can be
  constructed by a finite number of applications of the base and induction cases.

Now we can use the base and induction case to show formally that a positive number,
e.g. 2 is in the set $N$

$$
\begin{align}
1. & 0 ∈ N            & \text{Base case} \\\
2. & 0 ∈ N → 1 ∈ N    & \text{Induction case} \\\
3. & 1 ∈ N            & \text{Modus Ponens} \\\
4. & 1 ∈ N → 2 ∈ N    & \text{Induction case} \\\
5. & 2 ∈ N            & \text{Modus ponens}
\end{align}
$$

Exercise 9
----------
Here is a Haskell equation that defines the set s inductively. Is
82 an element of s?

    s :: [Integer]
    s = 0 : map ((+) 2) s

*Yes, it can be constructed using finite steps of base/inductive case*.

Exercise 10
-----------
What set is defined by the following?

    s :: [Integer]
    s = 1 : map (* 3) s

The set of powers of three, e.g. $\\{ 1, 3, 9, 27 ... \\}.

9.2.2 The Set of Binary Machine Words
=====================================
Now we define a set `BinWords`, each of which is a machine word represented in
binary notation. In general, a machine word can be of any length.

The base case says that the elements of another set (the set of binary digits)
are also elements of `BinWords`. The induction case uses concatenation to create
a new value from one already in the set. We represent the concatenation of a
character to a string by placing them one after the other: e.g., ‘1’ ‘01’ is the
string ‘101’.

Definition 27
-------------
Let `BinDigit` be the set $\\{0,1\\}$. The set `BinWords` of machine
words in binary is defined as follows:

- Base case:
  $$ x ∈ BinDigit → x ∈ BinWords $$
- Induction case: if $x$ is a binary digit and $y$ is a binary word, then
  their concation $xy$ is also a binary word:
  $$ (x ∈ BinDigit ∧ y ∈ BinWords) → xy ∈ BinWords $$
- Extremal clause: nothing is an element of BinWords unless it can be
  constructed with a finite number of uses of the base and induction cases.

A set based on another set $S$ in this way is given the name $S^+$, indicating
that it is the set of all possible non-empty strings over $S$. The expression
$S^∗$ is the same as $S^+$, except that $S^∗$ also includes the empty string.
Thus our set `BinWords` could be written $\mathtt{BinDigit}^+$.

The binary words in Haskell based on our definition: The induction function
takes a bin word. It creates a new one from that number, and each binary
digit in turn. For example, if it is given $[1,0]$ it returns [0,1,0] and [1,1,0].

> -- helper function
> mappend :: (a -> [b]) -> [a] -> [b]
> mappend _ [] = []
> mappend f (x:xs) = f x ++ mappend f xs

> newBinaryWords :: [Integer] -> [[Integer]]
> newBinaryWords bs = [0:bs, 1:bs]

> binWords :: [[Integer]]
> binWords = [0] : [1] : (mappend newBinaryWords binWords)

Exercise 11
------------
Alter the definition of `newBinaryWords` and `binWords` so that
they produce all of the *octal* numbers. An octal number is one that
contains only the digits from 0 through 7.

> newOctalWords :: [Integer] -> [[Integer]]
> newOctalWords ys = map (:ys) [0..7]

> octalWords :: [[Integer]]
> octalWords = [0] : [1] : [2] : [3] : [4] : [5] : [6] : [7] :
>       mappend newOctalWords octalWords

9.3 Defining the Set of Integers
================================
This is a lot more difficult, because we need both positive and negative numbers.
The sets we've defined so far are *well-founded*; that is, they are infinite only
in one direction, and they have a least (minimal) element.
A *countable* set is one that can be counted using the natural numbers.
Are the integers countable? They don't have a least element, and they are infinite
in two directions, so they aren't well-founded. But we could use a trick: start from
0 and count first $n$ then $-n$. If we think of the integers as a measuring tape
that is infinitely long in two directions, we could count the measurements on the
tape by thinking of the tape as being folded at 0. Now the positive numbers
touch the negative numbers, and each element $i$ of the naturals counts both
the positive and the negative numbers; that is, $i$ counts $(i, -i)$.

9.3.1 Attempts at the Set of Integers
=====================================
The first naive attempt at defining $I$ is as follows:

- Base case: $0 ∈ I$
- Induction case: $x ∈ I, -x ∈ I$
- Extremal cluause: The usual

Lets define some functions to help us build sets with induction

> build :: Ord a => a -> (a -> a) -> [a]
> build a f = set where
>    set = a : map f set
>
> builds :: Ord a => a -> (a -> [a]) -> [a]
> builds a f = set where
>    set = a : mappend f set

Here is an implementation of this definition

> integers1 = build 0 (\x -> -x)

Exercise 12
-----------
Use `take 10 integers1` to evaluate the first 10 integers according to this
definition. Describe

It is just 10 0s, because -0 is just 0.

*Second attempt*  
Same base case as above, inductive case is now
$$
x ∈ I → (x + 1 ∈ I ∧ x - 1 ∈ I)
$$

Implementation:

> integers2 = builds 0 (\x -> [x + 1, x - 1])

Exercise 13
-----------
Use `take 20 integers2` to eval and describe.

We actually get all the integers, BUT, in a very strange sequence, and with
lots of duplication :(. The problem is that our induction function is applied
to previous results, so it goes
    
    0 -> [1,-1] ++ 
    (1 -> [2,0]) ++ 
    (-1 -> [0, -2]) ++
    (2 -> [3,1]) ++
    (0 -> [1,-1]) ++
    (0 -> [1,-1]) ++
    (-2 -> [-1, -3]) ......

This is not optimal!!

*Third attempt*  
Induction case is now
$$
x ∈ I → (x + 1 ∈ I ∧ -(x + 1) ∈ I)
$$

In Haskell::

> integers3 = builds 0 (\x -> [x + 1, -(x + 1)])

Exercise 14
-----------
Examine first 10 and describe.

    take 10 integers3 -- --> [0,1,-1,2,-2,0,0,3,-3,-1]

Its kind of the same problem as before, because we must remember
that the induction rule is applied to *all* elements in sequence,
so it starts off well, but when applied to e.g. -1 it becomes

    (-1 -> [0, -0])

And we get zero in there once more!

*Fourth attempt*  
The third attempt also includes all integers, so that is good. But we also
get duplicates, which is far from ideal!

The fourth attempt has two induction rules:

$$
\begin{align}
1. & (x ∈ I ∧ x ≥ 0) → x + 1 ∈ I \\\
2. & (x ∈ I ∧ x < 0) → x - 1 ∈ I
\end{align}
$$

Haskell impl:

> integers4 = build 0 fun where
>    fun x = if x < 0 then (x - 1) else (x + 1)

Exercise 15
-----------
Check the implementation out.

We just get the positive integers, since x will never be below zero, qa our
base case.

*Fifth attempt*
Induction case:
$$
(x ∈ A ∧ x ≥ 0) → x + 1 ∈ I ∧ -(x + 1) ∈ I
$$

In Haskell:

> integers5 = builds 0 fun where
>    fun x = if x == 0 || x > 0 then [x + 1, -(x + 1)] else []

Exercise 16
-----------
Evalute the above definition.

Yes! It works. Basically, we skip the negative numbers when applying
the induction rule, which gives us the correct result.

9.5 Review Exercises
====================

Exercise 17
-----------
Does `ints`, using the following definition, enumerate the integers?
If it does, then you should be able to pick any integer and see it
eventually in the output produced by `ints`. Will you ever see the
value -1?

> nats :: [Integer]
> nats = build 0 (1 +)
> 
> negs :: [Integer]
> negs = build (-1) (1 -)
> 
> ints :: [Integer]
> ints = nats ++ negs

It does *not* enumerate the integers. First of all, `negs` is plain wrong, and
will generate [-1,2,-1,2,-1,2 ...]. Second of all, `nats` is infite, so `++` will
never reach the end of the list and concatenate negs. And no, -1 will never appear.

Exercise 18
-----------
Does `twos` enumerate the set of even natural numbers?

No, it is just an infinite number of zeroes, as 0 * 2 == 0.

Exercise 19
-----------
What is wrong with the following definition of the stream of natural numbers?

    nats = map (+ 1) nats ++ [0]

It will go into an infite loop, because nats refers to itself before
the base case is established.

Exercise 20
-----------
What is the problem with the following definition of the naturals?

    naturals :: [Integer] -> [Integer]
    naturals (i:acc) = naturals (i + 1:i:acc)
    
    nats :: [Integer]
    nats = naturals [0]

It builds the set from the reverse direction, e.g. from infinity, and we will
never reach infinity, so the set will never be built.

Exercise 21
-----------
Can we write a function that will take a stream of the naturals (appearing 
in any order)
