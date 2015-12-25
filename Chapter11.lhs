> module Chapter11 where
> import Chapter8

11. Functions
=============
Input -> Result
Result = completely determined by input
Same input = Same result (referential transparency? pure?)

Examples:

- Phone book inquiry - give name, get phone number. Same name, same phone number
- Math functions such as sin, cos, etc
- Addition circuit in a computer: 2 binary nums -> 1 binary sum

In contrast, "What will the weather be tomorrow?" depends on other params (context).

- A function is a black box
    - Need to know interface, not definition
- Abstract concept
    - Many different ways to formalize it, e.g. relations, algorithms, algebra etc.

11.1 The Graph of a Function
============================
- Relational approach to functions
- For an input $x$, the value $y$ is the result
    - ordered pair $(x,y)$
    - fun = set of ordered pairs
- This representation of a function is called a *function graph*.
    - Similar to a digraph in many ways

- Some additional properties are required
    - Digraphs have no restrictions e.g. $\\{(x,y),(x,y_2)\\}$ is valid.
    - But this is not acceptable for a function - there would be two possible results for $x$.

Definition 61
-------------
Let $A$ and $B$ be sets. A function $f$ with type $A → B$ is a
relation with domain $A$ and codomain $B$, such that
$$
∀x ∈ A. ∀y_1 ∈ B. ∀y_2 ∈ B. ((x,y_1) ∈ f ∧ (x,y_2) ∈ f) → y_1 = y_2.
$$

$A$ is called the *argument type* and $B$ is called the *result type* of the function.

- If an ordered pair $(x,y)$ is a member of the function, then $x ∈ A$ and $y ∈ B$
- Not that *it doesn not matter if several arguments (inputs) return the same result*.

- An expression denoting the result produced by a function when presented with an input
  $x$ is called a *function application*, e.g. $sin(2 × π)$.

Definition 62
-------------
An application of the function $f$ to the argument $x$, provided
that $f :: A → B and x :: A$, is written as either $f\ x$ or as $f(x)$, and its value is
$y$ if the ordered pair $(x,y)$ is in the graph of $f$; otherwise the application of $f$
to $x$ is undefined:
$$
f\ x = y \quad ↔ \quad (x,y) ∈ f
$$

- A type can be thought of as the set of possible values that a variable might have.
    - Thus, saying $x :: A$ means "$x$ has type $A$" and is equivalent to $x ∈ A$.
- if $x ∈ A$ and there is a pair $(x,y) ∈ f$ then we say that '$f\ x$ is defined to be
  $y$'. However, if $x ∈ A$ and there is no such pair, we say '$f\ x is undefined$'.
  - A shorthand saying the latter is $f\ x = ⊥$, where $⊥$ denotes an undefined value.

- Often, some elements of $A$ and $B$ do not appear in the ordered pair of a function.
    - The subset of $A$ for which the function is defined is called its *domain*.
    - The subset of $B$ for which the function is defined is called its *image*.

Definition 63
-------------
The domain and the image of a function $f$ are defined as:
$$
\begin{align}
domain\ f \quad & = \quad \\{x\ |\ ∃y. (x,y) ∈ f\\} \\\
image\ f  \quad & = \quad \\{y\ |\ ∃x. (x,y) ∈ f\\}
\end{align}
$$

This definition says that the domain of a function is the set of all $x$ such that
$(x,y)$ appears in its graph, while its image is the set of all $y$ such that $(x,y)$
appears. Thus a function must be defined for every element of its domain,
and it must be able to produce every element of its image.
However, the argument type and the result type may contain extra
elements that do not appear in the function graph.

Unfortunately, the terminology is not entirely standard, e.g. *codomain* can in some
instances refer to a function's argument type, but others define it totally differently.
Sometimes *range* is defined as *image*, while other times it is the result type.

Example 88
----------
The set $\\{(1,4),(2,5),(3,6)\\}$ is the graph of a function.
The domain is $\\{1,2,3\\}$ and the image is $\\{4,5,6\\}$. The function can have
any type of the form $A → B$, provided that $\\{1,2,3\\} ⊆ A$ and $\\{4,5,6\\} ⊆ B$.

11.2 Functions in Programming
=============================
In programming, we rarely define functions as relations - it is too cumbersome.
Furthermore, functions in programming has behaviour such as speed and memory consumption,
that is not taken into account when modeled as a simple relation. Instead, we define
functions as algorithms.

