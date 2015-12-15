10. Relations
=============

> module Chapter10 where
> import Chapter8
> import Debug.Trace
> import Test.QuickCheck

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

> type Relation a = Set (a,a)
> type Digraph a = (Set a, Relation a)

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

Sometimes it is useful to compose a relation with itself. A common situa-
tion is to start with a relation like *Flight*, which represents trips consisting of
just one flight, starting from one city and ending in another one. The compo-
sition *Flight;Flight* describes all the trips that can be made using exactly two
connecting flights.

Suppose that we need to know whether *a*, who died of a hereditary disease,
was a blood relative of *b*. This could mean calculating all of the descendants
of *a*, then checking to see whether *b* is among them. It might be better
to save some of the work done (space permitting) in calculating the descendants
of *a*, so that when we need to know whether *a* was a blood relative of *c*,
some of the work need not be repeated.

As an example, when determining whether `Joseph` and `Jane` are blood
relations, we discover that $Joseph\ IsBloodRelationOf\ Sarah$,
$Sarah\ IsBloodRelationOf\ Jane$, and $Jane\ IsBloodRelationOf\ Joel$.
During this process, we add the newly discovered fact to the database:
$Joseph\ IsBloodRelationOf\ Jane$. Now, when we have a query asking whether
Joseph is a blood relation of Joel, the new link represents the two links
between Joseph and Jane. This reduces the number of links to be traversed.

In creating the composition of two relations, we look for arcs in the first
relation that have terminal nodes matching the starting nodes of arcs in
the second relation. This operation required that we systematically check
all arcs in $R_1$ against all arcs in $R_2$.

Example 54
----------
Let's calculate a relational composition by hand. Let
$$
R_1 = \\{(1,2),(2,3),(3,4)\\}
$$

The composition $R_1;R_1$ is worked out by deducing all the ordered pairs
that correspond to an application of $R_1$ followed by an application of
$R_1$.
First we find all the ordered pairs of the form $(1,x)$. $R_1$ has only
one ordered pair starting with 1; this is $(1,2)$. This means the first
application of $R_1$ goes from 1 to 2, and the $(2,3)$ pair means
that the second application goes to 3. Therefore the composition
$R_1;R_1$ should contain a pair $(1,3)$. Next, consider what happens
starting with 2: The $(2,3)$ pair goes from 2 to 3, and looking at
all the available pairs $\\{(1,2),(2,3),(3,4)\\}$ shows that 3 then goes
to 4. Finally, we see what happens when we start with 3: the first application
of $R_1$ goes from 3 to 4, but there is no pair of the form $(4,x)$. This means
that there cannot be any pair of the form $(3,x)$ in the composition $R_1;R_1$.
The result of all these comparisons is $R_1;R_1 = \\{(1,3),(2,4)\\}$
(Figure 10.9). In our diagram, the new relation is indicated by arrows
with dashes.

![Figure 10.9](./images/fig.10.9.jpg)

This is straightforward, yet tedious. We can write a function
`relationalComposition` that implements this calculation: it defines
a new relation giving two existing ones, by working out all the ordered
pairs in their relational composition.

> relationalComposition :: (Ord a, Ord b, Ord c)
>                       => Set (a,b) -> Set (b,c) -> Set (a,c)
> relationalComposition (Set xs) (Set ys) = fromList $ concatMap fn xs where
>    fn (x1,x2) = map (\(y1,y2) -> (x1,y2)) $ filter ((x2 ==) . fst) ys

Exercise 13
-----------
First work out by hand the ordered pairs in the following relational
compositions, and then check your results using the computer:

    relationalComposition [(1,2),(2,3)] [(3,4)] -- [(2,4)]
    relationalComposition [(1,2)] [(1,3)]       -- []

Exercise 14
-----------
(a) Find the composition of the following relations:
$$
\\{(Alice, Bernard), (Carol, Daniel)\\} \text{ and } \\{(Bernard, Carol)\\}
$$
Answer: $\\{(Alice, Carol)\\}$

(b) $\\{(a,b),(aa,bb)\\}$ and $\\{(b,c), (cc,bb)\\}$
Answer: $\\{(a,c)\\}$

(c) $R;R$ where relation $R$ is defined as
$$
R = \\{(1,2),(2,3),(3,4),(4,1)\\}
$$
Answer: $\\{(1,3),(2,4),(3,1),(4,2)\\}$

(e) The empty set and any other relation.
Answer: $\\{\\}$

10.6 Powers of Relations
========================
For a relation $R$, the *n*th power is the composition
$R;R;...;R$, where $R$ appears $n$ times, and its notation is $R^n$.
Notice in particular that $R^2 = R;R$ and $R^1 = R$. It is also convenient
to define $R^0$ to be identity relation.

When a relation $R$ is composed with itself $n$ times, producing $R^n$,
a path of length $n$ in $R$ from $a$ to $b$ causes there to be a single
link $(a,b)$ in the power relation $R^n$

Suppose that we have to calculate the relationships between several people
in our database, and that the original facts are these (Figure 10.10):

$$
\begin{align}
Andrew  \quad & IsParentOf\quad Beth \\\
Beth    \quad & IsParentOf\quad Ian \\\
Beth    \quad & IsParentOf\quad Joanna \\\
Ian     \quad & IsParentOf\quad William \\\
William \quad & IsParentOf\quad Tina
\end{align}
$$

![Figure 10.10](./images/fig.10.10.jpg)

The 0th power is just the identity relation, and the first power
$IsParentOf^1$ is simply the $IsParentOf$ relation. The higher
powers will tell us the grandparents, great grandparents, and
great great grandparents. You should expect to see that each of the new
relations $IsParentOf^2, IsParentOf^3$, and $IsParentOf^4$ connect up
the starting and ending points of a path 2, 3, and 4 arcs long within
the original $IsParentOf$ relation. In the following diagrams, the arrows
with dashes indicate relations defiend as a power, while all other arrows
belong to the $IsParentOf$ relation. If we compose the $IsParentOf$ relation
with itself (i.e., $IsParentOf^2$), we have the grandparent relation
(Figure 10.11)

![Figure 10.11](./images/fig.10.11.jpg)

$$
\begin{align}
Andrew \quad & IsGrandParentOf\quad Ian \\\
Andrew \quad & IsGrandParentOf\quad Joanna \\\
Beth   \quad & IsGrandParentOf\quad William \\\
Ian    \quad & IsGrandParentOf\quad Tina
\end{align}
$$

