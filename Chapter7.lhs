Chapter 7. Predicate Logic
==========================

Definition 15
-------------
Any term in the form $F(x)$, where $F$ is a predicate name and
$x$ is a variable name, is a well-formed formula. Similarly, $F(x_1, x_2, ..., x_k)$ is a
well-formed formula; this is a predicate containing $k$ variables.

Universes
---------
The universe of discourse, often simply called the universe or abbreviated
$U$, is the set of possible values that the variables can have. Usually the universe
is specified just once, at the beginning of a piece of logical reasoning, but this
specification cannot be omitted.

The universe is called $U$, and its constants are written as
lower-case letters, typically $c$ and $p$ (to suggest a constant value, or a particular
value). Variables are also lower-case letters, typically $x, y, z$. Predicates are
upper-case letters $F, G, H, ....$ For example, $F(x)$ is a valid expression in the
language of predicate logic, and its intuitive meaning is ‘the variable $x$ has the
property $F$’. Generic expressions are written with a lower-case predicate; for
example $f(x)$ could stand for any predicate $f$ applied to a variable $x$.

Quantifiers
-----------
There are two quantifiers in predicate logic; these are the special symbols $∀$
and $∃$.

Definition 16
-------------
If $F(x)$ is a well-formed formula containing the variable $x$,
then $∀x$. $F(x)$ is a well-formed formula called a universal quantification. This
is a statement that everything in the universe has a certain property: ‘For all
$x$ in the universe, the predicate $F(x)$ holds’. An alternative reading is
‘Every $x$ has the property $F$’.
Universal quantifications are often used to state required properties. For
example, if you want to say formally that a computer program will give the
correct output for all inputs, you would use $∀$. The upside-down A symbol is
intended to remind you of *All*.

Definition 17
-------------
If $F(x)$ is a well-formed formula containing the variable $x$, then
$∃x$. $F(x)$ is a well-formed formula called an existential quantification. This is a
statement that something in the universe has a certain property: ‘There exists
an $x$ in the universe for which the predicate $F(x)$ holds’. An alternative reading
is ‘Some $x$ has the property $F$’.

Existential quantifications are used to state properties that must occur at
least once. For example, we might want to state that a database contains
a record for a certain person; this would be done with $∃$. The backwards E
symbol is reminiscent of *Exists*.

Expanding Quantified Expressions
--------------------------------
If the universe is finite (or if the variables are restricted to a finite set), ex-
pressions with quantifiers can be interpreted as ordinary terms in propositional
logic. Suppose $U = \\{c_1, c_2, ..., c_n \\}$, where the size of the universe is n. Then
quantified expressions can be expanded as follows:

$$
\begin{align}
∀x. F(x) = F(c_1) ∧ F(c_2) ∧ ··· ∧ F(c_n) \\\
∃x. F(x) = F(c_1) ∨ F(c_2) ∨ ··· ∨ F(c_n)
\end{align}
$$

With a finite universe, therefore, the quantifiers are just syntactic abbreviations.

If the variables are not restricted to a finite set, it is impossible even in
principle to expand a quantified expression. It may be intuitively clear to write
$F(c_1) ∧ F(c_2) ∧ F(c_3) ∧ ···$, but this is not a well-formed formula

Example 4
---------
Let the universe $U = \\{1,2,3\\}$, and define the predicates *even* and off as follows:

$$
\begin{align}
\text{even } x ≡ (x \text{ mod } 2 = 0) \\\
\text{odd }  x ≡ (x \text{ mod } 2 = 1)
\end{align}
$$

Two quantified expressions will be expanded and evaluated using these definitions:

    ∀x. (even x → ¬(odd x))
        = (even 1 → ¬(odd 1)) ∧ (even 2 → ¬(odd 2)) ∧ (even 3 → ¬(odd 3))
        = (False → ¬True) ∧ (True → ¬False) ∧ (False → ¬False)
        = True ∧ True ∧ True
        = True
    ∃x. (even x ∧ odd x)
        = (even 1 ∧ odd 1) ∨ (even 2 ∧ odd 2) ∨ (even 3 ∧ odd 3)
        = (False  ∧ True)  ∨ (True   ∧ False) ∨ (False  ∧ True)
        = False ∨ False ∨ False
        = False

Example 5
---------
Let $S = \\{0,2,4,6\\}$ and $R = \\{0,1,2,3\\}$. Then we can state
that every element $S$ is twice some element of R as follows:

