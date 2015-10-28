Exercise 2
----------

> (/\) :: Bool -> Bool -> Bool
> x /\ y = x && y

> (\/) :: Bool -> Bool -> Bool
> x \/ y = x || y

> (==>) :: Bool -> Bool -> Bool
> True ==> False = False
> _    ==> _     = True

> (<=>) :: Bool -> Bool -> Bool
> x <=> y = x == y

Evaluate the following expressions

> a = False /\ True                           -- False
> b = True \/ (not True)                      -- True
> c = not (False \/ True)                     -- False
> d = (not (False /\ True)) \/ False          -- True
> e = (not True) ==> True                     -- True
> f = True \/ False ==> True                  -- True
> g = True ==> (True /\ False)                -- False
> h = False ==> False                         -- True
> i = (not False) <=> True                    -- True
> j = True <=> (False ==> False)              -- True
> k = False <=> (True /\ (False ==> True))    -- False
> l = (not (True \/ False)) <=> False /\ True -- True


Definition 8
------------
A tautology is a proposition that is always True, regardless of
the values of its variables.

Definition 9
------------
A contradiction is a proposition that is always False, regardless
of the values of its variables.

Definition 10
-------------
The notation $P_1, P_2, ..., P_n \vDash Q$ means that if all of the
propositions $P_1, P_2,..., P_n$ are true, then the proposition $Q$ is also true.

The $\vDash$ meta-operator makes a statement about the actual meanings of
the propositions; it’s concerned with which propositions are `True` and which
are `False`. Truth tables can be used to prove statements containing $\vDash$. The
meaning of a proposition is called its semantics. The set of basic truth values
(`True` and `False`), along with a method for calculating the meaning of any
well-formed formula, is called a model of the logical system.

Exercise 3
----------
Use the truth table functions to determine which of the following
formulas are tautologies

**(a)** $(\mathtt{True} \wedge P) \vee Q$ `--> not a tautology (P == False and Q == False)`  
**(b)** $(P \vee Q) \rightarrow (P \wedge Q)$  `--> not a tautology`  
**(c)** $(P \wedge Q) \rightarrow (P \vee Q)$  `--> is a tautology`  
**(d)** $(P \vee Q)   \rightarrow (Q \vee P)$  `--> is a tautology`  
**(e)** $((P \vee Q) \wedge (P \vee R)) \leftrightarrow (P \wedge (Q \vee R))$ `--> not a tautology`

Exercise 4
----------
In this exercise, and several more that follow it, you are given
an expression. Verify that the expression is a WFF by analyzing its
constituents at all levels down to the atomic primitives. Build a truth
table for the formula with one column for the formula itself (this should
be the rightmost column), and one column for each constituent of the
formula (at any level in the analysis).  
Each row in the table will correspond to a distinct combination of values
of the atomic primitives in the formula, and the rows will exhaust all
possible such combinations. Each column will begin with a heading,
which is a WFF (the full WFF or one of its constituents), and will be
filled with the value of the WFF that corresponds to the combination of
values of the primitives represented by a particular row.  
A WFF is said to be satisfiable if it is True for some values of its propo-
sitional variables. All WFFs fall into exactly one of three categories:
tautology, contradiction, or satisfiable but not tautology. Based on the
results in the truth table, place the WFF in one of these categories.

$$
(\mathtt{True} \wedge P) \vee Q
$$

**WWF analysis**  
- True is a constant, $P$ and $Q$ are propositional variables
- True and $P$ are WFF, therefore $True \wedge P$ is a WFF

**TruthTable**

| $P$ | $Q$ | $\mathtt{True} \wedge P$ | $(\mathtt{True} \wedge P) \vee Q$ |
| :-: | :-: | :----------------------: | :-------------------------------: |
|  1  |  1  |            1             |                 1                 |
|  1  |  0  |            1             |                 1                 |
|  0  |  1  |            0             |                 1                 |
|  0  |  0  |            0             |                 0                 |

It is *satisfiable* but not *tautology*

Exercise 5
----------
$$
    (P \vee Q) \wedge (P \vee R) \leftrightarrow P \wedge (Q \vee R)
$$

**WWF analysis**  
- $P,Q,R$ are propositional variables
- therefore $P \wedge Q$, $P \vee R$, $Q \vee R$, $P \wedge (Q \vee R)$,
  and $(P \vee Q) \wedge (P \vee R)$ are WWF
- therefore $(P \vee Q) \wedge (P \vee R) \leftrightarrow P \wedge (Q \vee R)$ is a WWF

**TruthTable**  
Let $A = (P \vee Q), B = (P \vee R), C = (Q \vee R)$

| $P$ | $Q$ | $R$ | $A$ | $B$ | $C$ | $A \wedge B$ | $P \wedge C$ | $A \wedge B \leftrightarrow P \wedge C$ |
| :-: | :-: | :-: | :-: | :-: | :-: | :----------: | :----------: | :-------------------------------------: |
|  1  |  1  |  1  |  1  |  1  |  1  |      1       |      1       |                    1                    |
|  1  |  1  |  0  |  1  |  1  |  1  |      1       |      1       |                    1                    |
|  1  |  0  |  1  |  1  |  1  |  1  |      1       |      1       |                    1                    |
|  1  |  0  |  0  |  1  |  1  |  0  |      1       |      0       |                    0                    |
|  0  |  1  |  1  |  1  |  1  |  1  |      1       |      0       |                    0                    |
|  0  |  1  |  0  |  1  |  0  |  1  |      0       |      0       |                    1                    |
|  0  |  0  |  1  |  0  |  1  |  1  |      0       |      0       |                    1                    |
|  0  |  0  |  0  |  0  |  0  |  0  |      0       |      0       |                    1                    |

