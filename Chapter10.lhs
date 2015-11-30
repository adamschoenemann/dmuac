10. Relations
=============

> module Chapter10 where
> import Chapter8

10.1 Binary Relations
=====================
A relationship between two objects

Definition 34
-------------
A *binary relation* $R$ with type $R :: A × B$ is a subset of $A × B$,
where $A$ is the *domain* and $B$ is the *codomain* of $R$. For $x ∈ A$
and $y ∈ B$, the notation $x R y$ means $(x,y) ∈ R$.

Example 17
----------
Let $P$ be the set of people $\\{Bill,Sue,Pat\\}$, and let $A$ be the
set of animals $\\{dog,cat\\}$. The relation $has :: P × A$ describes which person
has which kind of animal.
Suppose that Bill and Sue both have a dog, and Sue and
Pat have a cat. We would represent this information by writing the following
relational expressions:

Bill has dog, Sue has dog
Sue has cat, Pat has cat

but the statement ‘Bill has cat’ is false. Written out in full, the relation is
has = $\\{(Bill,dog), (Sue,dog), (Sue,cat), (Pat,cat)\\}$

10.2 Representing Relations with Digraphs
=========================================
There is a representation of binary relations called a *digraph*, which is convenient
for computing, and which is also well suited for diagrams.
Every element of the domain and codomain in a digraph diagram is represented
by a labelled dot (called an *element* or *node*) in the graph, and every pair $(x,y)$
in the relation is represented by an arrow going from $x$ to $y$ (which may be called
an *arrow* or *arc*).

![digraph](./images/digraph1.jpg)

Example 22
----------
Figure 10.1 shows a graph illustrating the `IsFatherOf` relation.
There is a node for each of John, Mary, Peter, and Jacqui. There are two
arrows, from John to Mary and John to Peter.

It is important to remember that a relation is more than just a set of ordered
pairs; the domain and codomain must be specified, too. In drawing the graph
of a relation, you should either draw a dot (or node) for every element of the
domain and codomain, and use the layout to indicate exactly what these sets
are, or you should specify them explicitly.

Definition 35
-------------
Let $A$ be a set, and let $R$ be a binary relation $R :: A × A$. The *digraph* $D$
of $R$ is the ordered pair $D = (A,R)$

Example 23
----------
The digraph of the relation $R :: A × A$, where $R = \\{(1,2),(2,3)\\}$ and
$A = \\{1,2,3\\}$ is $(\\{1,2,3\\}, \\{(1,2),(2,3)\\})$

Many relations have arcs that are connected to each other in a special way.
For example, a set of arcs connected in a sequence is called a (directed) path.

Definition 36
-------------
A *directed path* is a set of arcs that can be arranged in a sequence,
so that the end point of one ar in the sequence is the start point of the next.

Example 25
----------
The sets $\{(1,2),(2,3),(3,4)\}$ and $\{(1,3),(3,1)\}$ are both paths,
but the set $\{(1,2), (5,6)\}$ is not.

In Haskell, we can represent a digraph as

> type Digraph a = (Set a, Set (a,a))

10.3 Computing with Binary Relations
====================================
A relation $R :: A × B$, with domain $A$ and codomain $B$ can be represented
as a list of type `[(A,B)]`. Each elemen of the list has type `(A,B)`, and is a pair
of the form `(x,y)`, where `x :: A` is in the domain and `y :: B` is in the codomain.

Often we impose two restrictions on a relation in order to make it easuer to
compute with it: (1) there is a finite number of elements in the relation, and (2)
the types of the domain and comdomain must be in the classes `Eq` and `Show`,
so that we can compare and print elements of the relation.

Example 26
----------
The relation of colour complements can be represented as follows:

    data Colour = Red | Blue | Green | Orange | Yellow | Violet deriving (Eq, Show)
    colourComplement:: Digraph Colour
    colourComplement =
      ([Red, Blue, Green, Orange, Yellow, Violet]
      ,[(Red,Green), (Green, Red)
       ,(Blue, Orange, Orange, Red)
       ,(Yellow, Violet), (Violet, Yellow)
       ]
      )

To say "the colour complement of red is green", we would write either of the following:

$$
    \text{Red}\ colourComplement\ \text{Green} \\
    (Red, Green) ∈ colourComplement
$$

In the example above, we must include both (Red, Green) and (Green,
Red) in colourComplement. If we omitted either one of these, we would have a
different relation.

The function `domain` takes a relation and returns its domain.


> domain :: (Ord a, Ord b) => Set (a,b) -> Set a
> domain (Set xs) = fromList $ map fst xs