There are several important classes of functions defined by algorithms,
which we will examine in the next few sections. The essential questions we
are interested in are the termination and execution speed of the function.

11.2.1 Inductively Defined Functions
====================================
As its name suggests, inductively defined functions use a computation structure
that is similar to induction, which can be used to prove properties of these
functions.

Definition 64
-------------
A function defined in the following form, where $h$ is a non-
recursive function, is inductively defined:
$$
\begin{align}
f\ 0 \quad & = \quad k \\\
f\ n \quad & = \quad h(f (n − 1))
\end{align}
$$

Example 91
----------
The function defined below the sum $Σ_{i=0}^n i$, counting backwards from $n$
down to 0. It is written in the form requried for inductively defined functions,
letting $k = 0$ and $h\ x = n + x$.

    f 0 = 0
    f n = n + f (n - 1)

11.2.2 Primitive Recursion
==========================
- Computability theory = study of properties of functions viewed as algorithms
- important class of alg. = the set of *primitive recursive functions*, which are defined
  more flexibly than inductively defined functions.
- Essentially equiavelent to algorithms that can be expressed with looping structures,
  e.g. **for** loops that are *guaranteed to terminate*

Definition 65
-------------
A function $f$ is *primitive recursive* if its definition has the following form,
where $g$ and $h$ are primitive recursive functions.
$$
\begin{align}
f\ 0 x \quad & = g\ x \\\
f\ (k + 1)\ x & = h\ (f\ k\ x)\ k\ x
\end{align}
$$

This definition specifies the standard form for a primitive recursive function.
Any function that can be transformed into this form is primitive recursive, even
if its definition doesn’t obviously match the definition.

Example 94
----------
The `sqr` function, that squares a natural number $x$.

    sqr x = f 0 x
        where f 0 x = g x
              g x   = x * x

Example 95
----------
The `factorial` function can be written in the standard primitive
recursive form:

    factorial k = f k undefined
        where f 0 x = 1
              f k x = k * (f (k-1) x)

Note that `x` in this case is not really used, so we can just say that
it is undefined.

11.2.3 Computational Complexity
===============================
The *computational complexity* of a function is a measure of how costly
it is to evaluate. The memory consuption and the time required are common
measures of the cast of a function.

Recursion can create some very expensive computations. A famous example
is Ackermann's function:

Definition 66
-------------
Ackermann's function is

> ack 0 y = y + 1
> ack x 0 = ack (x - 1) 1
> ack x y = ack (x - 1) (ack x (y - 1))

The ack function is easy to evaluate for small arguments, but the time it takes
grows extremely quickly as $x$ and $y$ increase. Books on computability theory
and algorithmic complexity show why this happens, but it is interesting to
make a table for yourself of ack x y for small values of the arguments.

11.2.4 State
============
A function always returns the same result, given the same argument. This kind
of repeatability is essential: if
$\sqrt{4} = 2$ today, then $\sqrt{4} = 2$ also tomorrow. Some
computations do not have this property. For example, many programming
languages provide a ‘function’ that returns the current date and time of day,
and the result returned from such a query will definitely be different tomorrow.
The entire set of circumstances that can affect the result of a computation is
called the *state*.

It is possible to describe computations
with state using pure mathematical functions. The idea is to include the state
of the system as an extra argument to the function.

- Suppose a function `f :: Int -> Int`, but the result also depends
  on the state of the computer system (e.g. ToD, or File System).
- We can define a type `State` that represents all the relevant aspecs of
  the state, and modify `f` to receive that state as an argument.

Like so

    f :: State -> Int -> Int

Now $f$ can return a result that depends on the time of day, even though it is a
mathematical function. Given the same system state and the same argument,
it will always return the same result.

- All functions can be made pure by passing the necessary state as an argument
- However, it becomes clunky/annoying/error prone
- Imperative languages make the state implicit, allowing *side effects* to
  modify the state.
    - This, however, makes reasoning about the program more difficult.
- In math, in an equation of the form $x = y$ you can replace $x$ by $y$,
  or vice versa.
- This is called *subsitituting equals* or *equational reasoning*.
    - This does not generally work in imperative languages because of
      *side effects*.
        - If a function `f` depends on system state, it is not even true
          that `f x = f x`.
        - You can still reason formally about imperative programs using
          the *weakest precondition method*, but this is more complex.
    - In Haskell, you can use *monads* to have implicit state while having
      pure functions, but we will not explain that here.