It is *satisfiable* but not *tautology*

Exercise 6
----------
$$
((P \wedge \lnot Q) \vee (Q \wedge \lnot P)) \rightarrow \lnot (P \leftrightarrow Q)
$$

**WWF analysis**  
- $P,Q$ are propositional variables
    - therefore, $\lnot P, \lnot Q$ are valid WFFs
        - therefore $(P \wedge \lnot Q), (Q \wedge \lnot P)$ are WWFs
    - therefore $P \leftrightarrow Q$ is a WFF
        - therefore $\lnot (P \leftrightarrow Q)$ is a WFF
    - in conclusion $((P \wedge \lnot Q) \vee (Q \wedge \lnot P)) \rightarrow \lnot (P \leftrightarrow Q)$ is a WFF


**TruthTable**  
Let $A = (P \wedge \lnot Q), B = (Q \wedge \lnot P), C = (P \leftrightarrow Q), D = \lnot C$

| $P$ | $Q$ | $\lnot $P$ | $\lnot Q$ | $A$ | $B$ | $C$ | $D$ | $A \vee B$ | $(A \vee B) \leftarrow D$ |
| :-: | :-: | :--------: | :-------: | :-: | :-: | :-: | :-: | :--------: | :-----------------------: |
|  1  |  1  |     0      |     0     |  0  |  0  |  1  |  0  |     0      |             1             |
|  1  |  0  |     0      |     1     |  1  |  0  |  0  |  1  |     1      |             1             |
|  0  |  1  |     1      |     0     |  0  |  1  |  0  |  1  |     1      |             1             |
|  0  |  0  |     1      |     1     |  0  |  0  |  1  |  0  |     0      |             1             |

It is a *tautology*.

Exercise 7
----------
$$
(P \rightarrow Q) \wedge (P \rightarrow \lnot Q)
$$

**WWF analysis**  
- $P,Q$ are propositional variables
- therefore, $\lnot Q, (P \rightarrow Q)$ are valid WFFs
- therefore, $(P \rightarrow \lnot Q)$ is a WWF
- therefore $(P \rightarrow Q) \wedge (P \rightarrow \lnot Q)$ is a WWF
    
**TruthTable**  

| $P$ | $Q$ | $\lnot Q$ | $P \rightarrow Q$ | $P \rightarrow \lnot Q$ | $(P \rightarrow Q) \wedge (P \rightarrow \lnot Q)$ |
| :-: | :-: | :-------: | :---------------: | :---------------------: | :------------------------------------------------: |
|  1  |  1  |     0     |         1         |            0            |                         0                          |
|  1  |  0  |     1     |         0         |            1            |                         0                          |
|  0  |  1  |     0     |         1         |            1            |                         1                          |
|  0  |  0  |     1     |         1         |            1            |                         1                          |

It is *satisfiable*

Exercise 8
----------
$$
(P \rightarrow Q) \wedge (\lnot P \rightarrow Q)
$$

**WWF analysis**  
- $P,Q$ are propositional variables
- therefore, $\lnot P, (P \rightarrow Q)$ are valid WFFs
- therefore, $(\lnot P \rightarrow Q)$ is a WWF
- therefore $(P \rightarrow Q) \wedge (\lnot P \rightarrow Q)$ is a WWF

**TruthTable**  

| $P$ | $Q$ | $\lnot P$ | $P \rightarrow Q$ | $\lnot P \rightarrow Q$ | $(P \rightarrow Q) \wedge (\lnot P \rightarrow Q)$ |
| :-: | :-: | :-------: | :---------------: | :---------------------: | :------------------------------------------------: |
|  1  |  1  |     0     |         1         |            1            |                         1                          |
|  1  |  0  |     0     |         0         |            1            |                         0                          |
|  0  |  1  |     1     |         1         |            1            |                         1                          |
|  0  |  0  |     1     |         1         |            0            |                         0                          |

It is *satisfiable*

Exercise 9
----------
$$
(P \rightarrow Q) \leftrightarrow (\lnot Q \rightarrow \lnot P)
$$

**WWF analysis**  
- $P,Q$ are propositional variables
- therefore, $\lnot P, \lnot Q, (P \rightarrow Q)$ are valid WFFs
- therefore, $\lnot Q \rightarrow \lnot P$ is a WWF
- therefore $(P \rightarrow Q) \leftrightarrow (\lnot Q \rightarrow \lnot P)$ is a WWF

**TruthTable**  

| $P$ | $Q$ | $\lnot P$ | $\lnot Q$ | $P \rightarrow Q$ | $\lnot Q \rightarrow \lnot P$ | $(P \rightarrow Q) \leftrightarrow (\lnot Q \rightarrow \lnot P)$ |
| :-: | :-: | :-------: | :-------: | :---------------: | :---------------------------: | :---------------------------------------------------------------: |
|  1  |  1  |     0     |     0     |         1         |               1               |                                 1                                 |
|  1  |  0  |     0     |     1     |         0         |               0               |                                 1                                 |
|  0  |  1  |     1     |     0     |         1         |               1               |                                 1                                 |
|  0  |  0  |     1     |     1     |         1         |               1               |                                 1                                 |