We can keep composing with the original relation.

![Figure 10.12-13](./images/fig.10.12-13.jpg)

We will now give the formal definition of relational powers.
The definition is recursive, because we have to define the meaning
of $R^n$ for all $n$. The base case of the recursion will be $R^0$,
which is just the identity relation (it's like taking *zero* flights
froma city, which leaves you where you started). The recursive case
defiens $R^{n+1}$ using the value of $R^n$.

Definition 43
-------------
Let $A$ be a set and let $R :: A × A$ be a relation defined over $A$.
The *n*th power of $R$, denoted $R^n$, is defined as follows:

$$
\begin{align}
R^0      & = & \\{(a,a) | a ∈ A\\} \\\
R^{n+1}  & = R^n;R
\end{align}
$$

Example 55
----------
Using the formal definition, we calculate $R^4$, where
$$
R = \\{(2,3),(3,2),(3,3)\\}
$$
$$
R^4 = R^3;R = R^2;R;R = R^1;R;R;R = R;R;R;R
$$

First we calculate $R^2 = R;R = \\{(2,2),(2,3),(3,2),(3,3)\\}$
Now we calculate $R^3 = R^2;R$
$$
\\{(2,2),(2,3),(3,2),(3,3)\\} ; \\{(2,3),(3,2),(3,3)\\} = \\{(2,3),(2,2),(3,3),(3,2)\\}
$$

At this point, we can notice that $R^3 = R^2$. In other words, composing
$R^2$ with $R$ just gives back $R^2$, and we can do this any number of times.
This means that any further powers will be the same as $R^2$ - so we have found
$R^4$ without needing to do lots of calculations with ordered pairs.

Releational composition is associative. This causes the powers on
relational composition to follow algebraic laws that are similar to the corresponding
laws for powers on numer. For example, $R^{(a+b)} = R^a;R^b$.

A relation whose domain is $\\{x_0, ..., x_{n-1}\\}$ is *cyclic* if it contains
a cycle of ordered pairs of the form
$(x_0,x_1),(x_1,x_2),(x_2,x_3),(x_3,x_4),...,(x_{n-1},x_0)$.
That is, the relation is cyclic if there is a cycle comprising all the elements
of its domain.
Consider what happens to a cyclic relation as we calculate its powers. The
relation is defined as
$$
R = \\{(a,b),(b,c),(c,a)\\}
$$

The first power $R^1$ is just $R$. The second power $R^2$ is calculated by working
out the ordered pairs in $R;R$; the result is
$$
\begin{align}
R^2 & = \\{(a,b),(b,c),(c,a)\\};\\{(a,b),(b,c),(c,a)\\} \\\
    & = \\{(a,c),(b,a),(c,b)\\}
\end{align}
$$

![Figure 10.14](./images/fig.10.14.jpg)

This contains only paths between the start and end points of all the paths of
length two in the original relation. Now the third power is

$$
\begin{align}
R_3 & = \\{(a,c),(b,a),(c,b)\\};\\{(a,b),(b,c),(c,a)\\} \\\
    & = \\{(a,a),(b,b),(c,c)\\}.
\end{align}
$$

This result contains only arcs connecting the origin and destination points of
paths of length three in the original relation. What will happen next?

$$
\begin{align}
R_4 & = \\{(a,a),(b,b),(c,c)\\};\\{(a,b),(b,c),(c,a)\\} \\\
    & = \\{(a,b),(b,c),(c,a)\\}
\end{align}
$$

Just what we might have expected: each of these arcs represents a path of
length 4, so we have started round the cycle again. What can we now say
about the powers of this relation? They repeat in a cycle.
$R^4 = R^1, R^5^ = R^2$ and in general $R^{n+3} = R^n$ (Figure 10.14).

We can define a function `equalityRelation`, which takes a set and
returns the equality relation on that set

> equalityRelation :: (Ord a) => Set a -> Set (a,a)
> equalityRelation (Set xs) = fromList $ map (\x -> (x,x)) xs

And a function that calculate sthe power of a relation.

> relationalPower :: (Ord a) => Digraph a -> Int -> Set (a,a)
> relationalPower (s, _) 0 = equalityRelation s
> relationalPower (Set _, rel) 1 = rel
> relationalPower (Set xs, rel) n = relPow n rel where
>    relPow n rel
>        | n <= 1    = rel
>        | otherwise = relationalComposition (relPow (n-1) rel) rel

Exercise 15
-----------
Work out the values of these expressions, and then evaluate them using
the computer:

    equalityRelation [1,2,3] -- [(1,1),(2,2),(3,3)]
    equalityRelation ([]::[Int]) -- []

Exercise 16
-----------
Calculate the following relational powers by hand, and then evaluate them
using the computer.

    relationalPower ([1,2,3,4], [(1,2),(2,3),(3,4)]) 1 -- [(1,2),(2,3),(3,4)]
    relationalPower ([1,2,3,4], [(1,2),(2,3),(3,4)]) 2 -- [(1,3),(2,4)]
    relationalPower ([1,2,3,4], [(1,2),(2,3),(3,4)]) 3 -- [(1,4)]
    relationalPower ([1,2,3,4], [(1,2),(2,3),(3,4)]) 4 -- []

Exercise 17
-----------
Why do we not need to check the ordered pairs in $R$ while calculating $R^0;R$.

$R^0$ is the identity, so we just need to "copy" each node into a relfexive relation.

Exercise 18
-----------
Why can we stop calculating powers after finding that two successive powers
are the same relation?

Because then we have a loop!

Exercise 19
-----------
What is $R^4$ where $R$ is $\\{(2,2),(4,4)\\}$

It is also $\\{(2,2),(4,4)\\}$, because it is the identity relation.

Exercise 20
-----------
What is the relationship between adding new ordered pairs to make a
relation transitive and taking the power of a relation?

Taking the power of a relation will take a relation "one step further" to making
it transitive.

Exercise 21
-----------
Suppose a set $A$ contains $n$ elements. How many possible relations
with type $R :: A × A$ are there?

    0 = 0
    1 = 1
    2 = 2^(2^2)
    3 = 3^(3^2)

So $2^(n^2)$. In general, for a set of $n$ elements, there are $n^2$ possible
ordered pairs, and for every single pair we can choose to include it or
not include it in a relation, which gives is $2^(n^2)$ possible relations.