$$
∀x ∈ S. ∃y ∈ R. x = 2 × y
$$

First expand the *outer* quantifier

$$
\begin{align}
   & (∃y ∈ R. 0 = 2 × y) \\\
∧ & (∃y ∈ R. 2 = 2 × y) \\\
∧ & (∃y ∈ R. 4 = 2 × y) \\\
∧ & (∃y ∈ R. 6 = 2 × y)
\end{align}
$$

The expand all four of the remaining quantifiers

$$
\begin{align}
   & ((0 = 2 × 0) ∨ (0 = 2 × 1) ∨ (0 = 2 × 2) ∨ (0 = 2 × 3)) \\\
∧ & ((2 = 2 × 0) ∨ (2 = 2 × 1) ∨ (2 = 2 × 2) ∨ (2 = 2 × 3)) \\\
∧ & ((4 = 2 × 0) ∨ (4 = 2 × 1) ∨ (4 = 2 × 2) ∨ (4 = 2 × 3)) \\\
∧ & ((6 = 2 × 0) ∨ (6 = 2 × 1) ∨ (6 = 2 × 2) ∨ (6 = 2 × 3))
\end{align}
$$

Exercise 1
----------
Let the universe $U = \\{ 1,2,3 \\}$. Expand the following expressions
into propositional term (i.e., remove the quantifiers)

(a) $∀x. F(x)$

$$
\begin{align}
  & ∀x. F(x) \\\
= & F(1) ∧ F(2) ∧ F(3)
\end{align}
$$

(b) $∃x. F(x)$

$$
\begin{align}
  & ∃x. F(x) \\\
= & F(1) ∨ F(2) ∨ F(3)
\end{align}
$$

(c) $∃x. ∀y. G(x,y)$

$$
\begin{align}
   & (G(1, 1) ∧ G(1,2) ∧ G(1,3)) \\\
∨ & (G(2, 1) ∧ G(2,2) ∧ G(2,3)) \\\
∨ & (G(3, 1) ∧ G(3,2) ∧ G(3,3)) \\\
\end{align}
$$

Exercise 2
----------
Let the universe be set of integers. Expand the following expression:
$∀x ∈ \\{1,2,3,4\\}.\ ∃y ∈ \\{5,6\\}.\ F(x,y)$

$$
\begin{align}
   & (F(1,5) ∨ F(1,6)) \\\
∧ & (F(2,5) ∨ F(2,6)) \\\
∧ & (F(3,5) ∨ F(3,6)) \\\
∧ & (F(4,5) ∨ F(4,6)) \\\
\end{align}
$$

7.1.4 The Scope of Variable Bindings
====================================
Quantifiers *bind* variables by giving them values from the universe.
If a variable $x$ appears with no quantification, it assumed to be any
arbitrary element of the universe, and the author should've told you what
that universe is.

The extent of a variable binding is called its *scope*. The scope is the
expression that appears right after the binding. For example, the scope of
$x$ in $∀x. F(x)$ is the subexpression $F(x)$.

Use parentheses for readability.
The expression $∀x. p(x) ∨ q(x)$ can be read in two different ways. Either

$$
∀x. (p(x) ∨ q(x))
$$
or
$$
(∀x. p(x)) ∨ q(x)
$$

There is a convention though. The scope of a variable binding is the *smallest possible*, if no
parentheses are given. So above, the second interpretation would be correct.

Also, we can reuse quantifiers to make expressions more readable, e.g.
$$
∀x. ∀y. F(x,y) = ∀x,y. F(x,y)
$$
Also works with set restrictions, e.g.
$$
∀x,y,z ∈ S. F(x,y,z) = ∀x ∈ S. ∀y ∈ S. ∀z ∈ S. F(x,y,z)
$$

7.1.5 Translating Between English and Logic
===========================================

Example 6
---------
Consider the translation of the sentence "Some birds can fly" into logic.
Let the universe be a set that contains all birds (it is all right if it
contains other tings too, such as frogs and other animals). Let $B(x)$ mean
"x is a bird" and $F(x)$ mean "$x$ can fly". Then "Some birds can fly" is translated as
$$
∃x. B(x) ∧ F(x)
$$

*Warning!* A common pitfall is to translate "Some birds can fly" as
$$
∃x. B(x) → F(x) \quad\quad\quad \textit{Wrong translation!}
$$