The *codomain* function is similar

> codomain :: (Ord a, Ord b) => Set (a,b) -> Set b
> codomain (Set xs) = fromList $ map snd xs


Exercise 1
----------
Work out the values of the following expressions, then check your answer by evaluation
the expressions with the computer.

    domain [(1,100), (2,200), (3,300)] -- [1,2,3]
    codomain [(1,100), (2,200), (3,300)] -- [100,200,300]
    crossproduct [1,2,3] [4] -- [[1,4], [2,4], [3,4]]

Exercise 2
----------
The following list comprehensions defien a list of ordered pairs.
What relations are represented by these lists? Give the domain and the codomain,
as well as the pairs themselves.

    (a)
    [(a,b) | a <- [1,2], b <- [3,4]]
    domain: [1,1,2,2] = {1,2}
    codomain: {3,4}
    relation: {(1,3),(1,4),(2,3),(2,4)}

    (b)
    [(a,b) | a <- [1,2,3], b <- [1,2,3], a == b]
    domain: {1,2,3}
    codomain: {1,2,3}
    relation: {(1,1), (2,2), (3,3)}

    (c)
    [(a,b) | a <- [1,2,3], b <- [1,2,3], a < b]
    domain: {1,2}
    codomain: {2,3}
    relation: {(1,2), (1,3), (2,3)}

10.4 Properties of Relations
============================
Relations can have interesting and useful properties. For example, if we know that person
$a$ is a sibling of person $b$, and $b$ is a sibling of $c$, then we also know that $c$ is a
sibling of $a$. In a similar way, if $x,y$ and $z$ are numbers, and we know that
$x < y$ and $y < z$, then it must also be the case that $x < z$. These two examples
show that the *sibling* relation and the $(<)$ relation have essentially the same
property (which is called 'transitivity'). In this section we define a variety of
such relational properties.


10.4.1 Reflexive Relations
==========================
In a *reflexive relation*, every element of the domain is related to itself

Definition 37
-------------
A binary relation $R$ over $A$ is *reflexive* if $xRx$ for every element $x$ of the
domain $A$.

When a reflexive relation is show in a graph diagram, there must be an arrow from
every dot in the domain back to itself

Example 27
----------
The relation $R :: A × A$, where $A = \{1,2\}$ and $R=\{(1,1),(1,2)(2,2)\}$ is reflexive.

Example 28
----------
Let $R :: A × A$ be a relation, where $A = \{1,2,3\}$ and $R = \{(1,1),(2,2)\}$. $R$ is not
reflexive, but if we added $(3,3)$ to $R$ then it would be reflexive.

Example 29
----------
A relation *SameFamily* such that $x\ SameFamiliy\ y$ for any two people $x$ and $y$ who
are in the same family, is reflexive (because you are in the same familiy as yourself).

Example 30
----------
The folowing relations on numbers are reflexive: (=), (≥), (≤).

Example 31
----------
The folowing relations on numbers are not reflexive: (≠), (<), (>).

The function `isReflexive` returns `True` if relation is reflexive.

> isReflexive :: (Ord a) => Digraph a -> Bool
> isReflexive (Set xs, Set rel) = and $ map fn xs where
>    fn x = (x,x) `elem` rel

All you have to do to show that a relation is not reflexive is to show that
there is *some* element $x$ of the domain where $(x,x)$ does not appear in the set
of ordered pairs.

10.4.2 Irreflexive Relations
============================
A relation is *irreflexive* if no element of its domain is related to itself

Definition 38
-------------
A binary relation $R$ over $A$ is *irreflexive* if, for every $x ∈ A$, it is *not*
the case that $x\ R\ x$,

Example 33
----------
The greater than (>) and less than (>) relations over numbers are irreflexive because
$x < x$ and $x > x$ are always false.

As long as the domain $A$ of a relation $R :: A × A$ is non-empty, then it is impossible
for $R$ to be both reflexive and irreflexive. To see this, consider some element $x$
of the domain (such an $x$ must exist, because the domain is not empty). If $R$ is reflexive
then $(x,x) ∈ R$, but if $R$ is irreflexive then $(x,x) ∉ R$, and both cannot be true.

Example 34
----------
The empty relation $R :: Ø × Ø$ is reflexive and also irreflexive. In both cases,
the conditions are met vacuously.

Example 35
----------
Many relations among people are irreflexive. For example, the relations *IsMarritedTo* and
*IsChildOf* are irreflexive relations, because noone can marry themselves or be their own child.

