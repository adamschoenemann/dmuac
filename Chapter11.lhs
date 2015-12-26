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
>    let image = map extract . filter (/= Undefined) . map snd
>        extract (Value x) = x
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

11.8 Cardinality of Sets
========================
- "The number of elements of a set"
- Bijections are good for reasoning about the sizes of sets.
- A bijection is often called a one-to-one correspondence.
- If there is a bijection $f :: A → B$, then it is possible to
  associate each element of $A$ with exactly one element of $B$,
  and vice versa.
- Counting a set can be thought of as associating 1 with an element,
  2 with another, 3 with one more and so on.
    - When all elements are associated with the number, the last
      element's number is the size of the set.
    - Thus, the number of objects in $S$ is $n$, if there is a bijection
      $f :: \\{1,2,...,n\\} → S$.
      - This is used to formally define the size of a set, which is called
        its *cardinality*

Definition 77
-------------
A set $S$ is *finite* if and only if there is a natural number $n$ such
that there is a bijection mapping the natural numbers $\\{0,1,...,n-1\\}$ to $S$.
The *cardinality* of $S$ is $n$, and it is written as $|S|$.

- If $S$ is finite, then it can be counted, and the result of the count
  is its cardinality (i.e. the number of elements in contains).
- How do we define a set to be infinite?
    - Cannot say that that $|S|$ is infinity, because infinity is not
      a natural number.
    - Consider a one-to-one correspondence (bijection) from the set $N$ of
      natural numbers and the set $E$ of even numbers.
      $$
      \begin{align}
        0\quad 1\quad 2\quad 3\quad 4\quad ... \\\
        0\quad 2\quad 4\quad 6\quad 8\quad ...
      \end{align}
      $$
    - We can calc the *i*th elem of the 2nd row by applying $f$ to the $i$th
      elem of the first row, where $f :: N → E$ is defined b $f\ x = 2 × x$
    - $f$ is injective, and $E ⊂ N$ (*proper* subset).
    - It would be impossible to find an $f$ with these properties for a finite set

Definition 78
-------------
A set $A$ is *infinite* if there exists an injective function $f :. A → B$
such that $B$ is a proper subset of $A$.

We can use the proeprties of a function over a finite domain $A$ and a result
type $B$ to determine their relative cardinalities:

- If $f$ is a surjection then $|A| ≥ |B|$.
- If $f$ is an injection then $|A| ≤ |B|$.
- If $f$ is a bijection then $|A| = |B|$.

Earlier we discussed counting the elements of a finite set, placing its ele-
ments in a one-to-one correspondence with the elements of $\\{1,2,...,n\\}$. Even
though there is no natural number n which is the size of an infinite set, we can
use a similar idea to define what it means to say that two sets have the same
size, *even if they are infinite*:

Definition 79
-------------
Two set $A$ and $B$ have the same cardinality if there is a bijection
$f :: A → B$.

Example 134
-----------
Let $A = \\{1,2,3\\}$ and $B = \\{cat,mouse,rabbit\\}$. Define $f ::
A → B$ as
$f = \\{(1,cat),(2,mouse),(3,rabbit)\\}$.
Now $f$ is surjective and injective (you should check this), so it is a bijection.
Hence the cardinality of B is
$$
|B| = 3.
$$
The previous example may look unduly complicated, but the point is that
exactly the same technique can be used to investigate the sizes of infinite sets.

Example 135
-----------
We can place the set I of integers into one-to-one correspon dence
with the set $N$ of natural numbers:
$$
\begin{align}
N = & 0\quad  1\quad 2\quad  3\quad 4\quad  5\quad 6\quad ... \\\
I = & 0\quad −1\quad 1\quad −2\quad 2\quad −3\quad 3\quad ...
\end{align}
$$

This is done with the function $f :: I → N$, defined as:
$$
f\ x =
\begin{cases}
2 × x, & \mbox{if } x ≥ 0 \\\
−2 × x − 1, & \mbox{if } x < 0
\end{cases}
$$
Now $f$ is a bijection (you should check that it is), so $I$ has the same cardinality
as $N$.
We have already established that the cardinality of the set of even numbers
is the same as the cardinality of $N$, so this is also the same as the cardinality
of $I$. The size of the set of integers is the same as the size of the set of integers
that are non-negative and even!