Exercise 22
-----------
Given the relation $\\{(a,b),(b,c),(c,d),(d,e)\\}$, how many times would we have
to compose this relation with itself before the empty relation is produced?

4 times, to get R^5

Exercise 23
-----------
Given the set $A = \\{1,2,3\\}$ and the relation $R :: A × A$ where
$R = \\{(3,1),(1,2),(2,3)\\}$, what is the value of $R^2$? $R^3$?

$$
\begin{align}
R^2 = \\{(3,2),(1,3),(2,1)\\} \\\
R^3 = \\{(3,3),(1,1),(2,2)\\}
\end{align}
$$

10.7 Closure Properties of Relations
====================================
We want to keep our relations as small as possible, for easy maintenance, yet we also
want them to have nice properties such as transitivity, reflexivity, symmetricality etc.

In order to accomplish this we define *two* relations:

1. A basic relation containing just the essential information
2. A larger relation is dervied from the basic one by adding the ordered pairs
   required to give it the special properties that are needed.

When circumstances change, only the basic relation is edited by hand. The derived
one is recalculated using a computer!

Example 56
----------
An airline keeps a set of all the flights they offer. This is
represented by a relation $Flight$, where $(a,b) ∈ Flight$ if the airline has a di-
rect flight from $a$ to $b$. However, when a customer asks a question like ‘Do
you fly from Glasgow to Seattle?’, the airline needs a transitive relation: if
$(Glasgow,New York) ∈ Flight$ and also $(New York,Seattle) ∈ Flight$, the an-
swer should be yes. Thus the airline’s flight-planning staff define the basic
relation $Flight$, but the sales staff work with a derived relation that is similar
to $Flight$, but which is transitive.

A relation derived in this way is called the *closure* of the basic relation:

Definition 44
-------------
The *closure* of a relation $R$ with respect to a given property is the smallest
possible relation that contains $R$ and has that property.

Closure is suitable for adding properties that require the presence of certain
ordered pairs. For example, you can take the symmetric closure of a relation by
checking every existing pair (x,y), and adding the pair (y,x) if it isn’t already
present. However, closure is not suitable for properties that require the absence
of certain ordered pairs. For example, the relation R = {(1,1),(1,2),(2,3)}
does not have an irreflexive closure, as that would need to contain (1,1) (be-
cause the closure must contain the basic relation), yet it must not contain (1,1)
(in order to be irreflexive).

You can give a relation a property such as reflexivity, or transitivity, by cre-
ating its reflexive or transitive closure. Notice, however, that the new relation
may no longer have all of the properties of the original relation. For example,
suppose that a relation is irreflexive, as in {(1,2),(2,1)}. The smallest possible
transitive relation containing this one also has the arcs (1,1) and (2,2), which
means that it is no longer irreflexive.

10.7.1 Reflexive Closure
========================
The reflexive closure contains all of the arcs in the relation
together with an arc from each node to itself.

Definition 45
-------------
Let $A$ be a set, and let $R :: A × A$ be a binary relation over $A$. The
*reflexive closure* of $R$ is the reation $R'$ such that $R'$ is reflexive,
$R'$ is a superset of $R$, and for any reflexive relation $R''$, if $R''$ is
a superset of $R$, then $R''$ is a superset of $R'$. The notation $r(R)$
denotes the reflexive closure of $R$.

Example 57
----------
The reflexive closure of the relation $\\{(1,2),(2,3)\\}$ is
$\\{(1,2),(2,3),(2,2),(3,3),(1,1)\\}

The following theorem provides a straightforward method for calculating
the reflexive closure of a relation:

Theorem 73
----------
Let $A$ be a set, let $E$ be the equality relation on $A$, and let $R$
be a binary relation defined over $A$. Then $r(R) = R ∪ E$

Or, in Haskell

> reflexiveClosure :: (Ord a) => Digraph a -> Digraph a
> reflexiveClosure (s, rs) = (s, rs +++ equalityRelation s)

Exercise 24
-----------
Work out the following reflexive closures by hand, and then
check your results using the computer:

    reflexiveClosure ([1,2,3], [(1,2),(2,3)]) = ([1,2,3], [(1,1),(2,2),(3,3),(1,2),(2,3)])
    reflexiveClosure ([1,2], [(1,2),(2,1)]) = ([1,2], [(1,1),(2,2),(1,2),(2,1)])

Exercise 25
-----------
What is the reflexive closure of the relation $R;R$ where $R$ is defined as
$\\{(1,2),(2,1)\\}$

$$
r(R;R) = r(\\{(1,1),(2,2)}\\) = \\{(1,1),(2,2)\\} = R;R
$$

10.7.2 Symmetric Closure
========================
The formal definition of a symmetric closure is similar to the definition of
reflexive closure.

Definition 46
-------------
Let $A$ be a set, and let $R :: A × A$ be a binary relation over $A$. The
*symmetric closure* of $R$ is the relation $R'$ such that $R'$ is symmetric,
$R'$ is a superset of $R$, and for any symmetric relation $R''$, if $R''$
is a superset of $R$, then $R''$ is a superset of $R'$. The notation $s(R)$
denotes the symmetric closure of $R$.

Sometimes it is useful to turn around a relation and use its ordered pairs
in reverse. This is called the *converse* of the relation

Definition 47
-------------
Let $A$ and $B$ be sets, and let $R :: A × B$ be a binary relation from $A$
to $B$. The *converse* of $R$, written $R^c$, is the binary relation from $B$
to $A$ defined as follows.
$$
R^c = \\{(b,a) | (a,b) ∈ R \\}
$$

The symmetric closure of a relation is the union of he relation and its converse.
The following theorem states this formally:

Theorem 74
----------
Let $A$ be a set and let $R :: A × A$ be a binary relation over $A$.
Then the symmetric closure $s(R) = R ∪ R^c$.

In Haskell::

> symmetricClosure :: Ord a => Digraph a -> Digraph a
> symmetricClosure (s, r) = (s, r +++ converse r)

> converse :: (Ord a, Ord b) => Set (a,b) -> Set (b,a)
> converse (Set xs) = fromList $ map (\(a,b) -> (b,a)) xs

