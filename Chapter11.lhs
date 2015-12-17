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