11.3 Higher Order Functions
===========================
- We can distinguish between data (numbers, chars, etc.) and algorithms
  (code to be executed).
- example data: 23 and `[1,2,3]`
- example code: `length` function
- in math and Haskell, functions can return functions! Not just data
    - functions can also take other functions as arguments
- these kinds of functions are called *higher order functions*.

Definition 67
-------------
A *first order function* has ordinary (non-function) arguments and
result. A *higher order functions*i s one that either takes a function
as an arguments, or returns a function as its value, or both.

Examples of HOF: map, filter, foldr
Examples of FOF: length, concat, head, tail

11.3.1 Functions That Take Functions as Arguments
=================================================
Any function that takes another function as an argument is higher order. This
kind of higher order function will have a type something like the following:
$$
f :: (··· → ···) → ···
$$
Generally, this variety of higher order function will also take
a data argument, and it will apply its function argument to its data argument
in a special way.
E.g. `map` takes a function and applies it to each element of a list.
We can also define `twice f x = f (f x)`, which takes a function and
applies it twice to its second argument.

Notice that `f` is quite constrained in `twice`, because it must take
an argument of the same type that it returns, e.g. `a -> a`.

*Control structures* can be implemented using HOF. Examples of
*control structures* are **if**, **for** loops, **while** loops etc.

For example, to implement an if statement:

    ifTrue :: Bool -> a -> a
    ifTrue True  x _ = x
    ifTrue False _ x = x

11.3.2 Functions That Return Functions
======================================
Any function that returns another function as its result is higher order, and its
type will have the following form:
$$
f :: ··· → (··· → ···)
$$

To understand this kind of higher order function, it is helpful to study the
function graph in detail. First, we define some first order functions to be used
in the examples:

> ident, double, triple, quadruple :: Int -> Int
> ident 1 = 1
> ident 2 = 2
> ident 3 = 3
>
> double 1 = 2
> double 2 = 4
> double 3 = 6
>
> triple 1 = 3
> triple 2 = 6
> triple 3 = 9
>
> quadruple 1 = 4
> quadruple 2 = 8
> quadruple 3 = 12

Their graphs:

$$
ident     = \\{(1,1),(2,2),(3,3)\\}
double    = \\{(1,2),(2,4),(3,6)\\}
triple    = \\{(1,3),(2,6),(3,9)\\}
quadruple = \\{(1,4),(2,8),(3,12)\\}
$$

Now we define a higher order function, `multby`, which takes one argument
of type `Int` and returns a function with type `Int -> Int`.

> multby :: Int -> (Int -> Int)
> multby 1 = ident
> multby 2 = double
> multby 3 = triple
> multby 4 = quadruple

Now consider the value of
`multby 3 2`. This is syntactically equivalent to `(multby 3) 2`, and we can
evaluate the expression using the function definitions. Notice that `multby 3`
returns a function that multiplies things by 3, so `multby 3 2` evaluates to 6:

    multby 3 2
        = (multby 3) 2           syntax rule of Haskell
        = triple 2               definition of multby (third equation)
        = 6                      definition of triple (second equation)

If a function returns another function as its result, then its graph will be
a set of ordered pairs `(x,y)` where `x` is the argument to the function and `y` is
another function graph. Figure 11.5 shows the graph of `multby`:

    multby = {(1, {(1,1), (2,2), (3,3) })
              (2, {(1,2), (2,4), (3,6) })
              (3, {(1,3), (2,6), (3,9) })
              (4, {(1,4), (2,8), (3,12)})}

![Figure 11.5](./images/fig.11.5.jpg)

11.3.3 Multiple Arguments as Tuples
===================================
Technically, a function (in either mathematics or Haskell) takes exactly one
argument and returns exactly one result. There are two ways to get around
this restriction. One method is to package multiple arguments (or multiple
results) in a tuple. Suppose that a function needs two data values, x and y.
The caller of the function can build a pair (x,y) containing these values, and
that pair is now a single object which can be passed to the function.

Example 104
-----------
The following function takes two numbers and adds them together:

    add :: (Integer,Integer) -> Integer
    add (x,y) = x+y

11.3.4 Multiple Results as a Tuple
==================================
Example 105
------------
The following Haskell function takes an integer x, and returns
two results x − 1 and x + 1 packaged in a pair (i.e., a 2-tuple):

    addsub1 :: Integer -> (Integer,Integer)
    addsub1 x = (x-1, x+1)