It is a *tautology*


6.5 Natural Deduction: Inference Reasoning
==========================================
Logical inference means reasoning formally about a set of statements in
order to decide, beyond all shadow of doubt, what is true. In order to make
the reasoning absolutely clear cut, we need to do several things:

- The set of statements we’re reasoning about must be defined. This is
  called the *object language*, and a typical choice would be propositional
  expressions.
- The methods for inferring new facts from given information must be
  specified precisely. These are called the *inference rules*.
- The form of argument must be defined precisely, so that if anybody claims
  to have an argument that proves a fact, we can determine whether it
  actually is a valid argument. This defines a *meta-language* in which
  proofs of statements in the object language can be written. Every step
  in the reasoning must be justified by an inference rule.

Definition 11
-------------
The notation $P_1, P_2,...,P_n \vdash Q$ is called a *sequent*, and it
means that if all of the propositions $P_1, P_2,...,P_n$ are known, then
the proposition $Q$ can be inferred formally using the inference
rules of natural deduction.  
The notation $P \vdash Q \rightarrow P$ means *there is a proof* of $Q \rightarrow P$, and the proof
assumes $P$.
In this case $P$ is called the *assumption* and $Q \rightarrow P$ is called the conclusion.

Natural deduction works with a very minimal set of basic operators. In fact, the
only primitive built-in objects are the constant False, and the three operators
$\wedge$, $\vee$ and $rightarrow$. Everything else is an abbreviation! It’s particularly intriguing
that False is the only primitive logic value in the natural deduction system.

Definition 12
-------------
The constant `True` and the operators $\lnot$ and $\leftrightarrow$ are abbrevia-
tions defined as follows:

$$
    \begin{align}
    \mathtt{True} & = \mathtt{False} \rightarrow \mathtt{False} \\\
    \lnot a & = a \rightarrow \mathtt{False} \\\
    a \leftrightarrow b & = (a \rightarrow b) \wedge (b \rightarrow a)
    \end{align}
$$

6.5.2 And Introduction $\left\\{\wedge I \right\\}$
======================
$$
\frac{a \quad\quad b}
{a \wedge b}            {\scriptstyle \left\\{\wedge I\right\\}}
$$


Exercise 10
-----------
Prove $P,Q,R \vdash P \wedge (Q \wedge R)$


$$
\dfrac
    {\dfrac{}{P} \quad\quad\quad \dfrac{Q \quad R}{Q \wedge R} {\scriptstyle \left\\{\wedge I \right\\}} }
    {P \wedge (Q \wedge R)} {\scriptstyle \left\\{ \wedge I \right\\}}
$$

Excercise 11
------------
Consider the following two propositions:
$$
    \begin{align}
    x & = A \wedge (B \wedge (C \wedge D)) \\
    y & = (A \wedge B) \wedge (C \wedge D)
    \end{align}
$$
Describe the shapes of the proofs for $x$ and $y$. Assuming $A,B,C$, and $D$.
Suppose each proposition has $2^n$ propositional variables.
What then would be the heights of the proof trees?

$$
\dfrac
    {
    \dfrac{}{A} \quad\quad \dfrac
        {
        \dfrac{}{B} \quad \dfrac
            {C \quad D}
            {C \wedge D}   {\scriptstyle \left\\{\wedge I \right\\}}
        }
        {B \wedge (C \wedge D)}   {\scriptstyle \left\\{\wedge I \right\\}}
    }
    {A \wedge (B \wedge (C \wedge D))}   {\scriptstyle \left\\{\wedge I \right\\}}
$$

As you can see, the proof tree converges towards the right, as each nested
proposition is proofed.

For $y$, it would create a balanced tree.

Supposing each proposition had $2^n$ variables:

- x: the height would be proportional to the variables, i.e. also $2^n$.
- y: the height would be $log_2(2^n) = n$

Exercise 12
-----------
Prove $(P \wedge Q) \wedge R \vdash P \wedge (Q \wedge R)$


