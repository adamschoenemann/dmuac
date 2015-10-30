Chapter 6.7. Boolean Algebra
============================
Boolean constant laws
---------------------

$$
\begin{align}
a \wedge \mathtt{False} = & \mathtt{False} & \\{\wedge\ null\\} \\\
a \vee \mathtt{True}    = & \mathtt{True}  & \\{\vee\ null\\}    \\\
a \wedge \mathtt{True}  = & a              & \\{\wedge\ identity\\}          \\\
a \vee \mathtt{False}   = & a              & \\{\vee\ identity\\}            \\\
\end{align}
$$

Exercise 25
-----------
Simplify $(P \wedge \mathtt{False}) \vee (Q \wedge \mathtt{True})$

$$
\begin{align}
&  (P \wedge \mathtt{False}) \vee (Q \wedge \mathtt{True}) \\\
= & False \vee (Q \wedge \mathtt{True})  & \\{ \wedge \ null \\} \\\
= & False \vee (Q)                       & \\{ \wedge \ identity \\} \\\
= & Q                                    & \\{ \vee \ identity \\} \\\
\end{align}
$$

Exercise 26
-----------
Prove the equation
$(P \wedge \mathtt{False}) \wedge \mathtt{True} = \mathtt{False}$

$$
\begin{align}
&   (P \wedge \mathtt{False}) \wedge \mathtt{True} = \mathtt{False} & \\\
= & \mathtt{False} \wedge \mathtt{True} & \\{ \wedge \ null \\} \\\
= & \mathtt{False}  & \\{ \wedge \ identity\\}
\end{align}
$$

More laws of boolean algebra
----------------------------

$$
\begin{align}
a                     \quad & → \quad a ∨ b                        & \\{\text{disjunctive implication}\\} \\\
a ∧ b                \quad & → \quad a                             & \\{\text{conjunctive implication}\\} \\\
a ∧ a                \quad & =  \quad a                              & \\{∧\text{ idempotent}\\} \\\
a ∨ a                \quad & =  \quad a                              & \\{∨\text{ idempotent}\\} \\\
a ∧ b                \quad & =  \quad b ∧ a                         & \\{∧\text{ commutative}\\} \\\
a ∨ b                \quad & =  \quad b ∨ a                         & \\{∨\text{ commutative}\\} \\\
(a ∧ b) ∧ c         \quad & =  \quad a ∧ (b ∧ c)                  & \\{∧\text{ associative}\\} \\\
(a ∨ b) ∨ c         \quad & =  \quad a ∨ (b ∨ c)                  & \\{∨\text{ associative}\\} \\\
a ∧ (b ∨ c)         \quad & =  \quad (a ∧ b) ∨ (a ∧ c)           & \\{∧\text{ distributes over } ∨\\} \\\
a ∨ (b ∧ c)         \quad & =  \quad (a ∨ b) ∧ (a ∨ c)           & \\{∨\text{ distributes over } ∧\\} \\\
¬(a ∧ b)             \quad & =  \quad ¬a ∨ ¬b                       & \\{\text{DeMorgan’s law}\\} \\\
¬(a ∨ b)             \quad & =  \quad ¬a ∧ ¬b                       & \\{\text{DeMorgan’s law}\\} \\\
¬\mathtt{True}        \quad & =  \quad \mathtt{False}                 & \\{\text{negate } \mathtt{True}\\} \\\
¬\mathtt{False}       \quad & =  \quad \mathtt{True}                  & \\{\text{negate } \mathtt{False}\\} \\\
a ∧ ¬a               \quad & =  \quad \mathtt{False}                 & \\{∧ \text{complement}\\} \\\
a ∨ ¬a               \quad & =  \quad \mathtt{True}                  & \\{∨ \text{complement}\\} \\\
¬(¬a)                 \quad & =  \quad a                              & \\{\text{double negation}\\} \\\
a ∧ (a → b)         \quad & → \quad b                             & \\{\text{Modus Ponens}\\} \\\
(a → b) ∧ ¬b        \quad & → \quad ¬a                            & \\{\text{Modus Tollens}\\} \\\
(a ∨ b) ∧ ¬a        \quad & → \quad b                             & \\{\text{disjunctive syllogism}\\} \\\
(a → b) ∧ (b → c)  \quad & → \quad a → c                  & \\{\text{implication chain}\\} \\\
(a → b) ∧ (c → d)  \quad & → \quad (a ∧ c) → (b ∧ d) & \\{\text{implication combination}\\} \\\
(a ∧ b) → c         \quad & =  \quad a → (b → c)                  & \\{\text{Currying}\\} \\\
a → b                \quad & =  \quad ¬a ∨ b                        & \\{\text{implication}\\} \\\
a → b                \quad & =  \quad ¬b → ¬a                       & \\{\text{contrapositive}\\} \\\
(a → b) ∧ (a → b)  \quad & =  \quad ¬a                             & \\{\text{absurdity}\\} \\\
a \leftrightarrow b   \quad & =  \quad (a → b) ∧ (b → a)           & \\{\text{equivalence}\\} \\\
\end{align}
$$