11.3.5 Multiple Arguments with Higher Order Functions
=====================================================
Suppose a function needs to receive two arguments, $x :: a$ and
$y :: b$, and it will return a result of type $c$. The idea is to define
the function with type
$$
f :: a → (b → c)
$$

Thus, $f$ takes one argument and returns a function that takes the next
argument.
This method is called *currying*, in honour of the logician called
Haskell B. Curry (for whom the programming language Haskell is also named).

The graph of `f` is a set of ordered pairs; the first element of each pair is
a data value of type `a`, while the second element is the function graph for the
result function. That function graph contains, in effect, the information that
`f` obtained from the first argument.

Example:

    mult :: Integer -> (Integer -> Integer)
    mult x y = x * y
    -- mult x = (\y -> x * y) -- alternative "explicit" definition


The graph of mult is a set of ordered pairs of the form $(k, f_k)$, where $k$ is the
value of the first argument to mult, and $f_k$ is the graph of a function that takes
a number and multiplies it by $k$:

11.4 Total and Partial Function
===============================
- *domain* of a function $f :: A → B$ is the subset of $A$ that is all the elements
  of $A$ for which $f$ is defined.
- $A$ is thought of as a *constraint*
    - If you apply $f$ to $x$, then it is required that $x ∈ A$.
- The *domain* of $f$ must be a subset of $A$.
    - Some functions have a domain that is equal to $A$
    - Others' domain are a subset of $A$

Definition 68
-------------
Let $f :: A → B$ be a function. If domain $f = A$ then $f$ is a *total*
function. If domain $f ⊂ A$ then $f$ is a *partial* function.

- if $f$ is partial and $x ∈ $ domain $f$, then we say $f\ x$ is defined.
- There are several ways to descibe an application of $f\ y$ where $y :: A$
  but $y ∉ $ domain $f$.
    - common in math: "$f\ y$ is undefined"
    - in CS: $f\ y = ⊥$ where $⊥$ is pronounced *bottom*.

Example 107
-----------
This function has argument type `Integer`, but its domain is $\\{1,2,3\\}$.

    f :: Integer -> Char
    f 1 = 'a'
    f 2 = 'b'
    f 3 = 'c'

Which means that `f 1 = 'a'` and `f 4 = ⊥`. The graph of `f` is
$\\{(1, 'a'), (2, 'b'), (3, 'c')\\}$

Partial functions are useful when describing programs.
Compilers always work with the type of a function - the domain
can be very hard/impossible to deduce.

If a function is applied to a value in its argument type, the compiler
will not complain.
However, if the value is not in the domain of the function, then a
runetime error will be raised.

- An application of a total function will always terminate and produce
  a result.
- An application of a partial function has three possible outcomes:
    - terminate with a result
    - produce a runtime error message
    - go in an infinite loop

- Some functions will run forever. This is most often not the desired result!
- It would be extremely useful to have a function called `wouldHalt` that
  takes an *arbitrary* function `f` and an argument value `x`, and returns
  `True` if and only if `f` would halt if we actually evaluate `f x`.

This is called the *Halting Problem*. And it is impossible.

Theorem 76
----------
There does not exist a function `wouldHalt` such that for all `f`
and `x`,

$$
\mathtt{wouldHalt f x} =
    \begin{cases}
        \mathtt{True},  & \text{if } \mathtt{f\ x}\ \text{terminates} \\\
        \mathtt{False}, & \text{if } \mathtt{f\ x}\ \text{does not terminate}
    \end{cases}
$$

*Proof*. Define the function paradox as follows:

    paradox :: Integer -> Integer
    paradox x =
        if wouldHalt paradox x
        then paradox x
        else 1

Now consider the expression `paradox x`. One of the following two cases
must hold:

- Suppose `paradox x` halts and produces a result. Then
  $$
      \tt{wouldHalt\ paradox\ x\ ⇒\ True}
  $$
  therefore the definition reduces to `paradox x = paradox x`, so `paradox x`
  does not halt. This is a contradiction; therefore it is impossible that
  `paradox x` halts.

- Suppose `paradox x` does not halt. Then
  $$
      \tt{wouldHalt\ paradox\ x\ ⇒\ False}
  $$
  The definition them simplifies to `paradox x = 1`, and it halts.