$$
\dfrac{
    \dfrac{
        \dfrac{
            (P \wedge Q) \wedge R
        } {P \wedge Q} {\scriptstyle \left\\{\wedge E_L \right\\}}
    }{P} {\scriptstyle \left\\{\wedge E_L \right\\}}
    \quad\quad
    \dfrac{
        \dfrac{
            \dfrac{
                (P \wedge Q) \wedge R
            } {P \wedge Q} {\scriptstyle \left\\{\wedge E_L \right\\}}
        }{Q} {\scriptstyle \left\\{\wedge E_R \right\\}}
        \quad\quad
        \dfrac{
           (P \wedge Q) \wedge R 
        }{R} {\scriptstyle \left\\{\wedge E_R \right\\}}
    } {Q \wedge R} {\scriptstyle \left\\{\wedge I \right\\}}
}{
    (P \wedge (Q \wedge R)
} {\scriptstyle \left\\{\wedge I \right\\}}
$$

6.5.4 Imply Elimination $\left\\{\rightarrow E \right\\}$
===================================
The Imply Elimination rule $\left\\{\rightarrow E \right\\}$ says that if you know $a$ is true, and also
that $a$ implies $b$, then you can infer $b$. The traditional Latin name for the rule
is *Modus Ponens*.

$$
\dfrac{
  a \quad\quad a \rightarrow b  
} {b} {\scriptstyle \left\\{\rightarrow E \right\\}}
$$

The following theorem provides a simple example of the application of *Imply Elimination*.

Theorem 42
----------
$Q \wedge P, P \wedge Q \rightarrow R \vdash R$  
*Proof*.

$$
\dfrac{
    \dfrac{
        \dfrac{
           Q \wedge P 
        }{P} {\scriptstyle \wedge E_R}
        \quad
        \dfrac{
            Q \wedge P
        }{Q} {\scriptstyle \wedge E_L}
    } { P \wedge Q } {\scriptstyle \wedge I}
    \quad
    \dfrac{}{P \wedge Q \rightarrow R} 
}{R} {\scriptstyle \rightarrow E }
$$

Often we have chains of implication of the form $a \rightarrow b, b \rightarrow c$ and so on.
The following theorem says that given $a$ and these linked implications, you can
infer $c$.

Theorem 43
----------
For all propositions $a,b$ and $c.\quad a,a \rightarrow b, b \rightarrow c \vdash c$  
*Proof.*

$$
\dfrac{
    \dfrac{
        a
        \quad
        a \rightarrow b
    } {b} {\scriptstyle \rightarrow E}
    \quad\quad
    \dfrac{}{b \rightarrow c}
}{c} {\scriptstyle \rightarrow E}
$$

Exercise 13
-----------
Prove $P, P \rightarrow Q, (P \wedge Q) \rightarrow (R \wedge S) \vdash S$.

$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{}{P}
            \quad\quad
            \dfrac{
                P
                \quad
                P \rightarrow Q
            } {Q} {\scriptstyle \rightarrow E}
        }
        {P \wedge Q} {\scriptstyle \wedge I}
        \quad
        \dfrac{}{(P \wedge Q) \rightarrow (R \wedge S)}
    }
    {R \wedge S} {\scriptstyle \rightarrow E}
}
{S} {\scriptstyle \wedge E_R}
$$

Exercise 14
-----------
Prove $P \rightarrow Q, R \rightarrow S, P \wedge R \vdash S \wedge R$

$$
\dfrac{
    \dfrac{
        \dfrac{
            P \wedge R
        } {R} {\scriptstyle \wedge E_R}
        \quad\quad
        \dfrac{}{R \rightarrow S}
    } {S} {\scriptstyle \rightarrow E}
    \quad\quad
    \dfrac{
        P \wedge R
    }
    {R} {\scriptstyle \wedge E_R}
}{S \wedge R} {\scriptstyle \\{\wedge I\\}}
$$

6.5.5 Imply Introduction $\\{ \rightarrow I \\}$
===============================================
The Imply Introduction rule $\\{ \rightarrow I \\}$ says that,
in order to infer the logical implication 
$a \rightarrow b$, you must have a proof of $b$ using $a$ as an assumption.

$$
\dfrac{a \vdash b}
{a \rightarrow b} {\scriptstyle \\{ \rightarrow I \\}}
$$

Theorem 44
----------
$\vdash (P \wedge Q) \rightarrow Q$  
*Proof*.

First consider the sequent $P \wedge Q \vdash Q$, which is proved by the
following And Elimination inference:

$$
\dfrac{P \wedge Q} {Q} {\scriptstyle \\{\wedge E_r\\}}
$$

Now we can use the sequent (that is, the theorem established by the inference)
and the $\\{ \rightarrow I\\}$ rule:

$$
\dfrac{P \wedge Q \vdash Q}
{P \wedge Q \rightarrow Q}
{\scriptstyle \\{ \rightarrow I \\}}
$$

It is customary to write the entire proof as a single tree, where a complete
proof tree appears above the line of the $\\{ \rightarrow I\\}$ rule.
That allows us to prove $\vdash P \wedge Q \rightarrow Q$ with just one diagram:

$$
\dfrac{
    \dfrac{P \wedge Q}
    {Q} {\scriptstyle \\{ \wedge E_R \\}}
}
{P \wedge Q \rightarrow Q} {\scriptstyle \\{\rightarrow I\\}}
$$

From this diagram, it looks there is an assumption $P \wedge Q$.
However, that was a temporary, local assumption whose only purpose was
to establish $P \wedge Q \vdash Q$. Once that result is obtained the
assumption $P \wedge Q$ can be thrown away. An assumption
that is made temporarily only in order to establish a sequent,
and which is then thrown away, is said to be *discharged*. A discharged
assumption does *not* need to appear to the left of the $\vdash$ of the main
theorem. In our example, the proposition $P \wedge Q \rightarrow$ is *always*
true, and it doesn't matter wheter $P \wedge Q$ is true or false.

In big proof trees it may be tricky to keep track of which assumptions
have been discharged and which have not. We will indicate the discharged
assumptions by putting a box around them. (A more common notation is to
draw a line through the discharged assumption, but for certain propositions
that leads to a highly unreadable result.) Following this convention, the proof
becomes

$$
\dfrac{
    \dfrac{\boxed{P \wedge Q}}
    {Q} {\scriptstyle \\{ \wedge E_R \\}}
}
{P \wedge Q \rightarrow Q} {\scriptstyle \\{\rightarrow I\\}}
$$

Recall the proof of Theorem 43, which used the chain of implications 
$a \rightarrow b$ and $b \rightarrow c$ to infer $c$, given also that $a$ is true.
A more satisfactory theorem would just focus on the chain of implications,
without relying on a actually being true.
The following theorem gives this purified chain property:
it says that if $a \rightarrow b$ and $b \rightarrow c$, then $a \rightarrow c$.