Because, let $p$ be a frog that somehow got into the universe.
Now $B(p)$ is false, so $B(p) → F(p)$ is true, (remember,
$\mathtt{False} → \mathtt{False} = \mathtt{True}$).
This is just saying that "If that frog were a bird then it would be able to fly",
which is true; it doesn't mean the frog is actually a bird, or that it
can actually fly. However, we have now found a value of $x$ -- namely the frog $p$ --
for which the proposition is true, and that is enough to satisy the predicate,
even if all birds in the universe happen to be penguins (which cannot fly).

Exercise 3
----------
Express the following statements formally, using the universe of natural numbers,
and the predicates $E(x) ≡ x \text{ is even}$ and $O(x) ≡ x \text{ is odd}$

- There is an even number
    - $∃x. E(x)$
- Every number is either even or odd
    - $∀x. (E(x) ∨ O(x))$
- No number is both even and odd
    - $∀x. ¬(E(x) ∧ O(x))$
- The sum of two odd numbers is even
    - $∀x, y. ((O(x) ∧ O(y)) → E(x + y))$
- The sum of an odd number and an even number is odd.
    - $∀x, y. ((O(x) ∧ E(y)) → O(x + y))$

Exercise 4
----------
Let the universe be the set of all animals, and define the following predicates:
$$
\begin{align}
B(x)    & ≡ x \text{ is a bird }\\\
D(x)    & ≡ x \text{ is a dove }\\\
C(x)    & ≡ x \text{ is a chicken }\\\
P(x)    & ≡ x \text{ is a pig }\\\
F(x)    & ≡ x \text{ can fly }\\\
W(x)    & ≡ x \text{ has wings }\\\
M(x, y) & ≡ x \text{ has more feathers than } y \text{ does}
\end{align}
$$

Translate the following sentences into logic. There are generally several
correct answers. Some of the English sentences are fairly close to logic,
while others require more interpretation before they can be rendered in logic.

- Chickens are birds.
    - $∀x. (C(x) → B(x))$
- Some doves can fly.
    - $∃x. (D(x) ∧ F(x))$
- Pigs are not birds
    - $∀x. (P(x) → ¬B(x))$
- Some birds can fly, and some can't.
    - $(∃x. (B(x) ∧ F(x))) ∧ (∃x. (B(x) ∧ ¬F(x)))$
- An animal needs wings in order to fly
    - $∀x. (F(x) → W(x))$
- If a chicken can fly, then pigs have wings
    - $(∃x. (C(x) ∧ F(x)) → (∀y. P(y) → W(y))) $
- Chickens have more feathers than pigs do
    - $∀x, y. (C(x) ∧ P(y)) → M(x,y)$
- An animal with more theaters than any chicken can fly
    - $∀x. \left((∃y. (C(y) ∧ M(x, y))) → F(x)\right)$

Exercise 5
----------
Translate the following into English.

- $∀x. (∃y. \text{wantsToDanceWith} (x,y))$
    - For all $x$, someone wants to dance with $x$
- $∃x. (∀y. \text{wantsToPhone}(y,x))$
    - For some $x$, every $y$ wants to phone x
- $∃x. (\text{tired } (x) ∧ ∀y. \text{helpsMoveHouse }(x,y))$
    - For some $x$, $x$ is tired and will help all $y$s move house

7.2 Computing with Quantifiers
==============================
You can use Haskell to compute with quantifiers (kind of)!
Predicates are simply functions that return `Bool`, just like in math!

The function `forall` takes a list numbers and a predicate, and applies
the predicate to each value in the universe and returns the conjuction
of theresults.

> forall :: [Int] -> (Int -> Bool) -> Bool
> forall xs f = all $ map f xs

Exercise 6
----------
Write the predicate logic expressions corresponding to the following
Haskell expressions. Then decide whether the value is `True` or `False`,
and evaluate using the computer. Note that `(== 2)` is a function that takes
a number and compares it with 2, while `(< 4)` is a function that takes a number
and returns `True` if it is less than 4.

    forall [1,2,3] (==2)

$$
∀x ∈ \\{1,2,3\\}. x = 2
$$

      forall [1,2,3] (==2)
    = (1 == 2) /\ (2 == 2) /\ (3 == 2)
    = False    /\ True     /\ False
    = False

    forall [1,2,3] (< 4)

$$
∀x ∈ \\{1,2,3 \\}. x < 4
$$

      forall [1,2,3] (< 4)
    = (1 < 4) /\ (2 < 4) /\ (3 < 4)
    = True    /\ True    /\ True
    = True


Like `forall`, the function `exists` applies its second argument to all of the
elements in its first argument:

> exists :: [Int] -> (Int -> Bool) -> Bool

However, `exists` forms the disjunction of the result.

> exists xs f = any $ map f xs

Exercise 7
----------

Again, rewrite the following in predicate logic, work out the values by hand
and evaluate on the computer:

      exists [0,1,2] (== 2)
    = (0 == 2) \/ (1 == 2) \/ (2 == 2)
    = False    \/ False    \/ True
    = True

$$
    ∃x ∈ \\{0,1,2\\}. x = 2
$$

      exists [1,2,3]  (> 5)
    = (1 > 5) \/ (2 > 5) \/ (3 > 5)
    = False   \/ False   \/ False
    = False

$$
    ∃x ∈ \\{1,2,3\\}. x > 5
$$

These functions can be nested in the same way as quantifiers can be nested in predicate logic.

Example 7
---------
$∀x ∈ \\{1,2\\}. (∃y ∈ \\{1,2\\}. x = y)$ has an inner assertion that can be implemented
as follows:

> inner_fun :: Int -> Bool
> inner_fum x = exists [1,2] (== x)

Now consider the evaluation of:

    forall [1,2] inner_fun
    
The evaluation can be calculated step by step. The function `and` takes a list of
Boolean values and combines them all using the $∧$ operation:

      forall [1,2] inner_fun
    = and [inner_fun 1, inner_fun 2]
    = and [exists [1,2] (== 1),
           exists [1,2] (== 2)]
    = and [or [1==1, 2==1],
           or [1==2, 2==2]]
    = and [True, True]
    = True

Exercise 8
----------
Define the predicate $p(x,y)$ to mean $x = y + 1$, and let the universe be
$\\{1,2\\}$. Calculate the value of each of the following expressions,
and then check your solution using Haskell.

(a) $∀x. (∃y. p(x,y))$
$$
\begin{align}
     & ((1 = 1 + 1) ∨ (1 = 2 + 1)) \\\
  ∧ & ((2 = 1 + 1) ∨ (2 = 2 + 1)) \\\
  =  & \\\
     & (\mathtt{False} ∨ \mathtt{False}) \\\
  ∧ & (\mathtt{True}  ∨ \mathtt{False}) \\\
  =  & \\\
     & \mathtt{False} ∧ \mathtt{True} \\\
  =  & \mathtt{False}
\end{align}
$$

(b) $∃x,y. p(x,y)$
$$
\begin{align}
  & ((1 = 1 + 1) ∨ (1 = 2 + 1)) ∨ ((2 = 1 + 1) ∨ (2 = 2 + 1)) \\\
= & (\mathtt{False} ∨ \mathtt{False}) ∨ (\mathtt{True} ∨ \mathtt{False}) \\\
= & \mathtt{True}
\end{align}
$$

(c) $∃x. (∀y. p(x,y))$

$$
\begin{align}
  & ((1 = 1 + 1) ∧ (1 = 2 + 1)) ∨ ((2 = 1 + 1) ∧ (2 = 2 + 1)) \\\
= & (\mathtt{False} ∧ \mathtt{False}) ∨ (\mathtt{True} ∧ \mathtt{False}) \\\
= & \mathtt{False} ∨ \mathtt{False} \\\
= & \mathtt{False}
\end{align}
$$

(d) $∀x,y. p(x,y)$

$$
\begin{align}
  & ((1 = 1 + 1) ∧ (1 = 2 + 1)) ∧ ((2 = 1 + 1) ∧ (2 = 2 + 1)) \\\
= & (\mathtt{False} ∧ \mathtt{False}) ∧ (\mathtt{True} ∧ \mathtt{False}) \\\
= & \mathtt{False} ∧ \mathtt{False} \\\
= & \mathtt{False}
\end{align}
$$

7.3 Logical Inference with Predicates
=====================================
The inference rules for propositional logic can be extended to handle predicate
logic as well. Four additional rules are required: an introduction
rule and an elimination rule for both of the quantifiers $∀$ and $∃$.