To summarise, if `paradox x` halts then it does not halt, and if it does not halt
then it halts! There is no possibility which avoids contradiction. Therefore the
function `wouldHalt` does not exist.

The proof that the Halting Problem is unsolvable was discovered in the
1930s by Alan Turing. This is one of the earliest and most important results
of computability theory. One of the commonest methods for proving that a
function does `not` exist is to show how it could be used to solve the Halting
Problem, which is unsolvable. This theorem also has major practical impli-
cations: it means that some software tools that would be very useful cannot
actually be implemented.

A consequence of the unsolvability of the Halting Problem is that it is
impossible to write a Haskell function that determines whether another Haskell
function is total or partial. However, we can introduce data structures to
represent the graphs of partial functions, with an explicit value that represents
$⊥$.

This means that we need to use a new type to represent the result returned by
a function, called `FunVals`. This type has two kinds of element. The first is
`Undefined`, which means that the result value is `⊥`. The other is called `Value`,
and takes an argument that is the actual value returned by the function.

> data FunVals a = Undefined | Value a deriving (Show, Eq)

Now we can define a predicate that returns True if its argument is a partial
function (in other words if some member of its result type is undefined), and
False otherwise:

> isPartialFunction :: (Ord a, Ord b) => Set a -> Set b -> Set (a, FunVals b) -> Bool
> isPartialFunction (Set argT) (Set resT) (Set fun) =
>    let isUndefined x =
>           let maps = filter ((x ==) . fst) fun
>           in  (length maps == 0) || any ((== Undefined) . snd) maps
>    in
>    any isUndefined argT

There is also `isFun` that takes a relation, and determines whether the relation is also
a function

> isFun :: (Ord a, Ord b) => Set a -> Set b -> Set (a, FunVals b) -> Bool
> isFun (Set argT) (Set resT) (Set fun) =
>    let pairs x = filter ((== x) . fst) fun
>        onlyOne pairs = length pairs == 1
>        sameResults [] = True
>        sameResults pairs =
>           let (_, v) = head pairs
>           in all ((== v) . snd) (tail pairs)
>    in all (\x -> let p = pairs x in onlyOne p || sameResults p) argT

Exercise 1
----------
Decide whether the following functions are partial or total, and then run the
tests on the computer:

(a):

    isPartialFunction
        [1,2,3] [2,3] [(1, Value 2), (2, Value 3), (3, Undefined)]
    -- Yeap!

(b):

    isPartialFunction (Set [1,2]) (Set [2,3]) (Set [(1, Value 2), (2, Value 3)])
    -- False!

Exercise 2
----------
Work out the following expressions, by hand and using the computer:

    isFun (Set [1,2,3]) (Set [1,2]) (Set [(1, Value 2), (2, Value 2)]) -- Yes
    isFun (Set [1,2,3]) (Set [1,2]) (Set [(1,Value 2),(2,Value 2),
                                          (3,Value 2),(3,Value 1)]) -- Nope
    isFun (Set [1,2,3]) (Set [1,2]) (Set [(1,Value 2), (2,Value 2), (3,Value 2)]) -- Yes

Exercise 3
----------
What is the value of `mystery x` where `mystery` is defined as:

> mystery :: Int -> Int
> mystery x = if mystery x == 2 then 1 else 3

Well, that depends on `x`, but its graph looks like this

    {(-Inf,1),(-Inf + 1, 1), ... (1,3),(2,1),(3,1),(4,1) ... (Inf,1)}

Exercise 4
----------
What is the value of `mystery2 x` where `mystery2` is defined as

> mystery2 :: Int -> Int
> mystery2 x = if x == 20 then 2 + mystery2 x else 3

$$
\begin{align}
∀x. x ≠ 20 \quad & → \quad \mathtt{mystery2\ x} = 3 \\\
∀x. x = 20 \quad  & → \quad \mathtt{mystery2\ x} = ⊥
\end{align}
$$

11.5 Function Composition
=========================
- "Pipeline" functions
- Computation as a sequence of function applications
    - output of $f_1$ is input of $f_2$

Definition 69
-------------
Let $g :: a → b$ and $f :: b → c$ be functions. Then the *composition* of $f$ with $g$,
written $f ∘ g$ as a function such that:
$$
\begin{align}
(f ∘ g)    \quad& :: \quad a → c \\\
(f ∘ g)\ x \quad& =  \quad f\ (g\ x)
\end{align}
$$