Exercise 26
-----------
Work out the following symmetric closures by hand, and then calculate
them using the computer:

    symmetricClosure ([1,2], [(1,1),(1,2)]) -- ([1,2], [(1,1),(1,2),(2,1)])
    symmetricClosure ([1,2,3], [(1,2),(2,3)]) -- ([1,2], [(2,1),(3,2),(1,2),(2,3)])

10.7.3 Transitive Closure
=========================
You can define a relation that describes one step; the transitive closure of the
relation then describes the effect of taking $n$ steps, for any $n$.

Consider now how to calculate the transitive closure of a relation. As an
example, suppose that you need to define the $IsDescendantOf$ relation in a
database of people. The database contains records for Zoe, Bruce, Gina,
Annabel, Dirk, Kay, and Don. We start with the $IsChildOf$ relation, defined
as follows:
$$
    \\{(Zoe,Bruce),(Gina,Zoe), \\\
    (Bruce,Annabel),(Dirk,Kay), \\\
    (Kay,Don),(Annabel,Kay)\\}
$$

Observe that the relation $IsDescendantOf$ should have all these arcs, and
many more. For example, $Gina$ is a descendant of $Bruce$.

![Figure 10.17](./images/fig.10.17.jpg)

The transitive closure should contain "shortcuts" between any paths of length 2 or more
in the original relation. As such, we need to take all the necessary powers of the relation
until no more are needed. If there are $n$ nodes in the digraph, the longes possible path
(ignoring cycles) must be no more than $n - 1$ elements long.

Definition 48
-------------
Let $A$ be a set of $n$ elements, and let $R :: A × A$ be a binary relation over $A$.
The *transitive closure* of $R$ is defined as follows

$$
t(R) = ⋃_{i=1}^n R^i.
$$

For example, if a set $A$ has four elements, then the transitive closure
of a relation $R :: A × A$ would be
$$
R^1 ∪ R^2 ∪ R^3 ∪ R^4
$$

The $IsDescendantOf$ relation is the union of as many powers of the $IsChildOf$
relation as there are people in the $IsChildOf$ relation's domain.

In Haskell:

> transitiveClosure :: Ord a => Digraph a -> Digraph a
> transitiveClosure rel@(Set nodes, _) = (Set nodes, close rel (length nodes)) where
>    close rel n
>       | n <= 1 = snd rel
>       | otherwise = (relationalPower rel n) +++ close rel (n-1)

Exercise 29
-----------
Work out the following transitive closures by hand, and then evaluate them using
the computer:

    transitiveClosure ([1,2,3], [(1,2),(2,3)]) -- ([1,2,3], [(1,2),(2,3),(1,3)])
    transitiveClosure ([1,2,3], [(1,2),(2,1)]) -- ([1,2,3], [(1,2),(2,1),(1,1),(2,2)])

Exercise 30
-----------
Given a digraph $(\\{1,2,3,4\\}, \\{(1,2)\\})$, what can we do to speed up the transitive
closure algorithm, which requires that we take as many powers of the relation as there
are nodes in the digraph?

We could stop if the relations only contain one pair? Or stop when the relational power
yields an empty set.

Exercise 31
-----------
Find the transitive symmetric closure and the symmetric transitive closure of the following
relations:

- a. $\\{(a,b),(a,c)\\}$
    - ts: $t(s(R)) = t(\\{(a,b),(a,c),(b,a),(c,a)\\}) = \\{(a,a),(b,b),(b,c),(c,b),(c,c),(a,b),(a,c),(b,a),(c,a)\\}$
    - st: $s(t(R)) = s(\\{(a,b),(a,c)\\}) = \\{(a,b),(a,c),(b,a),(c,a)\\}$
- b. $\\{(a,b)\\}$
    - ts: $t(s(R)) = t(\\{(a,b),(b,a)\\}) = \\{(a,b),(b,a),(a,a)\\}$
    - st: $s(t(R)) = s(\\{(a,b)\\}) = \\{(a,b),(b,a)\\}$
- c. $\\{(1,1),(1,2),(1,3),(2,3)\\}$
    - ts:
        $$
        t(s(R)) = t(\\{(2,1),(3,1),(3,2),(1,1),(1,2),(1,3),(2,3)\\}) = \\\
            \\{(2,2),(3,3),(2,1),(3,1),(3,2),(1,1),(1,2),(1,3),(2,3)\\}
        $$
    - st: $s(t(R)) = s(\\{(1,1),(1,2),(1,3),(2,3)\\}) = \\{(1,1),(1,2),(2,1),(1,3),(3,1),(2,3),(3,2)\\}$
- d. $\\{(1,2),(2,1),(1,3)\\}$
    - ts: $t(s(R)) = t(\\{(1,2),(2,1),(1,3),(3,1)\\}) = \\{(1,1),(2,3),(3,2),(1,2),(2,1),(1,3),(3,1),(3,3),(2,2)\\}$
    - st: $s(t(R)) = s(\\{(1,1),(2,2),(1,2),(2,1),(1,3),(2,3)\\}) = \\{(3,1),(3,2),(1,1),(2,2),(1,2),(2,1),(1,3),(2,3)\\}$

10.8 Order Relations
====================
An order relation specifies an ordering that can be used to create a sequence
from the elements of its domain. Order relations are extremely important
in computing, because data values often need to be placed in a well-defined
sequence for processing.
Examples: (<), (≤), (>) etc.
Always transitive. If $a$ is before $b$ and $b$ is before $c$, then $a$ is before $c$.

10.8.1 Partial Order
====================
At least of elements on the domain in sequence, but not necessarily all.

Example 63
----------
Suppose that a database of people contains records that specify
the breed of dog owned—for those people who have a dog. The records of
dog owners could be ordered alphabetically using the breed name, producing a
sequence of dog owners. However, this ordering would not include the people
who don’t have dogs, so it is only a partial order. Of course, it might happen
that everyone (or no one) owns a dog, in which case we would still technically
have a partial order. That is, it is possible that the entire partial order is sorted
using some ordering; the point is just that this is not required.

Example 64
----------
Consider the problem of ordering all the records in the database
by people’s names. Some names are common, so there might be more than one
record per name. Therefore this is a partial order.

Example 65
----------
We are programming with a data structure that contains ordered
pairs (x,y), and we define an ordering such that the pair $(x_1, y_1)$ precedes the
pair $(x_2, y_2)$ if $x_1 ≤ x_2 ∧ y_1 ≤ y_2$. This is a partial order, because it doesn’t
specify the ordering between $(1,4)$ and $(2,3)$.
The formal definition of partial orders is stated using the properties of
relations that we have already defined:

Definition 49
-------------
A binary relation $R$ over a set $A$ is a partial order if it is
reflexive, antisymmetric, and transitive.

Suppose that we used age to order our database records. Our
$IsYoungerOrSameAgeAs$ relation is reflexive, antisymmetric, and transitive, so
it is a partial order. Figure 10.19 gives its digraph.

![Figure 10.19](./images/fig.10.19.jpg)

Poset Diagrams
--------------
Often we don't want to draw *all* the arcs of a relation, because there are so
many, e.g. in a partial order.

A *poset* (partially ordered set) diagram is a relation diagram for partial orders,
where the distracting transitive and reflexive arcs are omitted. It is
important to state explicitly that the diagarm shows a partial order (or a poset);
without knowing this fact, a reader would not know that the relation also contains
the reflexive and transitive arcs.

![!Figure 10.20](./images/fig.10.20.jpg)

Weakest and Greatest Elements of a Poset
----------------------------------------
The following definitions give the standard terminology used to describe how
two elements of a partial order are related to each other:

Definition 50
-------------
If there is a directed path from $x$ to $y$ in a partial order (i.e., if
$x$ precedes $y$ in the partial order), then $x$ *is weaker than* $y$. The math
notation for this $x ⊑ y$. If $x ⊑ y$ is false, then we write $x ⋢ y$.

Definition 51
-------------
Two nodes $x$ and $y$ in a partial order are incomparable if
$x ⋢ y ∧ y ⋢ x$. That is, $x$ and $y$ are incomparable if there is no directed path
from $x$ to $y$, and there is also no directed path from $y$ to $x$.

In a finite set of numbers, there must be a unique smallest element and a
unique greatest element. However, a poset might have several least elements.
For example, if x and y are incomparable, but they are both weaker than all
the other elements of the poset, then both are least elements. Similarly, there
may be several greatest elements. The following definitions define the sets of
least and greatest elements formally:

Definition 52
------------
The set of *least elements* of a poset $P$ is
$$
\\{x ∈ P\ |\ ∀y ∈ P. (x ⊑ y ∨ (x ⋢ y ∧ y ⋢ x))\\}
$$
That is, the least elements of P are the elements that are either incomparable
to or weaker than any other element.

Definition 53
-------------
The set of *greatest elements* of a poset $P$ is
$$
\\{x ∈ P\ |\ ∀y ∈ P. (y ⊑ x ∨ (x ⋢ y ∧ y ⋢ x))\\}
$$

That is, the greatest elements of $P$ are the elements that are either incomparable
to or greater than any other element.

Example 69
----------
Figure 10.21 shows a poset where the set of weakest elements
is {c}, and the set of greatest elements is {a,f,e}.

![Figure 10.21](./images/fig.10.21.jpg)

The following Haskell function takes a digraph and returns `True`
if the digraph represents a partial order and `False` otherwise.

> isPartialOrder :: (Ord a) => Digraph a -> Bool
> isPartialOrder set = and $ map ($ set) [isTransitive, isReflexive, isAntisymmetric]

The following two functions each take a relation and an element. The first
one returns `True` if the second argument is a least element in the relation, and
`False` otherwise. The second function returns `True` if the element is a greatest
element in the relation and `False` otherwise.

> isWeakest, isGreatest :: (Ord a) => Relation a -> a -> Bool
> isWeakest = extremesFinder snd
> isGreatest = extremesFinder fst
>
> extremesFinder :: (Ord a) => ((a,a) -> a) -> Relation a -> a -> Bool
> extremesFinder ex (Set rel) x = incomparable || findExtreme where
>     incomparable  = (length $ filter (\(y,z) -> y == x || z == x) noReflexive) == 0
>     findExtreme   = (length $ filter ((== x) . ex) noReflexive) == 0
>     noReflexive   = filter (/= (x,x)) rel


These functions each take a digraph; the first function returns the set of
weakest elements while the second function returns the set of greatest elements:

> weakestSet, greatestSet :: (Ord a) => Digraph a -> Set a
> weakestSet (Set xs, rel) = fromList $ filter (isWeakest rel) xs
> greatestSet (Set xs, rel) = fromList $ filter (isGreatest rel) xs

Exercise 32
-----------
Work out by hand whether the following digraphs are partial orders, and then check
your results using the computer.

    isPartialOrder ([1,2,3], [(1,2),(2,3)]) -- nope, it is not reflexive or transitive
    isPartialOrder ([1,2,3], [(1,2),(2,3),(1,3),(1,1),(2,2),(3,3)]) -- yep!

Exercise 33
-----------
Calculate the following by hand, and then evaluate with the computer.

    isWeakest [(1,2),(2,3),(1,3),(1,1),(2,2),(3,3)] 2 -- nope, because (1,2)
    isWeakest [(1,2),(1,3),(1,1),(2,2),(3,3)] 3 -- nope, because 1 ⊑ 3

    isGreatest [(1,2),(2,3),(1,3),(1,1),(2,2),(3,3)] 3 -- Yeap
    isGreatest [(1,2),(1,3),(1,1),(2,2),(3,3)] 1 -- Nope, there is a tuple (1,2) (or (1,3))

Exercise 34
-----------
Calculate the following by hand and evaluate

    weakestSet ([1,2,3,4], [(1,4),(1,3),(1,2),(1,1),(2,3),(2,4),(2,2),(3,4),(3,3),(4,4)]) -- [1]
    weakestSet ([1,2,3,4], [(1,4),(1,2),(1,1),(2,4),(2,2),(3,4),(3,3),(4,4)]) -- [1,3]
    greatestSet ([1,2,3,4], [(1,2),(3,4),(1,1),(2,2),(3,3),(4,4)]) -- [2,4]
    greatestSet ([1,2,3,4], [(2,3),(3,4),(2,4),(1,1),(2,2),(3,3),(4,4)]) -- [1,4]

Exercise 35
-----------
What are the greatest and weakest elements in a poset diagram that contains the following arcs:

- (a) $\\{(a,b),(a,c)\\}$
    - weakest = {a}. greatest = {b,c}
- (b) $\\{(a,b),(c,d)\\}$
    - weakest = {a,c}. greatest = {b,d}