Exercise 27
-----------
Prove $(P ∧ ((Q ∨ R) ∨ Q) ∧ S = S ∧((R ∨ Q) ∧ P)$

$$
\begin{align}
& (P ∧ ((Q ∨ R) ∨ Q) ∧ S     &   \\\
= & S ∧ (P ∧ ((Q ∨ R) ∨ Q)   & \\{ ∧ \text{ commutative} \\} \\\
= & S ∧ (((Q ∨ R) ∨ Q) ∧ P)  & \\{ ∧ \text{ commutative} \\} \\\
= & S ∧ (((R ∨ Q) ∨ Q) ∧ P)  & \\{ ∨ \text{ commutative} \\} \\\
= & S ∧ ((R ∨ (Q ∨ Q)) ∧ P)  & \\{ ∨ \text{ associative} \\} \\\
= & S ∧ ((R ∨ Q) ∧ P)         & \\{ ∨ \text{ idempotent}  \\}
\end{align}
$$

Exercise 28
-----------
Prove $P ∧ (Q ∧ (R ∧ S)) = ((P ∧ Q) ∧ R) ∧ S$

$$
\begin{align}
&   P ∧ (Q ∧ (R ∧ S))  & \\\
= & (P ∧ Q) ∧ (R ∧ S)  & \\{ ∧ \text{ associative} \\} \\\
= & ((P ∧ Q) ∧ R) ∧ S  & \\{ ∧ \text{ associative} \\} \\\
\end{align}
$$

Exercise 29
-----------
Give an intuitive explanation of the second DeMorgan's law.

$\lnot (a ∨ b)$ says that *neither* $a$ or $b$ are true, which is basically
saying $a$ is NOT true AND $b$ is NOT true.

Exercise 30
-----------
Prove the following statements using equational reasoning with the laws
of Boolean algebra:

$$
(A ∨ B) ∧ B \leftrightarrow B
$$
*Proof*.

$$
\begin{align}
& (A ∨ B) ∧ B & \\\
= & (A ∨ B) ∧ (B ∨ \mathtt{False})    & \\{ ∨ \text{ identity} \\} \\\
= & (B ∨ A) ∧ (B ∨ \mathtt{False})    & \\{ ∨ \text{ commutes} \\} \\\
= & B ∨ (A ∧ \mathtt{False})           & \\{ \vee \text{ distributes over } ∧\\} \\\
= & B ∨ \mathtt{False}                  & \\{ ∧ \text{null} \\} \\\
= & B                                    & \\{ ∨ \text{identity} \\}
\end{align}
$$

[$∧ \text{ absorption}$]

Exercise 31
-----------
$$
((\lnot A ∧ B) ∨(A ∧ \lnot B)) \leftrightarrow (A ∨ B) ∧ (\lnot (A ∧ B))
$$
*Proof*.
$$
\begin{align}
&  ((\lnot A ∧ B) ∨(A ∧ \lnot B)) &  \\\
= & ((\lnot A ∧ B) ∨ A) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∨ \text{ distributes over } ∧ \\} \\\
= & (A ∨ (\lnot A ∧ B)) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∨ \text{ cummutative} \\} \\\
= & ((A ∨ \lnot A) ∧ (A ∨ B)) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∨ \text{ distributes over } ∧ \\} \\\
= & (\mathtt{True} ∧ (A ∨ B)) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∨ \text{ complement}\\} \\\
= & ((A ∨ B) ∧ \mathtt{True}) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∧ \text{ commutative}\\} \\\
= & (A ∨ B) ∧ ((\lnot A ∧ B) ∨ \lnot B) & \\{ ∧ \text{ identity}\\} \\\
= & (A ∨ B) ∧ (\lnot B ∨ (\lnot A ∧ B)) & \\{ ∨ \text{ commutative }\\} \\\
= & (A ∨ B) ∧ ((\lnot B ∨ \lnot A) ∧ (\lnot B ∨ B)) & \\{ ∨ \text{ distributes over } ∧ \\} \\\
= & (A ∨ B) ∧ ((\lnot B ∨ \lnot A) ∧ \mathtt{True}) & \\{ ∨ \text{ complement} \\} \\\
= & (A ∨ B) ∧ (\lnot B ∨ \lnot A) & \\{ ∧ \text{ complement} \\} \\\
= & (A ∨ B) ∧ (\lnot (B \wedge A)) & \\{ \text{DeMorgan's 1st} \\} \\\
= & (A ∨ B) ∧ (\lnot (A \wedge B)) & \\{ ∧ \text{ cummutative} \\} \\\
Q.E.D
\end{align}
$$

Exercise 32
-----------
$$
\lnot(A ∧ B) \leftrightarrow \lnot A ∨ \lnot B
$$
[Restriction: This is DeMorgan's first law. Do not use that law in the proof.
You may use DeMorgan's other law.]

$$
\begin{align}
  & \lnot(A ∧ B) &  \\\
= & \lnot(\lnot(\lnot A) ∧ \lnot(\lnot B)) & \\{ \text{double negation twice} \\} \\\
= & \lnot(\lnot(\lnot A ∨ \lnot B))        & \\{ \text{DeMorgan's 2nd} \\} \\\
= & \lnot A ∨ \lnot B                      & \\{ \text{double negation} \\} \\\
  & Q.E.D
\end{align}
$$

Exercise 33
-----------
$$
(A ∨ B) ∧ (\lnot A ∨ C) ∧ (B ∨ C) \leftrightarrow (A ∨ B) ∧ (\lnot A ∨ C)
$$

$$
\begin{align}
  & (A ∨ B) ∧ (\lnot A ∨ C) ∧ (B ∨ C) & \\\
= & (A ∨ B) ∧ (\lnot A ∨ C) ∧ ((B ∨ C) ∨ \mathtt{False}) & \\{ ∨ \text{ identity} \\} \\\
= & (A ∨ B) ∧ (\lnot A ∨ C) ∧ ((B ∨ C) ∨ (A ∧ \lnot A)) & \\{ ∧ \text{ complement} \\} \\\
= & (A ∨ B) ∧ (\lnot A ∨ C) ∧ ((B ∨ C) ∨ A) ∧ ((B ∨ C) ∨ \lnot A) & \\{ ∨ \text{ over } ∧ \\} \\\
= & (A ∨ B) ∧ (\lnot A ∨ C) ∧ (A ∨ B ∨ C) ∧ (\lnot A ∨ B ∨ C) & \\{ \text{com and assoc}\\} \\\
= & (\lnot A ∨ C) ∧ (A ∨ B) ∧ (A ∨ B ∨ C) ∧ (\lnot A ∨ B ∨ C) & \\{ ∧ \text{commutes}\\} \\\
= & (\lnot A ∨ C) ∧ ((A ∨ B) ∧ (A ∨ B ∨ C)) ∧ (\lnot A ∨ B ∨ C) & \\{ ∧ \text{assoc}\\} \\\
= & ((A ∨ B) ∧ (A ∨ B ∨ C)) ∧ (\lnot A ∨ C) ∧ (\lnot A ∨ B ∨ C) & \\{ ∧ \text{commutes}\\} \\\
= & ((A ∨ B) ∧ (A ∨ B ∨ C)) ∧ ((\lnot A ∨ C) ∧ (\lnot A ∨ B ∨ C)) & \\{ ∧ \text{assoc}\\} \\\
= & (A ∨ (B ∧ (B ∨ C))) ∧ (\lnot A ∨ (C ∧ (B ∨ C))) & \\{ ∨ \text{ over } ∧ \\} \\\
= & (A ∨ ((B ∨ C) ∧ B)) ∧ (\lnot A ∨ ((B ∨ C) ∧ C)) & \\{ ∧ \text{ commutes } \\} \\\
= & (A ∨ ((C ∨ B) ∧ B)) ∧ (\lnot A ∨ ((B ∨ C) ∧ C)) & \\{ ∨ \text{ commutes } \\} \\\
= & (A ∨ B) ∧ (\lnot A ∨ C) & \\{ \text{ absorption twice} \\} \\\
& Q.E.D
\end{align}
$$

6.9 Meta-Logic
==============

Definition 13
-------------
A formal system is *consistent* if the following statement is true for all
well-formed formulas $a$ and $b$:

$$
\text{If } a \vdash b \text{ then } a \Vdash b 
$$

In other words, the system is consistent if each proposition provable using
the inference rules is *actually* true.

Definition 14
-------------
A formal system is *complete* if the following statement is true for all
well-formed forumlas $a$ and $b$:

$$
\text{If } a \Vdash b \text{ then } a \vdash b
$$

In other words, for all propositions that are *actually* true, then it *must* also
be provable using the inference rules.

Fortunately it turns out that propositional logic is both consistent and complete.
This means that you can't prove false theorems and if a theorem is true it has a proof.

Theorem 56
----------
Propositional logic is consistent and complete.

Exercise 34
-----------
$$ A ∧ \lnot A \vdash \mathtt{False}$$

$$
\dfrac{
    \dfrac{
        A ∧ \lnot A
    } {A} {\scriptstyle \\{ ∧E_L \\}}
    \quad
    \dfrac{
        A ∧ \lnot A
    } {A → \mathtt{False}} {\scriptstyle \\{ ∧E_R \\}}
}{\mathtt{False}} {\scriptstyle \\{ →E \\}}
$$


Exercise 35
-----------
$$ A \vdash \lnot (\lnot A) $$

$$
\dfrac{
    \dfrac{
        A \quad \boxed{A → \mathtt{False}}
    }{\mathtt{False}} {\scriptstyle \\{ →E \\}}
}{(A → \mathtt{False}) → \mathtt{False}} {\scriptstyle \\{ →I \\}}
$$

Exercise 36
-----------
$$
A, A → B, B → C, C → D \vdash D
$$

[Note: Extension of Implication Chain Rule, Theorem 11]

$$
\dfrac{
    \dfrac{
        \dfrac{
            A
            \quad
            A → B
        }{B} {\scriptstyle \\{ →E\\} }
        \quad
        \dfrac{}{B → C}
    }{C}                    {\scriptstyle \\{ →E\\} }
    \quad
    \dfrac{}{ C → D }
}{D}    {\scriptstyle \\{ →E\\}}
$$

Exercise 37
-----------
$$
A → B \vdash \lnot B → \lnot A
$$

$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{
                \boxed{(A → \mathtt{False}) → \mathtt{False}}
                \quad\quad
                A → B
            } {(B → \mathtt{False}) → \mathtt{False}} {\scriptstyle \\{ →E \\}}
            \quad\quad
            \dfrac{}{\boxed{B → \mathtt{False}}}
        } {\mathtt{False}} {\scriptstyle \\{ →E \\}}
    } {A → \mathtt{False}} {\scriptstyle \\{ → I \\}}
} { (B → \mathtt{False}) → (A → \mathtt{False}) } {\scriptstyle \\{ →I \\}}
$$

[Note: This conclusion is called the contrapositive of the premise]

Exercise 38
-----------
$$
A → B, A → \lnot B \vdash \lnot A
$$

$$
\dfrac{
    \dfrac{
        \dfrac{
            \boxed{A} \quad A → B
        }{B} {\scriptstyle \\{ →E \\}}
        \quad\quad
        \dfrac{
            \boxed{A} \quad\quad A → (B → \mathtt{False})
        }{B → \mathtt{False}} {\scriptstyle \\{ →E \\}}
    } {\mathtt{False}} {\scriptstyle \\{ →E \\}}
}{A → \mathtt{False}} {\scriptstyle \\{ →I \\}}
$$

Exercise 39
-----------
$$
\lnot A \vdash (A → B) ∧ (A → \lnot B)
$$

$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{
                \boxed{A} \quad\quad A → \mathtt{False} 
            }{\mathtt{False}} {\scriptstyle \\{ → E \\}}
        }{B} {\scriptstyle \\{ CTR \\}}
    } {A → B} {\scriptstyle \\{ → I \\}}
    \quad\quad
    \dfrac{
        \dfrac{
            \dfrac{
                \boxed{A} \quad\quad A → \mathtt{False}
            }{\mathtt{False}}
        }{\lnot B} {\scriptstyle \\{ CTR \\}}
    } {A → \lnot B} {\scriptstyle \\{ → I \\}}
}{A → B ∧ A → \lnot B} {\scriptstyle \\{ ∧ I \\}}
$$