Theorem 77
----------
Functional composition $(∘)$ is associative. That is, for all functions
$h :: a → b, g :: b → c, f :: c → d,$
$$
f ∘ (g ∘ h) = (f ∘ g) ∘ h
$$
and both sides of the equation have type $a → d$.

*Proof*. Choose arbitrary $x :: a$, and use *equational reasoning* to prove that
$$
(f ∘ (g ∘ h))\ x = ((f ∘ g) ∘ h)\ x
$$

$$
\begin{align}
  & (f ∘ (g ∘ h))\ x \\\
= & f\ ((g ∘ h)\ x) \\\
= & f\ (g\ (h\ x)) \\\
= & (f ∘ g)\ (h\ x) \\\
= & ((f ∘ g) ∘ h)\ x
\end{align}
$$

This means we can omit parentheses totally when writing compositions.
But we need parentheses when applying the function

- incorrect: $f ∘ g ∘ h ∘ i\ x$
- correct: $(f ∘ g ∘ h ∘ i)\ x$

Exercise 7
----------
Functions are often composed with each other in order to form a
pipeline that processes some data. What does the following expression
do?

    ((map (+ 1)) . (map snd)) xs

for each `x` in `xs`, get the second element and add one to 1

Exercise 8
----------
Sometimes access to deeply nested constructor expressions is performed by
function composition. What is the value of this expression?

    (fst . snd . fst) ((1, (2, 3)), 4)
    -- fst1 = (1, (2,3))
    -- snd  = (2,3)
    -- fst2 = 2

11.6 Properties of Functions
============================
We have used four sets to characterise a function: the argument type, the
domain, the result type, and the image. There are several useful properties
of functions that concern these four sets, and we will examine them in this
section.

11.6.1 Surjective Functions
===========================
A surjective function has an image that is the same as its result type (sometimes
called the range). Thus the function can, given suitable input, produce any of
the elements of the result type.

Definition 71
-------------
A function $f$ is *surjective* if
$$
∀b ∈ B.\ (∃a ∈ A. f\ a = b)
$$

Most, if not all, functions that return a Boolean result are surjective - only 2
values inhabit the Boolean type, True and False, and most boolean functions return
either True or False.

Example 114
-----------
The `times_two` function takes an integer and doubles it. It is **not** surjective
because its image is the set of all even integers, while its type is all integers.

The function `isSurjective` takes a graph representation of a function and
determines whether it is surjective.

> isSurjective :: (Ord a, Ord b) => Set a -> Set b -> Set (a, FunVals b) -> Bool
> isSurjective (Set argT) (Set resT) (Set graph) =
>    let image g = let extract (Value x) = x in map (extract . snd) g
>    in (Set resT) == (Set $ image graph)

Exercise 9
----------
Decide whether the functions represented by the graphs in the following
examples are surjective, and then check with the computer

    isSurjective (Set [1,2,3]) (Set [4,5]) (Set [(1, Value 4), (2, Value 5), (3, Value 4)])
        -- True
    isSurjective (Set [1,2,3]) (Set [4,5]) (Set [(1, Value 4), (2, Value 4), (3, Value 4)])
        -- False

Exercise 10
-----------
Which of the following functions are surjective?

- (a) $ f :: A → B$ where $A = \\{1,2\\}, B = \\{2,3,4\\}$ and $f = \\{(1,2),(2,3)\\}$
- (b) $g :: C → D$, where $C = \\{1,2,3\\}, D = \\{1,2\\}$ and $g = \\{(1,1), (2,1), (3,2)\\}$

Not a
b is

Exercise 11
-----------
Which of the following functions are *not* surjective, and why?

- (a) `map increment :: [Int] -> [Int]`
- (b) `take 0 :: [a] -> [a]`
- (c) `drop 0 :: [a] -> [a]`
- (d) `(++) xs :: [a] -> [a]`

a is surjective, because every `[Int]` has another `[Int]` where each element is 1 smaller.
b is **not** surjective, because its result is always `[]`, which is not the only member of `[a]`
c is surjective, because it is equivalent to `id` for `[a]`
d is also surjective, I would say.

11.6.2 Injective Functions
==========================
- A function maps each element of its domain to *exactly one* element of the image.
- An *injective* function has a similar property
    - each element of the image is the result of applying the function to *exactly one*
      element of the domain.

Definition 72
-------------
The function $f :: A → B$ is injective if
$$
    ∀a,a' ∈ A. a ≠ a' → f a ≠ f a'