Since the $∀$ quantifier is related to $∧$, and $∃$ is a generaliztion of $∨$,
there is a similartiy when inferring the quantifiers to their respective operators.
If the universe is finite, then predicate logic is, in principle not even necessary,
but mere shortcuts for the expanded statements.
$$
\begin{align}
\dfrac{
    F(x) \quad\quad \\{x \text{ arbitrary} \\}
} {∀x. F(x)} {\scriptstyle \\{ ∀I \\}}
\quad\quad
\dfrac{
    ∀x. F(x)
} {F(p)} {\scriptstyle \\{ ∀E \\}} \\\ \\\ \hline \\\
\dfrac{
    F(p)   
}{∃x. F(x)} {\scriptstyle \\{ ∃I \\}}
\quad\quad
\dfrac{
    ∃x. F(x) \quad
    F(x) ⊢ A \quad
    \\{x \text{ not free in } A \\}
} {A} {\scriptstyle \\{ ∃ E\\}}
\end{align}
$$
We will always assume that the universe is non-empty. This is especially
important with the rule for forall elimination, which is invalid when the universe
of discourse is empty. Also, in the rule for exists elimination, the conclusion of
the rule (which is also the conclusion of the sequent in the hypothesis of the
rule) must be a proposition that does not depend in any way on the parameter
of the universe of discourse. That is, the proposition A in the statement of the
rule must not be a predicate that depends on x.

7.3.1 Universal Introduction $\\{∀I\\}$
========================================
Quite standard techinique, which is used often in math and CS, is to state and prove
a property about an arbitrary element of the universe, $x$, and then generalize this proof
to *all* elements of the universe.
E.g. this theorem about Haskell lists, which says there are two equivalent ways to 
append a singleton $x$ in front of a list $xs$. The definition of `(++)` is

    (++) :: [a] -> [a] -> [a]
    [] ++ ys = ys
    (x:xs) ++ ys = x : (xs ++ ys)
    
Thereom 57
----------
Let $x :: a$ and $xs :: [a]$. Then $x : xs = [x] ⧺ xs$

It is important to note that this theorem is stating a property about
*arbitrary x* and *xs*. It really means that the property holds for *all*
values of the variables, and this could be stated more formally with an explicit
quantifier:

Theorem 58
----------
$∀x :: a. ∀xs :: [a]. x : xs = [x] ⧺ xs$

These two theorems are exactly the same, except for style - the second is a little more
formal. The use of *arbitrary* variables means an implicit $∀$ is meant.
The following proof works for both theorems:

*Proof*.
$$
\begin{align}
  & [x] ⧺ xs \\\
= & (x : []) ⧺ xs & \text{def. of notation}  \\\
= & x : ([] ⧺ xs) & (⧺).2 \\\
= & x : xs        & (⧺).1
\end{align}
$$

In other words, if we can prove a theorem for an arbitrary variable,
then we can infer that the theorem is true for *all* possible values
of that variable.
This fact is expressed formally by the following inference rule,
which says that if an expression $a$ (which may contain a variable x) can
be proved for *arbitrary* $x$, then we may infer the proposition $∀x. a$.
Since this rule specificies what we need to know in order to infer an expression
containing $∀$, its name is $\\{ ∀ I\\}$

$$
\boxed{
    \dfrac{
        F(x) \quad\quad \\{x \text{ arbitrary} \\}
    } {∀x. F(x)} {\scriptstyle \\{ ∀I \\}}
}
$$

One example where it can be used, and one where it *cannot* be used:

Theorem 59
----------
$⊢ ∀x. E(x) → (E(x) ∨ ¬E(x))$

The proof use the $∀$ introduction rule. Note that the inference does
*not* depend on the particular value of $p$, thus the value of $p$
is arbitrary.

*Proof*.

$$
\dfrac{\quad\quad
    \dfrac{
        \dfrac{
            \boxed{E(x)}
        }{E(x) ∨ ¬E(x)}      {\scriptstyle \\{ ∨I_L \\}}
    }{E(x) → (E(x) ∨ ¬E(x))} {\scriptstyle \\{ →I \\}}
}{∀x. E(x) → (E(x) ∨ ¬E(x))} {\scriptstyle \\{ ∀I \\}}
$$

Now consider the following *incorrect* proof, which attempts to show that
all natural numbers are even.

$$
\dfrac{
    E(2)
}{∀x. E(x)} {\scriptstyle \\{ ∀I \\}} \quad \quad \textbf{WRONG!}
$$

2 is simply not an *arbitrary* variable, so this does not work!
The problem with talking about arbitrary variables, is that it is an adjective,
like blue or green. How can you know exactly if a variable is arbitrary or not?
In formal representations of logic, like ours, the requirement of arbitrariness
is replaced by a syntactic constraint.
The constrain is that the variable $x$ is not allowed to appear "free"
(that is, unbound by a quantifier) in any undischarged hypothesis that
was used to infer $F(x)$. E.g.