Exercise 40
-----------
$$
A ∨ (B ∨ C) \vdash (A ∨ B) ∨ C
$$

$$
\dfrac{
    \dfrac{}{A ∨ (B ∨ C)}
    \quad
    \dfrac{
        \dfrac{\boxed{A}}{A ∨ B} {\scriptstyle \\{ ∨ I_L \\}}
    }{(A ∨ B) ∨ C} {\scriptstyle \\{ ∨ I_L \\}}
    \quad
    \dfrac{
        \dfrac{}{\boxed{B ∨ C}}
        \quad
        \dfrac{
            \dfrac{\boxed{B}}{A ∨ B} {\scriptstyle \\{ ∨ I_R \\}}
        }{(A ∨ B) ∨ C}  {\scriptstyle \\{ ∨ I_L \\}}
        \quad
        \dfrac{
            \boxed{C}
        }{(A ∨ B) ∨ C} {\scriptstyle \\{ ∨ I_R \\}}
    }{(A ∨ B) ∨ C} {\scriptstyle \\{ ∨ E \\}}
} {(A ∨ B) ∨ C} {\scriptstyle \\{ ∨ E \\}}
$$

Exercise 41
-----------
$$
P,Q,R,S \vdash (P ∧ Q) ∧ (R ∧ S)
$$