Theorem 45
----------
(Implication chain rule). For all propositions $a,b$ and $c$.

$$
a \rightarrow b,\ b \rightarrow c\ \vdash\ a \rightarrow c
$$

**Proof**. Because we are proving an implication $a \rightarrow c$,
we need to use the $\\{ \rightarrow I \\}$ rule -- there is no other way
to introduce the $\rightarrow$ operator!
The rule requires a proof of $c$ given an assumption $a$, which is 
essentially the same proof tree used before in Theorem 43.
The important point, however, is that the assumption $a$ is discharged
when we apply $\\{ \rightarrow I \\}$. The other two assumptions,
($a \rightarrow b$ and $b \rightarrow c$), are not discharged.
Consequently $a$ doesn't appear to the left of the $\vdash$
in the theorem; instead it appears to the left of the $\rightarrow$ in 
the *conclusion* of the theorem.


$$
\dfrac{
    \dfrac{
        \dfrac{
            \boxed{a}
            \quad\quad
            a \rightarrow b
        }{b}  {\scriptstyle \\{ \rightarrow E \\}}
        \quad\quad
        \dfrac{}{b \rightarrow c}
    }{c} {\scriptstyle \\{ \rightarrow E \\}}
}{ a \rightarrow c} {\scriptstyle \\{ \rightarrow I \\}}
$$

Sometimes in large proofs it can be confusing to see just where an assump-
tion has been discharged. You may have an assumption P with a box around
it, but there could be all sorts of implications $P \rightarrow ···$
which came from some- where else.
In such cases it’s probably clearer to build up the proof in stages,
with several separate proof tree diagrams.

A corollary of this implication chain rule is the following theorem, which
says that if $a \rightarrow b$ but you know that $b$ is false,
than $a$ must also be false.
This is an important theorem which is widely used to prove other theorems, and its
traditional Latin name is *Modus Tollens*.

Theorem 46 (Modus Tollens)
--------------------------
For all propositions $a$ and $b$,

$$
a \rightarrow b, \lnot b\ \vdash\ \lnot a 
$$

*Proof*. First we need to expand out the abbreviations, using the definition
that $\lnot a$ means $a \rightarrow \mathtt{False}$. This results in the
following sequent to be proved:
$a \rightarrow b, b \rightarrow \mathtt{False}\ \vdash\ a \rightarrow \mathtt{False}$
This is an instance of Theorem 45.

Exercise 15
-----------
Prove $P\ \vdash\ Q \rightarrow P \wedge Q$

$$
\dfrac{
    \dfrac{}{\boxed{Q}}
    \dfrac{
        P
        \quad
        \boxed{Q}
    }{P \wedge Q} {\scriptstyle \\{\wedge I\\}}
}{Q \rightarrow P \wedge Q} {\scriptstyle \\{ \rightarrow I \\}}
$$

Exercise 16
-----------
Prove $\vdash P \wedge Q \rightarrow Q \wedge P$

$$
\dfrac{
    \dfrac{}{\boxed{P \wedge Q}}
    \dfrac{
        \dfrac{\boxed{P \wedge Q }}{Q} {\scriptstyle \\{ \wedge E_R \\}}
        \quad
        \dfrac{\boxed{P \wedge Q }}{P} {\scriptstyle \\{ \wedge E_L \\}}
    } {Q \wedge P} {\scriptstyle \\{ \wedge I \\}}
}{P \wedge Q \rightarrow Q \wedge P } {\scriptstyle \\{ \rightarrow I \\}}
$$

6.5.6 Or Introduction $\\{ \vee I_L\\}, \\{  \vee I_R \\}$
==========================================================
Like all the introduction rules, Or Introduction specifies what you have to
establish in order to infer a proposition containing a new ∨ operator. If the
proposition a is true, then both $a \vee b$ and $b \vee a$ must also be true (you can see
this by checking the truth table definition of $\vee$). Or Introduction comes in two
forms, Left and Right.

$$
\boxed{
    \dfrac{
        a
    }{a \wedge b} {\scriptstyle \\{ \wedge I_L \\}}
    \quad\quad\quad
    \dfrac{
        b
    }{a \wedge b} {\scriptstyle \\{ \wedge I_R \\}}
}
$$

Theorem 47
----------
$P \wedge Q \vdash P \vee Q$

*Proof*. The proof requires the use of Or Introduction.
There are two equally valid ways to organise the proof.
One method begins by establishing P and then uses $\\{ \vee I_L\\}$
to put the P to the left of $\vee$:

$$
\dfrac{
    \dfrac{
        P \wedge Q
    } {P} {\scriptstyle \\{ \wedge E_L \\}}
}{P \vee Q} {\scriptstyle \\{ \vee I_L \\}}
$$

An alternative proof first establishes $Q$ and then uses
$\\{ \wedge I_R \\}$ to put the $Q$ to the right of $\vee$:

$$
\dfrac{
    \dfrac{
        P \wedge Q
    } {Q} {\scriptstyle \\{ \wedge E_R \\}}
}{P \vee Q} {\scriptstyle \\{ \vee I_R \\}}
$$

Normally, of course, you would choose one of these proofs randomly; there is
no reason to give both.

Exercise 17
-----------
Prove $P \rightarrow \mathtt{False} \vee P$