It often happens that a relation is not reflexive nad it is also not irreflexive.
For example, let $A = \{1,2,3,4,5\}$ be the domain and codomain of the relation
$R = \{(1,3),(2,4),(3,3),(3,5)}$. Then $R$ is not reflexive (for example, $(1,1)$ is not in $R$)
but it it is also not irreflexive (because $(3,3)$ *is* in $R$)

Suppose that we are visiting a city in France and want to see several buildings by bus.
We can get a bus schedule and look at it, note down the buildings and draw an arrow
between each pair of nodes that the bus will visit (Figure 10.3).

![Figure 10.3](./images/fig.10.3.jpg)

    {(Cathedral,Museum), (Museum, HouseOfFamousWriter)
    ,(HouseOfFamousWriter, OldMarketPlace), (OldMarketPlace, Cathedral)
    }

The bus is traveling in a *cycle*, a path that starts and stops at the same node.
However, the `ByBus` relation is not reflexive: the bus is not going to waste time
cycling around on place and returning to it without going anywhere else. The
`ByBus` relation is *irreflexive*.
The following Haskell function determines whether a binary relation is irreflexive.

> isIrreflexive :: (Ord a) => Digraph a -> Bool
> isIrreflexive (Set xs, Set rel) = not . or $ map fn xs where
>    fn x = (x,x) `elem` rel

Exercise 3
----------
For each of the following `Digraph` representations of a relation,
draw a graph of the relation, work out whether it is reflexive and whether it is
irreflexive, and then check your conclusion using the respective functions.

    ([1,2,3], [(1,2)])
    -- irreflexive
    1
    +
    |
    |
    |
    |
    v
    2              3

    ([1,2], [(1,2), (2,2), (1,1)])
    -- reflexive
    +--+
    v  |
    1+-+
    +
    |
    |
    |
    |
    v
    2+-+
    ^  |
    +--+

    ([1,2], [(2, 1)])
    -- neither
    1
    ^
    |
    2

    ([1,2,3], [(1,2), (1,1)])
    -- neither
    1<-+
    +--+
    |
    v
    2          3

Exercise 4
----------
Determine wheter each of the following relations on real numbers is reflexive
and whether it is irreflexive. Justify your conclusions.

- less than (<)
    - irreflexive, because no number can be less than itself
- less than or equal to (≤)
    - reflexive, because all numbers are less than or equal to themselves
- greater than (>)
    - irreflexive, see less than
- greater than or equal to (≥)
    - see 2 above
- equal (=)
    - reflexive, because all numbers are equal to themselves
- not equal (≠)
    - irreflexive, because no number is not equal to itself

10.4.3 Symmetric Relations
==========================
Some relations have the property that the order of two related objects does not
matter; that is, if $x\ R\ y$ it must also be true that $y\ R\ x$. Such a relation
is called a *symmetric* relation.

Definition 39
-------------
Let $R :: A × A$ be a binary relation. Then $R$ is *symmetric* if
$∀x,y ∈ A. x\ R\ y → y\ R\ x$

Example 36
----------
Equality on real numbers (=) is symmetric, because if $x = y$ then $y = x$. The equality
relation is commonly defiend for sets, and it is always symmetric; in fact, one of the essential
properties of an asbtract equality relation is that it must be symmetric.

Example 37
----------
The family relation *IsSiblingOf* is symmetric (Figure 10.4).
![Figure 10.4](./images/fig.10.4.jpg)

Example 38
The family relations *IsBrotherOf* and *IsSisterOf* are not symmetric: for example,
the term 'Robert *isBrotherOf* Mary' is true, but 'Mary *isBrotherOf* Robert' is false.

When you draw a graph diagram for a symmetric relation, every arc from *a* to *b* will
have a matching arc from *b* back to *a*. The notation can be simplified by putting
an arrowhead on both sides of every arc.

Exercise 5
----------
Is the family relation *IsChildOf* symmetric?

Nope, you a is b's child that does not make b a's child (in fact, it cannot happen).

Exercise 6
----------
Suppose we have a relation $R :: A × A$, where $A$ is non-empty and reflexive,
but it has *only* the arcs required in order to be reflexive. Is $R$ symmetric?

Yes.

Exercise 7
----------
In the definition of a symmetric relation, can the variables $x$ and $y$ be be instantiated
by a single node?

I should think so.

10.4.4 Antisymmetric Relations
==============================
An *antisymmetric* relation is one where for all distinct values *a* and *b*, it is
*never* the case that both $aRb$ and $bRA$

Example 42
----------
The less-than relation (<) is antisymmmetric, because it cannot be true that $x < y$ and $y > x$.