$$
\dfrac{
    \dfrac{
        P \quad Q
    }{P ∧ Q} {\scriptstyle \\{∧I \\}}
    \quad
    \dfrac{
        R \quad S
    }{R ∧ S} {\scriptstyle \\{∧I \\}}
}{(P ∧ Q) ∧ (R ∧ S)} {\scriptstyle \\{∧I \\}}
$$

Exercise 42
-----------
$$
P → R \vdash P ∧ Q → R
$$

$$
\dfrac{
    \dfrac{
        \dfrac{
            \boxed{P ∧ Q}
        }{P} {\scriptstyle \\{ ∧ E_L \\}}
        \quad
        \dfrac{}{P → R}
    } {R} {\scriptstyle \\{ → E \\}}
}{P ∧ Q → R} {\scriptstyle \\{ → I \\}}
$$
Exercise 43
-----------
Use the inference rules to calculate the value of $\mathtt{True} ∨ \mathtt{True}$

First prove the implication that  $\mathtt{True} ∨ \mathtt{True} → \mathtt{True}$
$$
\dfrac{
    \dfrac{
        \dfrac{}{\boxed{\mathtt{True} ∨ \mathtt{True}}}
        \quad
        \dfrac{\boxed{\mathtt{True}}}{\mathtt{True}} {\scriptstyle \\{ ID \\}}
        \dfrac{\boxed{\mathtt{True}}}{\mathtt{True}} {\scriptstyle \\{ ID \\}}
    }{\mathtt{True}} {\scriptstyle \\{ ∨ E \\}}
} {\mathtt{True} ∨ \mathtt{True} → \mathtt{True}} {\scriptstyle \\{ → I \\}}
$$