$$
\dfrac{
    \frac{}{\boxed{P}}
    \quad
    \dfrac{
        \boxed{P}
    }{\mathtt{False} \vee P} {\scriptstyle \\{ \vee I_R \\}}
}{P \rightarrow \mathtt{False} \vee P} {\scriptstyle \\{ \rightarrow I \\}}
$$

Exercise 18
-----------
Prove $P, Q \vdash (P \wedge Q) \vee (Q \vee R)$

$$
\dfrac{
    \dfrac{
        P \quad\quad Q
    }{P \wedge Q} {\scriptstyle \\{ \wedge I \\}}
}{(P \wedge Q) \vee (Q \vee R)} {\scriptstyle \\{ \vee I_L \\}}
$$

6.5.7 Or Elimination $\\{ \vee E \\}$
=====================================
The Or Elimination rule specifies what you can conclude if you know that a
proposition of the form $a \vee b$ is true. We can’t conclude anything about either
$a$ or $b$, because either of those might be false even if $a \vee b$ is true.
However, suppose we know $a \vee b$ is true, and also suppose there is
some conclusion $c$ that can be inferred from $a$ and can also be inferred from $b$.
Then $c$ must also be true.

$$
\boxed{
    \dfrac{
        a \vee b \quad
        a \vdash c \quad
        b \vdash c \quad
    } {c} {\scriptstyle \\{ \vee E \\}}
}
$$

Or Elimination is a formal version of *proof by case analysis*. It amounts to
the following argument: ‘There are two cases: (1) if $a$ is true, then $c$ holds; (2)
if $b$ is true then $c$ holds. Therefore $c$ is true’. Here is an example:

Theorem 48
----------
$(P \wedge Q) \vee (P \wedge R) \vdash P$

*Proof*. There are two proofs above the line.
The first proof assumes $P \wedge Q$ in order to infer $P$.
However, that inference is all tat we need; $P \wedge Q$ is discharged
and is not an assumption of the main theorem. For the same reason, $P \wedge R$
is also discharged. The only undischaged assumption is 
$(P \wedge Q) \vee (P \wedge R) \vdash P$, which therefore must appear
to the left of the $\vdash$ in the main theorem.

$$
\dfrac{
    (P \vee Q) \wedge (P \vee R) \quad
    \dfrac{
        \boxed{P \wedge Q}
    }{P} {\scriptstyle \\{ \wedge E_L\\}}
    \dfrac{
        \boxed{P \wedge R}
    }{P} {\scriptstyle \\{ \wedge E_L\\}}
}{P} {\scriptstyle \\{ \vee E \\}}
$$

Finally, here is a slightly more complex example:

Theorem 49
----------
$(a \wedge b) \vee (a \wedge c) \vdash b \vee c$

*Proof*.

$$
\dfrac{
    (a \wedge b) \vee (a \wedge c) \quad\quad
    \dfrac{
        \dfrac{a \wedge b}{b}  {\scriptstyle \\{ \wedge E_R \\}}
    } { b \vee c}    {\scriptstyle \\{ \vee I_L \\}}
    \dfrac{
        \dfrac{a \wedge c}{c}            {\scriptstyle \\{ \wedge E_R \\}}
    } { b \vee c}    {\scriptstyle \\{ \vee I_R \\}}
}{ b \vee c } {\scriptstyle \\{ \vee E \\}}
$$

6.5.8 Identity $\\{ID\\}$
=========================
The Identity rule $\\{ID\\}$ says, rather obviously, that if you know $a$ is true, then
you know $a$ is true.

$$
\boxed{\dfrac{a}{a} {\scriptstyle \\{ID\\}}}
$$

Although the Identity rule seems trivial, it is also necessary. Without it,
for example, there would be no way to prove the following theorem, which we
would certainly want to be true.

Theorem 50
----------
$P \vdash P$  
*Proof.*

$$
\dfrac{P}{P} {\scriptstyle \\{ID\\}}
$$

An interesting consequence of the Identity rule is that True is true, as the
following theorem states.

Theorem 51
----------
$\vdash \mathtt{True}$

*Proof*.  Recall that True is an abbreviation for 
$\mathtt{False} \rightarrow \mathtt{False}$.
We need to infer this implication using the $\\{ \rightarrow I\\}$ rule, 
and that in turn requires a proof of `False`
given the assumption `False`. This can be done with the $\\{ID\\}$ rule;
it could also be done with the Contradiction rule, which we’ll study shortly.

$$
\dfrac{
    \dfrac{\boxed{False}}{False} {\scriptstyle \\{ ID \\}}
}{\mathtt{False} \rightarrow \mathtt{False}} {\scriptstyle \\{ \rightarrow I\\}}
$$

Notice that we had to assume $\mathtt{False}$ in order to prove this theorem, but
fortunately that assumption was discharged when we inferred
$\mathtt{False} \rightarrow \mathtt{False}$.
The assumption of $\mathtt{False}$ was just temporary, and it doesn’t appear
as an assumption of the theorem.
That’s a relief; it would never do if we had to assume that
$\mathtt{False}$ is true in order to prove that $\mathtt{True}$ is true!

6.5.9 Contradiction $\\{ CTR \\}$
=================================
The Contradiction rule says that you can infer *anything at all* given the as-
sumption that $\mathtt{False}$ is true.

$$
\boxed{
    \dfrac{
        \mathtt{False}
    } {
        a
    } {\scriptstyle \\{ CTR \\}}
}
$$