$$

Example 124
-----------
The following Haskell functions are injective:

    (/\) True :: Bool -> Bool
    increment :: Int -> Int
    id :: a -> a
    times_two :: Int -> Int

We can write the follwing Haskell function to check for injectiveness

> isInjective :: (Ord a, Ord b) => Set a -> Set b -> Set (a, FunVals b) -> Bool
> isInjective (Set argT) (Set resT) (Set graph) =
>    let apply x = case lookup x graph of
>                       Just x' -> x'
>                       Nothing -> Undefined
>        outer a =
>            let inner a' = if a /= a' then apply a /= apply a' else True
>            in all inner argT
>    in all outer argT

Exercise 12
-----------
Determine whether the functions in these examples are injective,
and check your conclusions using the computer:

(a)

    isInjective (Set [1,2,3]) (Set [2,4]) (Set [(1,Value 2),(2,Value 4),(3,Value 2)])
    -- False

(b)

    isInjective (Set [1,2,3]) (Set [2,3,4]) (Set [(1,Value 2),(2,Value 4),(3,Undefined)])
    -- True

Exercise 13
-----------
Which of the following functions are injective?

- (a) $f :: A → B$, where $A = \\{1,2\\}, B = \\{1,2,3\\}$ and $f = \\{(1,2), (2,3)\\}$
- (b) $g :: C → D$, where $C = \\{1,2,3\\}, D = \\{1,2\\}$ and $g = \\{(1,1), (2,2)\\}$

Both? Even though b is partial

Exercise 14
-----------
Suppose that $f :: A → B$ and $A$ has more elements than $B$.
Can $f$ be injective?

Yes, if $f$ is partial. If $f$ is total, then it cannot.

11.6.3 The Pigeonhole Principle
===============================
If $A$ and $B$ are finite sets, where $|A| > |B|$, then no injection exists from
$A$ to $B$.

- Each element of $A$ must have a unique transformation in $B$.
    - "At most one pigeon fits in a pigeonhole".
- Frequently used in set theory proofs, especially proofs of theorems about functions.

Theorem 78 (Pigeonhole Principle)
=================================
Let $A$ and $B$ be finite sets, such that $|A| > |B|$ and $|A| > 1$.
Let $f :: A → B$. Then
$$
∃a_1,a_2 ∈ A. (a_1 ≠ a_2) ∧ (f\ a_1 = f\ a_2)
$$

11.7 Bijective Functions
========================

Definition 73
-------------
A function is *bijective* if it is both surjective and injective. An
alternative name for 'bijective' is *one-to-one and onto*. A bijective
function is sometimes called a *one-to-one correspondence*.

![Figure 11.10](./images/fig.11.10.jpg)

The domain and image of a bijective function must have the same number of
elements. Thsi is stated formally in the following theorem:

Theorem 79
----------
Left $f :: A → B$ be a bijective function.
Then $|\text{domain}\ f| = |\text{image}\ f|$.

*Proof*. Suppose that the domain A is larger than the image B. Then f cannot
be injective, by the Pigeonhole Principle. Now suppose that B is larger than
A. Then not every element of B can be paired with an element of A: there are
too many of them, so f cannot be surjective. Thus a function is bijective only
when its domain and image are the same size.

A bijective function must have a domain and image that are the same
size, and it must also be surjective and injective.

In Haskell, we can express this as a function that takes a domain,
codomain and a function, and determines whether the function is bijective.

> isBijective :: (Ord a, Ord b) => Set a -> Set b -> Set (a, FunVals b) -> Bool
> isBijective a@(Set argT) r@(Set resT) f@(Set fun) =
>    let lengths = length argT == length resT
>        inj = isInjective a r f
>        sur = isSurjective a r f
>    in
>    lengths && inj && sur

Exercise 15
-----------
Determine whether the following functinos are bijective,
and check your conclusions using the computer.

    isBijective (Set [1,2]) (Set [3,4]) (Set [(1, Value 3), (2, Value 4)])
        -- Yes!
    isBijective (Set [1,2]) (Set [3,4]) (Set [(1, Value 3), (2, Value 3)])
        -- No! Not surjective

11.7.1 Permutations
===================

Definition 74
-------------
A *permutation* is a bijective function $f :: A → A$, i.e. it must have
the same domain and image.

Example 128
-----------
The identity function is a permutation.

The only thing a permutation function can do is to shuffle its input; it cannot
produce any results that do not appear in its input.