- (c) $\\{(a,b),(a,d),(b,c)\\}$
    - weakest = {a}. greatest = {d,c}

10.8.2 Quasi Order
==================
A quasi order is similar to a partial order, except that it is irreflexive:

Definition 54
-------------
A binary relation $R$ over a set $A$ is a quasi order if it is
irreflexive and transitive.

Example 70
----------
The relation (<) on numbers is a quasi order, but (≤) is not.

Notice that the definition of a quasi order doesn’t mention symmetry. Can
a quasi order be symmetric? Suppose there are two elements $x$ and $y$, such that
$x ⊑ y$. If the quasi order were symmetric, then we would also have $y ⊑ x$, and
since it is also transitive, we then have $x ⊑ x$, which violates the requirement
that a quasi order be irreflexive. This argument would not apply, of course, in
a trivial quasi order where no two elements are related by $⊑$, but non-trivial
quasi orders *cannot be symmetric*.

We should also inquire whether a quasi order can be (or must be) antisym-
metric. By definition, it is antisymmetric if $x ⊑ y ∧ y ⊑ x → x = y$ for any two
elements $x$ and $y$. Now, if we choose $x$ and $y$ to be the same, then
$x ⊑ y ∧ y ⊑ x$ is false, because the quasi order is irreflexive.
This means the logical implication is vacuously true.
If we choose $x$ and $y$ to be different, then $x ⊑ y ∧ y ⊑ x$
is again false (as we have just shown while discussing symmetry). In all cases,
therefore, the definition of antisymmetry is satisfied, but vacuously.
The conclusion is that quasi orders may be symmetric, but only if they
are trivial, and they are always antisymmetric, but only because they satisfy
the definition vacuously. The properties of symmetry and antisymmetry are
uninteresting for quasi orders.

Example 71
----------
Figure 10.22 gives the graph diagram for the quasi order (<)
on the set $\\{1,2,3,4\\}$.

![Figure 10.22](./images/fig.10.22.jpg)

The following functino tages a digraph and returns `True` if the relation
it represents is a quasi order, and `False` otherwise.

> isQuasiOrder :: Ord a => Digraph a -> Bool
> isQuasiOrder dig = isIrreflexive dig && isTransitive dig


Exercise 36
-----------
Work out the following expressions, and evaluate them with the computer:

    isQuasiOrder ([1,2,3,4], [(1,2),(2,3),(3,4)]) -- nope, not transitive
    isQuasiOrder ([1,2,3,4], [(1,2)]) -- yeap

10.9.3 Linear Order
===================
A *linear order* or *total order* is like a partial order, except that it requires that
all of the relation’s elements must be related to each other.

Example 72
----------
The $(≤)$ and $(≥)$ relations on real numbers are total orders: any
two numbers $x$ and $y$ can be compared with each other, and it is guaranteed
that either $x ≤ y$ or $y ≤ x$ will be true (and both are true if $x = y$).

Definition 55
-------------
A linear order is a partial order defined over a set $A$ in which
for each element $a$ and $b$ in $A$, either $a ⊑ b$ or $b ⊑ a$.

The elements of a linear order can be said to form a chain. When we
draw the graph diagram for a chain, we omit the arcs that are implied by
transitivity and reflexivity. Without these extra arcs, and because no element
can be incomparable to the others, the diagram looks like a real chain. For
example, the colours of the rainbow are often given as a chain starting with Red
and ending with Violet. As Red light has the longest wavelength and Violet the
shortest, the relation that imposes this chain ordering on the set of six colours
is the $≤$ relation on the wave frequency.

The `isLinearOrder` function takes a digraph and returns `True`if it represents a
linear order, and `False` otherwise.

> isLinearOrder :: Ord a => Digraph a -> Bool
> isLinearOrder dig@(Set xs, Set rel) = isPartialOrder dig && (and $ map isOrdered xs) where
>   isOrdered x = (length $ filter (\(y,z) -> x == y || x == z) rel) == length xs

Exercise 37
-----------
Eval by hand and check with computer.

    isLinearOrder ([1,2,3], [(1,2),(2,3),(1,3),(1,1),(2,2),(3,3)]) -- yes
    isLinearOrder ([1,2,3], [(1,2),(1,3),(1,1),(2,2),(3,3)]) -- no

10.8.4 Well Order
=================
A *well order* is a total (or linear) order that has a least element; furthermore,
every subset of a well order must have a least element.
The existence of a least element is significant because it provides a base
case for recursive functions and for inductive proofs. Note that any total order
that has a finite number of elements must have a least element. Some total
orders with an infinite number of elements have a least element, and others do
not.

Example 74
----------
The $(≤)$ relation on the set $N = \\{0,1,2,...}$ of natural numbers
is a total order. Furthermore, $N$ has a least element, because $∀x ∈ N. 0 ≤ x$.
Therefore $(≤)$ on $N$ is a well order.

Example 75
----------
The $(≤)$ relation on the set $Z = {...,−2,−1,0,1,2,...}$ of
integers is a total order. However, $Z$ does not have a least element, because
$$
∀x ∈ Z.∃y ∈ Z.(y ≤ x ∧ y ?= x).
$$

Therefore $(≤)$ on $Z$ is only a total order, and not a well order.

Definition 56
-------------
Given a set $S$ and a binary relation $R$ over $S$, $R$ is a well order
if $R$ is a linear order and every subset of $S$ that is not empty contains a least
element.

Well orders are important because they support induction, and they are
countable. Informally, a countable set is a set in which an arbitrary item can
eventually be processed by a computer. The set could be infinite: for example,
the set of natural numbers is infinite, but *every* element of that set would
eventually be reached if we just work on 0, 1, 2, ... in sequence. For example,
if a computer started printing the natural numbers, we would eventually see the
number 4058000023. However, if it started printing an uncountable set such as
the irrational numbers, then it might get stuck printing an infinite number of
irrationals *without reaching* the number we are interested in.

Exercise 38
-----------
We have been watching a computer terminal. Is the order in
which people come and use the terminal a total order?

Yes, there is a first guy who uses it, and then people who use it alter.

Exercise 39
-----------
Is it always possible to count the elements of a linear order?
No, not if it does not have a least element.

Exercise 40
-----------
Can a set that is not a well order be countable?
Yes, easily, e.g. any finite set.