In effect, this rule says that $\mathtt{False}$ is untrue, and it expresses that fact purely
through the mechanism of logical inference. It would be disappointing if we
had to describe the fundamental falseness of $\mathtt{False}$ by making a meaningless
statement outside the system, such as ‘$\mathtt{False}$ is wrong.’ After all, the whole point
of natural deduction is to describe the process of logical reasoning formally,
using a small set of clearly specified inference rules. It would also be a bad
idea to try to define $\mathtt{False}$ as equal to $\lnot \mathtt{True}$.
Since $\mathtt{True}$ is already defined to be $\lnot \mathtt{False}$,
that would be a meaningless and useless circular definition.  
The Contradiction rule describes the untruthfulness of $\mathtt{False}$ indirectly, by
saying that everything would become provable if $\mathtt{False}$ is ever assumed or
inferred.

Theorem 52
----------
$P, \lnot P \vdash Q$

*Proof*. Recall that $\lnot P$ is just an abbreviation for
$P \rightarrow \mathtt{False}$. That means we can use the
$\\{\rightarrow E\\}$ rule to infer $\mathtt{False}$, and once that happens
we can use $\\{CTR\\}$ to support any conclusion we feel like - even $Q$,
which isn't even mentioned in the theorem's assumptions!

$$
\dfrac{
    \dfrac{
        P \quad P \rightarrow False
    }{False} {\scriptstyle \\{\rightarrow E\\}}
}{Q} {\scriptstyle \\{CTR\\}}
$$

The Identity and Contradiction rules often turn up in larger proofs. A
typical example occurs in the following theorem, which states an important
property of the logical Or operator $\vee$. This theorem says that if $a \vee b$ is true,
but $a$ is false, then $b$ has to be true. It should be intuitively obvious, but the
proof is subtle and merits careful study.

Theorem 53
----------
For all propositions $a$ and $b$,

$$
a \vee b, \lnot a \vdash b
$$

*Proof*. As usual, the $\lnot a$ abbreviation should be expanded to
$a \rightarrow \mathtt{False}$.
Because we’re given $a \vee b$, the basic structure will be an Or Elimination,
and there will be two smaller proof trees corresponding to the two cases for
$a \vee b$. In the first case, when a is assumed temporarily,
we obtain a contradiction with the theorem’s assumption of $\lnot a$:
$\mathtt{False}$ is inferred, from which we can infer anything
else (and here we want $b$). In the second case, when $b$ is assumed temporarily,
the desired result of $b$ is an immediate consequence of the $\{ID\}$ rule.

$$
\dfrac{
    \dfrac{}{a \vee b \quad\quad}
    \dfrac{
        \dfrac{
            \boxed{a} \quad a \rightarrow \mathtt{False}
        } { \mathtt{False} } {\scriptstyle \\{ \rightarrow I\\}}
    }{b} {\scriptstyle \\{ CTR \\}}
    \dfrac{
        \boxed{b}
    }{b} {\scriptstyle \\{ ID \\}}
}{b} {\scriptstyle \\{ \vee E \\}}
$$

Note that there are two undischarged assumptions, $a \vee b$ and 
$a \rightarrow \mathtt{False}$, and there are two temporary assumptions
that are discharged by the $\\{\vee E\\}$ rule.

6.5.10 Reductio ad Absurdum $\\{RAA\\}$
=======================================
The *Reductio ad Absurdum* (reduce to absurdity) rule says that if you can
infer $\mathtt{False}$ from an assumption $\lnot a$, then $a$ must be true.
This rule underpins the proof by contradiction strategy:
if you want to prove $a$, first assume the contradiction $\lnot a$
and infer $\mathtt{False}$; the $\\{RAA\\}$ rule then allows you to infer $a$.

Theorem 54
==========
(Double Negation). $\lnot \lnot a \vdash a$

*Proof*. Our strategy is to use a proof by contradiction.
That is, if we can assume $\lnot a$ and infer $\mathtt{False}$,
the $\\{RAA\\}$ rule would then yield the inference $a$.
Because we are given $\lnot \lnot a$, the contradiction will have
the following general form:

$$
\dfrac{
    \lnot a \quad\quad \lnot \lnot a
}{\mathtt{False}}
$$

To make this go through, we need to replace the abbreviations by their
full defined values. Recall that $\lnot a$ is an abbreviation for
$a \rightarrow \mathtt{False}$, so $\lnot \lnot a$
actually means $(a \rightarrow \mathtt{False}) \rightarrow \mathtt{False}$.
Once we expand out these definitions, the inference becomes much clearer:
it is just a simple application of $\\{\rightarrow E \\}$:

$$
\dfrac{
    \dfrac{
        \boxed{a \rightarrow \mathtt{False}}
        \quad\quad
        (a \rightarrow \mathtt{False}) \rightarrow \mathtt{False}
    }{\mathtt{False}} {\scriptstyle \\{ \rightarrow E \\}}
}{a} {\scriptstyle \\{ RAA \\}}
$$

6.5.10 Inferring the Operator Truth Tables
==========================================
We can use the inference rules of natural deduction to calculate the truth
tables of the logical operators. If we take the inference rules
as the foundation of mathematical logic, then truth tables are no longer
definitions; they merely summarise a lot of calculations using the rules.