Example 129
-----------
Let $A = \\{1,2,3\\}$ and let $f :: A → A$ be defined by the graph
$\\{(1,2),(2,3),(3,1)\\}$. Then $f$ is a permutation.

Example 130
-----------
Let $X = [x_1 ,x_2 ,...,x_n ]$ be an array of values, and let $Y =
[y_1 ,y_2 ,...,y_n]$ be the result of sorting $X$ into ascending order. Define $A =
\\{1,2,...,n\\}$ to be the set of indices of the arrays $X$ and $Y$ . We can define a
function $f :: A → A$ that takes the index of a data value in $X$ and returns the
location of that same data value in $Y$ . Then $f$ is a permutation.
Sometimes it is convenient to think of a permutation as a function that
reorders the elements of a list; this is often simpler and more direct than defining
a function on the indices. For example, it is natural to say that a sorting
function has type $[a] → [a]$. Technically, the function $f$ used in Example 130 is
a permutation. The following definition provides a convenient way to represent
a permutation as a function that reorders the elements of a list:

Definition 75
-------------
A *list permutation function* is a function $f :: [a] → [a]$ takes a list
of values and rearranges them using a permutation $g$, such that
$$
xs\ !!\ i = (f\ xs)\ !!\ (g\ i)
$$

Example 131
-----------
The functions `sort` and reverse are `list` permutation func-
tions.

If you rearrange a list of values and then rearrange them again, you sim-
ply end up with a new rearrangement of the original list, and that could be
described directly as a permutation. This idea is stated formally as follows:

Theorem 80
----------
Let $f,g :: A → A$ be permutations. Then their composition
$f ◦ g$ is also a permutation.

The following Haskell function determines whether a function is a permutation.

> isPermutation :: (Ord a) => Set a -> Set a -> Set (a, FunVals a) -> Bool
> isPermutation argT resT fun =
>    argT == resT && isBijective argT resT fun

Exercise 16
-----------
Let $A = \\{1,2,3\\}$ and $f :: A → A$, where $f = \\{(1,2),(2,1),(3,2)\\}$
Is $f$ bijective? Is it a permutation.

Yes, and yes.

Exercise 17
-----------
Determine whether the following functons are permutations, and check
them using the computer.

    isPermutation
        (Set [1,2,3])
        (Set [1,2,3])
        [(1, Value 2), (2, Value 3), (3, Undefined)]
    -- No, because it is not suerjective

    IsPermutation
        (Set [1,2,3])
        (Set [1,2,3])
        [(1, Value 2), (2, Value 3), (3, Value 1)]
    -- Yes!

Exercise 18
-----------
Is `f`, defined below, a permutation?

    f :: Integer -> Integer
    f x = x + 1

Yes

Exercise 19
-----------
Suppose we know that the composition $f ∘ g$ of the functions
$f$ and $g$ is surjective. Show that $f$ is surjective.

Since $(f ∘ g)\ x = f\ (g\ x)$, then $f$ must be surjective if $f ∘ g$
is surjective.

11.7.2 Inverse Functions
========================
A function $f :: A → B$ takes an argument $x :: A$ and gives the result $(f x) :: B$.
The inverse of the function goes the opposite direction: given a result $y :: B$,
it produces the argument $x :: A$, which would cause $f$ to yield the result $y$.

Not all functions have an inverse. For example, if both $(1,5)$ and $(2,5)$ are
in the graph of a function, the nthere is no unique argument that yields 5.
Therefore, the definition of inverse requries teh function to be a bijection.

Definition 76
-------------
Let $f :: A \->  B$ be a bijection. Then the *inverse* of $f$, denoted
$f^{-1}$, has type $f^{-1} :: B → A$, and its graph is
$$
\\{(y,x)\ |\ ∃x,y. (x,y) ∈ f \\}
$$

Example 132
-----------
Let $A = \\{1,2,3\\}, B = \\{4,5,6\\}$ and let $f :: A → A$ have the graph
$\\{(1,4),(2,5),(3,6)\\}$. Then its inverse is $f^{-1} = \\{(4,1),(5,2),(6,3)\\}$

Example 133
-----------
The Haskell function `decrement` is the inverse of `increment`.
Similarly, `increment` is the inverse of `decrement`.

Exercise 20
-----------
Suppose that $f :: A → A$ is a permutation. What can you say about
$f^{-1}$?

It will also be a permutation.