Example 43
----------
The family relation *IsChildOf* is antisymmetric; if $x$ is a child of $y$,
then $y$ must be the *parent* - not the child - of $x$.

The anitsymmetric property is defined formally as follows:

Definition 40
-------------
A binary relation $R :: A × A$ is *antisymmetric* if

$$
∀x,y ∈ A. ((xRy ∧ yRx) → (x = y))
$$

The graph of an antisymmetric relation may contain some cycles; for example
the relation $R = \{(1,2),(2,3),(3,1)\}$ has a cycle from 1 to 2 to 3 and back to 1,
and the relation $R_2 = \{(1,1)\}$ has a trivial cycle containing just 1.
However, if an antisymmetric relation does have a cycle, then the length of the
cycle cannot be 2, although it may be 1, or greater than 2. In other words,
this graph will have no cycles of length 2, but it can have cycles of any other length.

Example 44
----------
Given the set $A = \{1,2,3\}$, the relation

$$
    R :: A × A = \{(1,2),(2,1),(2,3),(3,1)\}
$$

is not anti-symmetric because both $(1,2)$ and $(2,1)$ appear in the set of ordered pairs.

If a relation $R :: A × A$ is antisymmetric, both of the following statements
must be true:
$$
\begin{align}
∀x,y ∈ A. x ≠ y → ¬(xRy ∧ yRx) \\
∀x,y ∈ A. x ≠ y → ¬xRy ∨ ¬yRx
\end{align}
$$

Both propositions say that for two distinct elements of the domain, the graph
diagram of R contains at most one arrow connecting them.

Example 47
----------
Suppose that were misanthropic and thought people did not treat each other well
in general. When told that $a\ Helps\ b$ and $b\ Helps\ a$, we might retort that
$a$ and $b$ must therefore be the same people. We could express this gloomy
world view as:

$$
∀x,y ∈ WorldPopulation. (x\ Helps\ y ∧ y\ Helps\ x) → (x = y)
$$

We can define the following Haskell functions

> isSymmetric, isAntisymmetric :: (Ord a) => Digraph a -> Bool
> isSymmetric (Set xs, Set rel) = and $ map fn rel where
>    fn (x,y) = (y,x) `elem` rel
>
> isAntisymmetric (Set xs, Set rel) = not $ or $ map fn rel where
>    fn (x,y) = x /= y && ((y,x) `elem` rel)
> -- $

Exercise 8
----------
First work out whether the relations in the following expressions
are symmetric and whether they are antisymmetric, and then check your
conclusions by evaluating the expressions with Haskell:

    isSymmetric ([1,2,3],[(1,2),(2,3)]) -- antisymmetric
    isSymmetric ([1,2],[(2,2),(1,1)])   -- symmetric AND antisymmetric?
    isAntisymmetric ([1,2,3],[(2,1),(1,2)]) -- Nope, symmetric
    isAntisymmetric ([1,2,3],[(1,2),(2,3),(3,1)]) -- antisymmetric

Exercise 9
----------
Which of the following relations are symmetric?  Antisymmetric

    (a) The empty binary relation over a set with four nodes;
            antisymmetric AND symmetric
    (b) The = relation;
            Antisymmetric and symmetric
    (c) The ≤ relation;
            Antisymmetric
    (d) The < relation
            Antisymmetric

10.4.5 Transitive Relations
---------------------------
If x, y, and z are three people, and you know that x is a sister of y and y is a
sister of z, then x must also be a sister of z. Similarly, if you know that x < y
and also that y < z, it must also be the case that x < z. Relations that have
this property are called transitive relations.

Definition 41
-------------
A binary relation $R :: A × B$ is *transitive* if
$$
    ∀x,y,z ∈ A. x R y ∧ y R z → x R z
$$

Example 48
----------
The relation $R = \\{(1,2), (2,3), (1,3)\\}$ is transitive because it
contains $(1,3)$, which is required by the presence of $(1,2)$ and $(2,3)$.

Example 49
----------
The relation $R = \\{(1,2),(2,3)\\}$is not transitive because there are pairs
$(1,2)$ and $(2,3)$, but there is no pair $(1,3)$.

The (=) relation is transitive, as is the $IsAncestorOf$ relation.

Example 51.
-----------
Suppose we are flying from one city to another. The relation
$FlightTo$ describes the point-to-point flights that are available: for example,
$(London,Paris) ∈ FlightTo$ because there is a direct flight from London to
Paris. This relation is not transitive, because there are flights from many
small cities to London, but those small cities don’t have direct flights to Paris.
However, the $ReachableByAir$ relation is transitive. In effect, the airlines define
the $FlightTo$ relation, and the travel agents extend this to the more general
$ReachableByAir$ relation, which may involve several connecting flights.