Example ($\mathtt{True} \wedge \mathtt{False}$)
-----------------------------------------------
Prove that $\mathtt{True} \wedge \mathtt{False}$ is logically equivalent to
$\mathtt{False}$, and also that it is *not* logically equivalent to $\mathtt{True}$
Recall that $\mathtt{False}$ is a constant, while $\mathtt{True}$ is an abbrevation
for $\mathtt{False} \rightarrow \mathtt{False}$. First, here is a proof of
$ \vdash \mathtt{True} \wedge \mathtt{False} \rightarrow \mathtt{False}$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True} \wedge \mathtt{False}}
    } {\mathtt{False}} {\scriptstyle \\{ \wedge E_R \\}}
} {\mathtt{True} \wedge \mathtt{False} \rightarrow \mathtt{False}} {\scriptstyle \\{\rightarrow I\\}}
$$

So that is one of the "arrows" of logical equivalence, i.e. 
$\mathtt{True} \wedge \mathtt{False} \rightarrow \mathtt{False}$

For the other arrow, we reverse the implication like so:
$\vdash \mathtt{False} \rightarrow \mathtt{True} \wedge \mathtt{False}$

$$
\dfrac{
    \dfrac{
        \mathtt{False}
    } {\mathtt{True} \wedge \mathtt{False}} {\scriptstyle \\{ CTR \\}}
}{ \mathtt{False} \rightarrow \mathtt{True} \wedge \mathtt{False} } {\scriptstyle \\{ \rightarrow I \\}}
$$

We have thereby calculated of on the line sof the truth table definition of $\wedge$.
The complete truth tables for the logical operators can be inferred using similar
calculations.

Exercise 19
-----------
Use the inference rules to calculate the value of $\mathtt{True} \wedge \mathtt{True}$
In order to so, we should infer $\mathtt{True} \wedge \mathtt{True} \rightarrow \mathtt{True}$
and $\mathtt{True} \rightarrow \mathtt{True} \wedge \mathtt{True}$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True} \wedge \mathtt{True}}
    }{\mathtt{True}} {\scriptstyle \\{\wedge E_R \\}}
} {\mathtt{True} \wedge \mathtt{True} \rightarrow \mathtt{True}}
{\scriptstyle \\{ \rightarrow I \\}}
$$

Proving the other part of equivalence ($\mathtt{True} \rightarrow \mathtt{True} \wedge \mathtt{True}$)

$$
\dfrac{
    \dfrac{
        \dfrac{
            \boxed{\mathtt{True}}
        } {\mathtt{True}}
        \quad\quad
        \dfrac{
            \boxed{\mathtt{True}}
        } {\mathtt{True}}
    }{\mathtt{True} \wedge \mathtt{True}} {\scriptstyle \\{\wedge I \\}}
} {\mathtt{True} \rightarrow \mathtt{True} \wedge \mathtt{True}}
{\scriptstyle \\{ \rightarrow I \\}}
$$

Exercise 20
-----------
Use the inference rules to calculate the value of $\mathtt{True} \vee \mathtt{False}$

Proof of $\mathtt{True} \vee \mathtt{False} \rightarrow \mathtt{True}$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True} \vee \mathtt{False}}
        \quad\quad
        \dfrac{\mathtt{True}}{\mathtt{True}} {\scriptstyle \\{ ID \\}}
        \quad\quad
        \dfrac{\mathtt{False}}{\mathtt{True}} {\scriptstyle \\{ CTR \\}}
    } {\mathtt{True}} {\scriptstyle \\{ \vee E \\}}
} {\mathtt{True} \vee \mathtt{False} \rightarrow \mathtt{True}}
  {\scriptstyle \\{ \rightarrow I \\}}
$$

Proof of $\mathtt{True} \rightarrow \mathtt{True} \vee \mathtt{False}$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True}}
    } {\mathtt{True} \vee \mathtt{False}} {\scriptstyle \\{ \vee I_L \\}}
} {\mathtt{True} \rightarrow \mathtt{True} \vee \mathtt{False}}
  {\scriptstyle \\{ \rightarrow I \\}}
$$

Exercise 21
-----------
Notice that in the proof of
$\vdash \mathtt{True} \wedge \mathtt{False} \rightarrow \mathtt{False}$ we used
$\\{\wedge E_R \\}$ to obtain $\mathtt{False}$ from
$(\mathtt{False} \rightarrow \mathtt{False}) \wedge  \mathtt{False}$, and everything worked fine.
However, we could have used
$\\{\wedge E_L \\}$ instead to infer $\mathtt{False} \rightarrow \mathtt{False}$, which
is $\mathtt{True}$. What would happen if that choice is made? Would it result in
calculating the wrong value of $\mathtt{True} \wedge  \mathtt{False}$?
Is it possible to show that $\mathtt{True} \wedge  \mathtt{False}$
is not logically equivalent to $\mathtt{True}$?

Sure, that works, too, the proof just gets a little more involved

$$
\dfrac{
    \dfrac{
        \dfrac{}{\mathtt{False}} \quad\quad
        \dfrac{
            \boxed{(\mathtt{False} \rightarrow \mathtt{False}) \wedge \mathtt{False}}
        } {(\mathtt{False} \rightarrow \mathtt{False})} {\scriptstyle \\{ \wedge E_L \\} }
    } { \mathtt{False} } {\scriptstyle \\{ \rightarrow E\\}}
} {(\mathtt{False} \rightarrow \mathtt{False}) \wedge \mathtt{False} \rightarrow \mathtt{False}} {\scriptstyle \\{\rightarrow I\\}}
$$