Definition 80
-------------
A set $S$ is *countable* if and only if there is a bijection $f :: N → S$

A set is countable if it has the same cardinality as the set of natural numbers.
In daily life, we use the word *counting* to describe the process of enumerating
a set with $1,2,3,...$, so it is natural to call a set countable if it can be
enumerated - even if the set is infinite.

Exercise 21
-----------
Explain why there cannot be a finite set that satisifies Definition 78.

Because then $f$ cannot be injective while $B ⊂ A$.

Exercise 22
-----------
Suppose that your manager gave you the task of writing a program that
determined whether an arbitrary set was finite or infinte.
Would you accept it? Explain why or why not.

Nope, it is impossibruh! We cannot proof a set is infinite by enumerating it
programatically.

Exercise 23
-----------
Suppose that your manager asked you to write a program that decided whether
a function was a bijection. How would you respond?

Also impossible, unless it is only restricted to functions with finite and
countable argument- and result-types.

11.8.1 The Rational Numbers Are Countable
=========================================
- Some inifinite sets are countable, others are not
- We can often print out the elements of a countable set
    - If set is infinite, we will never print the entire set but any
      element is guaranteed to be reached at some point.
- If an infinite set is not countable, we can not even guarantee that
  a given element will eventually be printed.

- Consider the rational numbers (numbers of the form $x/y$, where $x,y$ are integers).
- We want to enumerate all the ratios
    - We need to put them in a one-to-one correspondence with $N$.
- We create a series of columns, each with an index $n$ indicating its place
  in the series.
    - A column gives all possible fractions with $n$ as the numerator.