As the previous example suggests, a binary relation $R$ can be extended to make
a new binary relation $R^T$, such that $R ⊆ R^T$ and $R^T$ is transitive.
This often entails adding several new ordered pairs. For example, suppose we
have a relation $CityMap$ that defines direct street connections, so that
$(x,y) ∈ CityMap$ if there is a street connecting $x$ directly with $y$
(Figure 10.6). The relation could be defined (for a small city) as

$$
\\{(Cathedral, Museum),(Museum, Market), (Market, Airport)\\}
$$

![Figure 10.6 and 10.7](./images/fig.10.6.jpg)

The $CityMap$ relation is not transitive, because there is a street path from
*Cathedral* to *Market*, but no street connects them directly. Just adding the
pair $(Cathedral, Market)$ is not enough to make the relation transitive; a
total of three orderede pairs must be added. These are shown as dashed arrows
in Figure 10.7. The new pairs that we adedd to the relation are

$$
\\{(Cathedral,Market),(Catehdral,Airport),(Museum,Airport)\\}
$$

A transitive relation provides a short cut for every path of length 2 or more.
To make a relation transitive, we must continue adding new pairs until the new
relation is transitive. this process is called taking the *transitive closure* of
the relation.

We can write a Haskell function that determines whether a relation is transitive.

> isTransitive :: (Ord a) => Digraph a -> Bool
> isTransitive (Set xs, Set rel) = and
>    [if (x,y) `elem` rel && (y,z) `elem` rel
>         then (x,z) `elem` rel
>         else True
>         | x <- xs, y <- xs, z <- xs]

Exercise 10
-----------
Determine by hand whether the following relations are transitive,
and then check your conclusion using the computer.

    isTransitive ([1,2], [(1,2),(2,1),(2,2)])
    -- No! But if (1,1) was in there, it would be
    isTransitive ([1,2,3], [(1,2)])
    -- Yes

Exercise 11
-----------
Determine which of the following relations on real numbers are transitive:
$(=), (≠), (<), (≤), (>), (≥)$.
$(=), (<), (>), (≤), (≥)$

Exercise 12
-----------
Which of the following relations are transitive?

    (a) The empty relation; Yes
    (b) The IsSiblingOf relation; Yes
    (c) An irreflexive relation; Yes
    (d) The IsAncestorOf relation; Yes

10.5 Relational Composition
===========================
We can think of a relation $R :: A × B$ as taking us from a point $x ∈ A$ to a
point $y ∈ B$, assuming that $(x,y) ∈ R$. Now suppose there is another relation
$S :: B × C$, and suppose that $(y,z) ∈ S$, where $z ∈ C$. Using first $R$ and then
$S$, we get from $x$ to $z$, via the intermediate point $y$.
We could define a new relation that describes the effect of doing first $R$ and
then $S$. This is called the composition of $R$ and $S$, and the notation for it is
$R;S$.

The use of a semicolon (;) as the operator for relational composition is com-
mon, but not completely standard.

Definition 42
-------------
Let $R_1 :: A × B$ be a relation from set $A$ to set $B$, and
$R_2 :: B × C$ be a relation from set $B$ to set $C$. Their *relational composition*
is defined as follows:

$ R_1;R_2 :: A × C$  
$ R_1;R_2 = \\{(a,c)\ |\ a ∈ A ∧ c ∈ C ∧ (∃b ∈ B. (a,b) ∈ R_1 ∧ (b,c) ∈ R_2)\\}$


The definition just says formally that $R_1;R_2$ consists of all the pairs
$(a,c)$, such that there is an intermediate connecting point $b$. This means
that $(a,b) ∈ R_1$ and $(b,c) ∈ R_2$

Example 53
----------
When we compose two relations, any two links between $a$ and $b$
in the first relation and $b$ and $c$ in the second produce a new link between a and
c. Suppose we have a relation `Route1` linking Paris and London and `Route2`
linking London and Birmingham. The composition of `Route1` and `Route2`
yields a new route relation which shows that it is possible to travel taking
first `Route1` and then `Route2`, starting from Paris and ending at Birmingham
(Figure 10.8). In our diagram, the arcs are of three different patterns because
they belong to three separate relations.

![Figure 10.8](./images/fig.10.8.jpg)

> composeRelation :: (Ord a, Ord b) => Set (a,b) -> Set (b,c) -> Set (a,c)
> composeRelation (Set xs) (Set ys) =
>    [(a,c) | a <- xs, b <- ys, ]