10.8.5 Topological Sort
=======================
Computers are good at doing one task at a time, in sequence. When an algo-
rithm is working on a data structure, it needs to know which element of the
data structure to work on next. Often there is an order relation that must
be followed (for example, we might want to output the items in a database in
alphabetical order). If we have a total order on the elements of the data struc-
ture, the algorithm can use that to find the next piece of work. If, however,
we have only a partial order on the data items, then there are several possible
orders in which items could be processed while still respecting the order rela-
tion. Often we don’t care *which* order is used - we just want the algorithm to
find one and proceed with the work.
The process of taking a partial order and putting its elements into a total
order is called *topological sorting*.

Example 77
----------
Some compilers analyse the order in which procedures call each
other. Such a compiler could construct a ‘dependency graph’ for the program
it is translating, where each node corresponds to a procedure, and arcs in the
graph correspond to procedure calls. The dependency graph is a partial order.
Now, suppose the compiler generates object code for the procedures in the
order of their appearance in the call graph, so that the lowest-level procedures
are processed first and the highest level ones are done last, in order to make as
many procedure calls as possible into forward references. The compiler uses a
topological sort to produce the total order in which it prints the information.
The first name in the total order will be a procedure that doesn’t call any other
procedure, while the last is the top-level procedure with which the program
starts execution.

There is a simple and general algorithm for topological sorting. Choose $x$,
one of the elements that is greatest in the set $A$, and make it the first in the
sequence. Now do the same for the set $A - \\{x\\}$, and continue until $A$ is empty.

Example 78
----------
Suppose that we have a relation that expresses the call graph:

    {(’A’,’B’),(’B’,’B’),(’B’,’C’),(’B’,’D’),(’C’,’D’)}

What would the topological sort of this graph be? First, the functions that
call no other function would appear, followed by the functions that call them,
followed by the functions calling them, etc. The result would be ’D’, ’C’,
’B’, ’A’ (Figure 10.24).

![Figure 10.24](./images/fig.10.24.jpg)

Example 79
----------
What is the topological sort of $\\{(1,2),(1,3)\\}$ given the nodes
1,2,3? The sequence 3,2,1 or 2,3,1.

> topsort :: (Ord a, Show a) => Digraph a -> Set a
> topsort dig = fromList $ topsort' $ filterUnrelated dig where
>    filterUnrelated (Set xs, Set rel) =
>        (Set xs, Set $ filter (\(x,y) -> x `elem` xs && y `elem` xs) rel)
>    topsort' (_, Set []) = []
>    topsort' dig@(Set n, Set rel) = case greatestSet dig of
>          Set []     -> []
>          Set (x:xs) -> let rel' = Set $ filter ((/= x) . snd) rel
>                            n'   = Set $ filter (/= x) n
>                        in  x : topsort' (n', rel')


Exercise 41
-----------
Check to see that the following partial orders are not, in fact, total orders.
Use the computer to generate a total order, using a topological sort.

    topsort ([1,2,3,4], [(1,2),(1,3),(2,3),(1,4),(2,4),(1,1),(2,2),(3,3),(4,4)])
        -- not total, because there is no (3,4) pair
        -- total ordering: {1,2,3,4}

    topsort ([1,2,3], [(1,2),(1,3),(1,4),(1,1),(2,2),(3,3)])
        -- not total, no (2,3) pair
        -- total ordering: {1, 2, 3} or {1, 3, 2}

10.9 Equivalence Relations
==========================
Some relations can be used to break a set up into several categories or ‘parti-
tions’, where each element of the set belongs to just one of the categories. Such
a relation is called an *equivalence relation*.

Example 80
----------
In organising a personal telephone list, it is convenient to or-
ganise the set $S$ of people’s names into 26 sets corresponding to the first letter
in the name. In other words, we are making a section of the telephone list for
each letter of the alphabet.

Equivalence relations are like asking "is some property of a equal to some property of b?".
Above would be, "is the first letter of name equal to [a..z]?". Some equivalence relations
can be used for categorizing. In a category, everything is in the same category as itself
(reflexive). Also if $a$ is in the same category as $b$, then the reverse is true (symmetric).
Finally, if $a$ and $b$ are in the same category, and $b$ and $c$ are in the same category,
then $a$ and $c$ is in the same category (transitive).

Definition 57
-------------
A binary relation $R$ over a set $A$ is an $equivalence relation$ if
it is reflexive, symmetric, and transitive.

Example 82
----------
Suppose that everyone in the database lives in a real location
somewhere in the world. We can represent the world as a map, and then
partition the map into small areas by using a $LivesInSameLocationAs$ relation.

The equivalence classes of a non-empty equivalence relation can be thought
of as a *partition* of the set into disjoint subsets. Now we define this term
formally:

Definition 58
-------------
A *partition* $P$ of a non-empty set $A$ is a set of non-empty
subsets of $A$ such that

- For each subset $S_1$ and $S_2$ of $P$, either $S_1 = S_2$ or $S_1 ∩ S_2 = Ø$
- $A = ⋃_{S ∈ P} S$.

Example 83
----------
For example, let’s consider the set of people’s last names and
the relation `HasNameStartingWithSameLetterAs`. This relation divides the set
into 26 subsets. There can be no overlaps between the subsets, and the set of
names is the union of the subsets.

A good example of an equivalence relation, which is frequently used in com-
puting applications, comes from the mathematical *modulus* (mod) operation on
integers. The expression $e\ mod\ k$ gives the remainder produced when dividing
$e$ by $k$; and the value of $e\ mod\ k$ is a number between 0 and $k - 1$. Now, every
number $x$ which is a multiple of $k$ will have the property that $x\ mod\ k = 0$,
and we can build a set of all these numbers. Similarly, there is a set of numbers
that have the same remainder when divided by 1, by 2, and so on when divided
by $k$. To do this, we define the congruence relation as follows:

Definition 59
-------------
Let $k$ be a positive integer, and let $a$ and $b$ be integers. If
there is an integer $n$ such that
$$
(a - b) = n × k
$$
then $a$ is congruent to $b$ (modulo $k$). The mathematical notation for this
statement is
$$
a ≡ b\ (\text{mod } k)
$$

It is necessary to ensure that $k$ is a positive integer - positive means greater
than 0 - in order to avoid dividing by 0. We can define a relation, called the
congruence relation, for all $k$:

Definition 60
-------------
The congruence relation $C_k$ is defined for all natural $k$ such
that $k > 0$, as follows: $aC_kb$ if and only if $a ≡ b (mod k)$.
The congruence relation is useful because it is an equivalence relation:

Theorem 75
----------
For all natural $k > 0$, the congruence relation $C_k$ is an equivalence relation

Example 85
----------
Consider partitioning the integers by congruence ($C_3$) (See figure 10.25).
This gives rise to three sets: all the integers that are of the form $n × 3$
(this is just the set of multiples of 3), and the integers of the form $n × 3 + 1$,
and the integers of the form $n × 3 + 2$.

![Figure 10.25](./images/fig.10.25.jpg)

The following functions create the smallest
possible equivalence relation from a digraph and determine whether a given
relation is an equivalence relation. They do this by taking a digraph and
calculating its transitive symmetric reflexive closure.

> equivalenceRelation :: (Ord a) => Digraph a -> Digraph a
> equivalenceRelation dig = (transitiveClosure . symmetricClosure . reflexiveClosure) dig
>
> isEquivalenceRelation :: (Ord a) => Digraph a -> Bool
> isEquivalenceRelation r = and [isTransitive r, isSymmetric r, isReflexive r]

Exercise 42
-----------
Eval and check with computre

    equivalenceRelation ([1,2], [(1,1),(2,2),(1,2),(2,1)]) -- id
    equivalenceRelation ([1,2,3], [(1,1),(2,2)]) -- ([1,2,3], [(1,1),(2,2),(3,3)])

    isEquivalenceRelation ([1,2], [(1,1),(2,2),(1,2),(2,1)]) -- yes
    isEquivalenceRelation ([1], []) -- no, not reflexive

Exercise 43
-----------
Does the topological sort require that the graph's relation is a partial order?

Nope

Exercise 44
-----------
Can the graph given to a topological sort have cycles?

10.11 Review Exercises
======================

Exercise 45
-----------
Which of the following relations is an equivalence relation?

- (a) InTheSameRoomAs - yes
- (b) IsARelativeOf - no, but depends how it is defined
- (c) IsBiggerThan - no
- (d) The equality relation - yes

Exercise 46
-----------
Given a non-empty antisymmetric relation, does its transitive closure ever contain
symmetric arcs?

Yes, that can happen, if there are cycles, e.g.

    transitiveClosure ([1,2,3], [(1,2),(2,3),(3,1)]) -- ([1,2,3], [(1,2),(2,3),(3,1),(1,2),(2,1),(3,2),(1,3)])

Exercise 47
-----------
What relation is both a quasi order and an equivalence relation?

Only the empty relation.

Exercise 48
-----------
Write a function that takes a relation and returns `True` if that
relation has a power that is the given relation.

> hasCyclicPower2 :: Ord a => Digraph a -> Bool
> hasCyclicPower2 dig = let transitive = transitiveClosure dig
>                      in  isCyclic transitive where
>    isCyclic (Set xs, Set rel) = and [let z = (x,y) `elem` rel
>                                      in  z |
>                                          x <- xs, y <- xs]

> hasCyclicPower :: (Show a, Ord a) => Digraph a -> Bool
> hasCyclicPower dig@(set, rel) =
>       any (== rel) [relationalPower dig n
>                       | n <- [2..(length $ toList $ rel) + 1]]

Exercise 49
-----------
A quasi order is transitive and irreflexive. Can it have any symmetric loops in it?

No. If it did, then the end of each loop would have to have a reflexive
loop, because the relation is transitive. Thus it would not be irreflexive.

Exercise 50
-----------
Given an antisymmetric irreflexive relation, could its transitive
closure contain reflexive arcs?

Yes, eg `[(1,2),(2,3),(3,1)] --> [(1,2),(2,3),(3,1),(1,3),(2,1),(3,2),(1,1),(2,2),(3,3)]`

Exercise 51
-----------
Write a function that takes a relation and returns `True` if all of
its powers have fewer arcs than it does.

> fewerArcs :: Ord a => Digraph a -> Bool
> fewerArcs (set,rel) =
>    all (< (length $ toList $ rel))
>           [length $ toList $ (relationalPower (set,rel) n)
>               | n <- [2..1 + (length $ toList $ domain rel)]]

Exercise 52
-----------
Write a function that takes a relation and returns True if the
relation is smaller than its symmetric closure.

> smallerSymmetric :: Ord a => Digraph a -> Bool
> smallerSymmetric (set, rel) =
>    let (_, sym) = symmetricClosure (set, rel)
>    in (length $ toList sym) < (length $ toList rel)

Exercise 53
-----------
Given the partial order
$$
\\{(A,B),(B,C),(A,D)\\}
$$
which of the following is not a topological sort?

    [D,C,B,A]
    [C,B,D,A]
    [D,C,A,B]

The last one, because A cannot be weaker before B

Exercise 54
-----------
Is a reflexive and symmetric relation ever antisymmetric as well?

Yes, for example this is reflexive, symmetric, and antisymmetric:
[(1,1),(2,2),(3,3)]

Exercise 55
-----------
Given a relation containing only a single path of length $n$, how
many arcs can be added by its symmetric transitive closure?

The transitive closure will add $(1 + 2 ... + (n - 1))$ paths,
and the symmetric closure will double it, so it becomes
$2 × (1 + 2 ... + (n - 1))$

Exercise 56
-----------
Given a relation containing only a cycle of length $n$ containing
all of the nodes in the domain, which power will be reflexive?

$n$th power

Exercise 57
-----------
Can we write a function that determines whether the equality relation
over the positive integers is reflexive?

It is, but we can't cause the positive integers is an infinite relation.

Exercise 58
-----------
Why can't partial orders have cycles of length greater than 1?

Then it would not be transient any more.

Exercise 59
-----------
Is the last power of a relatio nalways the empty set?

No, not if it repeats.

Exercise 60
-----------
The following list comprehension gives the arcs of a poset diagram.
What kind of order relation does the diagram represent?

[(a,a+1) | a <- [1..]]

a linear order

Exercise 61
-----------
Is the composition of a relation containing only a single cycle
with its converse the equality relation?

    {(1,2),(2,1)};{(2,1),(1,2)} -- {(1,1),(2,2)}
    So yes

Exercise 62
-----------
Give examples of partial orders in which the set of greatest ele-
ments is the same as the set of weakest elements.

    The empty relation and the equality relation
