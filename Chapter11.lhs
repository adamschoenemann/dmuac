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

> ident, doubly, triple, quadruple :: Int -> Int
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