Next prove the implication that  $\mathtt{True} → \mathtt{True} ∨ \mathtt{True}$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True}}
    } {\mathtt{True} ∨ \mathtt{True}} {\scriptstyle \\{ ∨ I_L \\}}
} {\mathtt{True} → \mathtt{True} ∨ \mathtt{True}} {\scriptstyle \\{ → I \\}}
$$

Therefore, we can conclude that
$\mathtt{True} ∨ \mathtt{True} \leftrightarrow \mathtt{True}$

Exercise 44
-----------
Use the inference rules to calculate the value of $\mathtt{False} → \mathtt{True}$

$$
\dfrac{
    \dfrac{
         \boxed{\mathtt{False}}
    }{\mathtt{False} → \mathtt{False}} {\scriptstyle \\{ → I \\}}
}{(\mathtt{False} → \mathtt{True}) → \mathtt{True}} {\scriptstyle \\{ → I \\}}
$$

$$
\dfrac{
    \dfrac{
        \boxed{\mathtt{True}}
    } {\mathtt{False} → \mathtt{True}} {\scriptstyle \\{ → I \\}}
}{\mathtt{True} → (\mathtt{False} → \mathtt{True})} {\scriptstyle \\{ → I \\}}
$$

Exercise 45
-----------
Suppose that you were given the following code:

> (/\) = (&&)
> (\/) = (||)
> (<=>) = (==)

> False ==> False = True
> False ==> True  = True
> True  ==> False = False
> True  ==> True  = True

> logicExpr1 :: Bool -> Bool -> Bool
> logicExpr1 a b = a /\ b \/ a <=> a

> logicExpr2 :: Bool -> Bool -> Bool
> logicExpr2 a b = (a \/ b) /\ b <=> (a /\ b)

Each of these functions specifies a Boolean expression. What are the truth
values of these expressions? How would you write a list comprehension
that can calculate the values for you to check your work?

First one:

|  a  |  b  | a /\ b \/ a | a /\ b \/ a <=> a |
| :-: | :-: | :---------: | :---------------: |
|  0  |  0  |      0      |         1         |
|  0  |  1  |      0      |         1         |
|  1  |  0  |      1      |         1         |
|  1  |  1  |      1      |         1         |

Comprehension:

> e1 = [(x, y, logicExpr1 x y) | x <- [False, True], y <- [False, True]]

Second one:

|  a  |  b  | (a \/ b) /\ b | (a \/ b) /\ b <=> a /\ b |
| :-: | :-: | :-----------: | :----------------------: |
|  0  |  0  |       0       |            1             |
|  0  |  1  |       1       |            0             |
|  1  |  0  |       0       |            0             |
|  1  |  1  |       1       |            1             |

Comprehension:

> e2 = [(x, y, logicExpr2 x y) | x <- [False, True], y <- [False, True]]

Exercise 46
-----------
Work out the values of these expressions, then check with a list
comprehension:

> logicExpr3 :: Bool -> Bool -> Bool -> Bool
> logicExpr3 a b c
>    = ((a /\ b) \/ (a /\ c)) ==> (a \/ b)

|  a  |  b  |  c  | a /\ b | a /\ c | a \/ b | (a /\ b) \/ (a /\ c) | (a /\ b) \/ (a /\ c) ==> a \/ b |
| :-: | :-: | :-: | :----: | :----: | :----: | :------------------: | :-----------------------------: |
|  0  |  0  |  0  |   0    |   0    |   0    |          0           |                1                |
|  0  |  0  |  1  |   0    |   0    |   0    |          0           |                1                |
|  0  |  1  |  0  |   0    |   0    |   1    |          0           |                1                |
|  0  |  1  |  1  |   0    |   0    |   1    |          0           |                1                |
|  1  |  0  |  0  |   0    |   0    |   1    |          0           |                1                |
|  1  |  0  |  1  |   0    |   1    |   1    |          1           |                1                |
|  1  |  1  |  0  |   1    |   0    |   1    |          1           |                1                |
|  1  |  1  |  1  |   1    |   1    |   1    |          1           |                1                |

> e3 = [(a,b,c, logicExpr3 a b c) | a <- [False, True], b <- [False, True], c <- [False, True]]

> logicExpr4 :: Bool -> Bool -> Bool -> Bool
> logicExpr4 a b c
>     = (a /\ (b \/ c)) \/ (a \/ c) ==> (a \/ c)

|  a  |  b  |  c  | a /\ b | a /\ c | a \/ b | (a /\ b) \/ (a /\ c) | (a /\ b) \/ (a /\ c) ==> a \/ b |
| :-: | :-: | :-: | :----: | :----: | :----: | :------------------: | :-----------------------------: |
|  0  |  0  |  0  |   0    |   0    |   0    |          0           |                1                |
|  0  |  0  |  1  |   0    |   0    |   0    |          0           |                1                |
|  0  |  1  |  0  |   0    |   0    |   1    |          0           |                1                |
|  0  |  1  |  1  |   0    |   0    |   1    |          0           |                1                |
|  1  |  0  |  0  |   0    |   0    |   1    |          0           |                1                |
|  1  |  0  |  1  |   0    |   1    |   1    |          1           |                1                |
|  1  |  1  |  0  |   1    |   0    |   1    |          1           |                1                |
|  1  |  1  |  1  |   1    |   1    |   1    |          1           |                1                |