$$
\begin{array}
((1,1) &       &       &       &       \\\
(1,2) & (2,1) &       &       &       \\\
(1,3) & (2,2) & (3,1) &       &       \\\
(1,4) & (2,3) & (3,2) & (4,1) &       \\\
(1,5) & (2,4) & (3,3) & (4,2) & (5,1) \\\
  .   &   .   &   .   &   .   &   .   \\\
  .   &   .   &   .   &   .   &   .   \\\
  .   &   .   &   .   &   .   &   .
\end{array}
$$

Every line in this sequence is finite, so it can be printed completely before
the next line is started. Each time a line is printed, progress is made on all of
the columns and a new one is added. Every ratio will eventually appear in the
enumeration. Thus the set $Q$ of rational numbers can be placed in one-to-one
correspondence with $N$, and $Q$ is countable.

Exercise 24
-----------
Create the above definition in Haskell, and use it with the following two
expressions

    take 3 rationals
    take 15 rationals

> rationals :: [[(Int, Int)]]
> rationals = [(1,1)] : map rationals' rationals where
>       rationals' prev =
>           let (z,_) = last prev
>           in  map (\(x,y) -> (x,y+1)) prev ++ [(z+1,1)]


11.8.2 The Real Numbers Are Uncountable
- If $A ⊆ B$ we cannot say that $B$ is larger than $A$, since they
might be equal.
- Surprisingly, even if we know $A ⊂ B$ we *still* cannot say that
  $B$ has more elements
    - It is possible that both are infinite but countable.
    - Example: The set of even numbers is a proper subset of the naturals,
      yet both sets have same cardinality!
- Some infinite sets are not countable.
    - So much bigger than the naturals that there is no possible way
      to make a one-to-one correspondence between it and the naturals.
    - The Reals have this prop.
    - There is a technique called *diagonalisation* which is useful for
      showing that one infinte set has a larger cardinality than another.

- Consider a real to be a string of digits.
- E.g. $x$ such that $0 ≤ x < 1$
    - Written in the form $.d_0 d_1 d_2 d_3 ...$
    - There is no limit to the length of this string of digits.
- Suppose there is a way to make a one-to-one correspondence with the set
  of natural numbers (i.e. suppose the reals are countable)
- Then we can make a table where the $i$th row contains the $i$th real
  number $x_i$, and it contains the list of digits comprising $x_i$
- Name the digits in that dist $d_{i,0}\ d_{i,1}\ d_{i,2} ...$.
- Thus $d_{i,j}$ means the $jth$ digit in the decimal representation of the
  $i$th real number $x_i$.
- Here is the table that allegedly contains a complete enumeration of the
  set of real numbers:
  $$
  \begin{array}
    .d_{00} & d_{01} & d_{02} & d_{03} & ... \\\
    .d_{10} & d_{11} & d_{12} & d_{13} & ... \\\
    .d_{20} & d_{21} & d_{22} & d_{23} & ... \\\
    ...     & ...    & ...             & ...
  \end{array}
  $$
- Now, we will show that this list is incomplete by constructing a new
  real number $y$ which is definitely not in the list.
- $y$ also has a decimal representation, which we call
  $.d_{y0}\ d_{y1}\ d_{y2} ...$
- Now, ensure that $y$ is different from $x_0$, and it is sufficient to make the
  0th digit of $y$ (i.e. $d_{y0})$ different from the corresponding digit of $x_0$
  (i.e. $d_{00}).
- Do this by defining a function $different\ :: Digit → Digit$
- Can be done in many different ways, here is one:
  $$
  different\ x =
  \begin{cases}
    0, & \mbox{if } x ≠ 0 \\\
    1, & \mbox{if } x =  0
  \end{cases}
  $$
- Doesn't matter exactly how it is defined, as long as it returns a digit
  that is diff from its argument.
- We must ensure that $y$ is different from $x_i$ for *every* $i ∈ N$, not
  just $x_0$.
- Easy, just make the $i$th digit of $y$ different from the $i$th digit og $x_i$
- $$
  d_{yi} = different\ x_{ii}
  $$
- Now we have defined a number $y$ that is real and different from $x_i$ for any
  $i$.
- Construction of $y$ is independent of enumeration of $x_i$
    - For *any alleged enumeration whatsoever* of the real numbers, our construction
      will give a new real number that is not in that list.
- Thus, it is impossible to set up a one-to-one correspondence between $R$ and
  $N$.
- The conclusion is thus that the reals are infinite and uncountable.

11.10 Review Exercises
======================
Exercise 25
-----------
A program contains the expression `(f . g) x`

(a) Suppose that when this is evaluated, the `g` function goes into an
infinite loop. Does this mean that the entire expression is $⊥$?

Yes.

(b) Now, suppose that the appliaction of `f` goes into an infinite looop.
Does this mean that the entire expression is $⊥$.

Yes.

Exercise 26
-----------
Each part of this exercise is a statement that might be *correct or
incorrect*. Write Haskell programs to help you experiment, so that you
can find the answer.

(a) Let $f ∘ g$ be a function. If $f$ and $g$ are surjective then $f ∘ g$
is surjective.

> type ArgT a = Set a
> type ResT b = Set b
> type AppT a b = Set (a, FunVals b)
> type FuncRep a b = (ArgT a, ResT b, AppT a b)
>
> mkFunHelper :: (a -> b) -> [a] -> (ArgT a, ResT b, AppT a b)
> mkFunHelper fn dom =
>     (Set dom, Set $ map fn dom, Set $ map (\x -> (x, Value $ fn x)) dom)
>
> functionalComposition :: (Ord a, Ord b, Ord c) => AppT b c -> AppT a b -> AppT a c
> functionalComposition (Set appT1) (Set appT2) =
>      let appComp = map (\(x, y) -> (x, app y)) appT2
>          app Undefined = Undefined
>          app (Value y) =
>               case filter ((== y) . fst) appT1 of
>                   (_,z):zs -> z
>                   [] -> Undefined
>          in (Set appComp)
>
> surjExp :: (Ord a, Ord b, Ord c)
>         => FuncRep b c -> FuncRep a b -> Bool
> surjExp (argT1, resT1, app1) (argT2, resT2, app2) =
>     let
>         sur1 = isSurjective argT1 resT1 app1
>         sur2 = isSurjective argT2 resT2 app2
>         comp = functionalComposition app1 app2
>     in  if sur1 && sur2
>         then isSurjective argT2 resT1 comp
>         else True

 (b) Let $f ∘ g$ be a function. If $f$ and $g$ are injective then $f ∘ g$
  is injective.
     Yes?
 (c) If $f ∘ g$ is bijective then $f$ is surjective and $g$ is injective.
     Yes!
 (d) If $f$ and $g$ are bijective then $f ∘ g$ is bijective.
    - Yes!