$$
\dfrac{
    \dfrac{x = 2}{E(x)}
} {∀x. E(x)} {\scriptstyle \\{ ∀I \\}}
$$
In this case, we have assumed $x = 2$ and then inferred $E(x)$ (this would
actually require several inference steps, or recourse to an auxiliary theorem, but
it is shown here as a single inference). Now, we have $E(x)$ above the line, so it
looks like we can use the ${∀I}$ rule to infer $∀x.E(x)$. However, the proof above
the line of $E(x)$ was based on the assumption $x = 2$, and $x$ appears free in that
assumption. Furthermore, the assumption was not discharged. Consequently,
the syntactic requirement for the ${∀I}$ rule has not been satisfied, and the
inference is not valid.

7.3.2 Universal Elimination
===========================
If you have established $∀x.F(x)$, then you can infer $F(p)$
if $p$ is an element of the universe.

$$
\dfrac{
    ∀x.F(x)
}{F(p)} {\scriptstyle \\{ ∀E \\}}
$$

The following theorem allows you to apply a universel implication
in the form $∀x.F(x) → G(x)$, to a particular proposition $F(p)$,
and its proof illustrates the $\\{ ∀ E\\}$ inference rule.

Theorem 60
----------
$F(p), ∀x. F(x) → G(x) ⊢ G(p)$

$$
\dfrac{
    \dfrac{}{F(p)}
    \quad
    \dfrac{
        ∀x. F(x) → G(x)
    } {F(p) → G(p)} {\scriptstyle \\{ ∀E \\}}
}{G(p)} {\scriptstyle \\{ → E \\}}
$$

In chapter 6 the implication chain theorem was proved
($a → b, b → c ⊢ a → c$). The $\\{ ∀I }$ inference rule
can be used to prove the corresponding theorem on universal
implications: from $∀x. F(x) → G(x)$ and $∀x. G(x) → H(x)$,
you can infer $∀x. F(x) → H(x)$. However, first we have to establish
that for an arbitrary $p$ in the universe, $F(p) → H(p)$,
and the proof of that proposition requires using the $\\{ ∀ E\\}$
rule twice to prove the particular propositions
$F(p) → G(p)$ and $G(p) → H(p)$.

Theorem 61
----------
$∀x. F(x) → G(x), ∀x. G(x) → H(x) ⊢ ∀x. F(x) → H(x)$

*Proof*.
$$
\dfrac{
    \dfrac{
        \dfrac{
            ∀x. F(x) → G(x)
        }{F(p) → G(p)}     {\scriptstyle \\{ ∀ E \\}}
        \quad
        \dfrac{
            ∀x. G(x) → H(x)
        }{G(p) → H(p)}     {\scriptstyle \\{ ∀ E \\}}
    }{F(p) → H(p)}         {\scriptstyle \\{ \text{impl. chain} \\}}
}{∀x. F(x) → H(x)}         {\scriptstyle \\{ ∀ I \\}}
$$

The following theorem says that you can change the order in
which the variables are bound in $∀x. ∀y. F(x,y)$. This theorem
is simple but extremely important.

Theorem 62
----------
$∀x. ∀y. F(x,y) ⊢ ∀y. ∀x. F(x,y)$

*Proof*.
$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{
                ∀x. ∀y. F(x,y)
            }{∀y. F(x,y)}       {\scriptstyle \\{ ∀ E \\}}
        } {F(x,y)}              {\scriptstyle \\{ ∀ E \\}}
    } {∀x. F(x,y)}              {\scriptstyle \\{ ∀ I \\}}
}{∀y. ∀x. F(x,y)}               {\scriptstyle \\{ ∀ I \\}}
$$

This theorem says that if, for all $x$, a proposition $P$
implies $f(x)$, then $P$ implies $∀x. f(x)$. This allows you
to pull a proposition $P$, which does not use $x$, out of
an implication bound $∀$.

Theorem 63
----------
$∀x. P → f(x) ⊢ P → ∀x. f(x)$

*Proof*.
$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{}{\boxed{P}}
            \quad
            \dfrac{
                ∀x. P → f(x)
            }{P → f(x)} {\scriptstyle \\{ ∀ E \\}}
        }{f(x)}         {\scriptstyle \\{ → E \\}}
    }{∀x. f(x)}         {\scriptstyle \\{ ∀ I \\}}
}{P → ∀x. f(x)}         {\scriptstyle \\{ → I \\}}
$$