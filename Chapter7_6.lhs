7.6 Review Exercises
====================

Exercise 13
-----------
Suppose the universe contains 10 elements. How many times
will $F$ occur when $∀x. ∃y. ∀z. F(x,y,z)$ is expanded into
quantifier-free form? How large in general are expanded expressions.

$F$ occur $10 × 10 × 10 = 10^3 = 1000$ times.

In general, expanded expressions become $n^k$ of length,
where $n = \text{n elems in universe}$ and $k = \text{number of nested expressions}$

Exercise 14
-----------
Prove $(∃x. f(x)) ∨ (∃x. g(x)) ⊢ ∃x. (f(x) ∨ g(x))$

*Proof*.
$$
\dfrac{
    \dfrac{
        \dfrac{}{(∃x. f(x)) ∨ (∃x. g(x))}
        \quad
        \dfrac{
            \dfrac{
                \boxed{\dfrac{}{∃x. f(x)}}
                \quad
                \dfrac{\boxed{f(p)}}{f(p)} {\scriptstyle \\{ ID \\}}
            } {f(p)}        {\scriptstyle \\{ ∃ E   \\}}
        } {f(p) ∨ g(p)}     {\scriptstyle \\{ ∨ I_L \\}}
        \quad
        \dfrac{
            \dfrac{
                \boxed{\dfrac{}{∃x. g(x)}}
                \quad
                \dfrac{\boxed{g(p)}}{g(p)} {\scriptstyle \\{ ID \\}}
            } {g(p)}        {\scriptstyle \\{ ∃ E   \\}}
        } {f(p) ∨ g(p)}     {\scriptstyle \\{ ∨ I_R \\}}
    } {f(p) ∨ g(p)}   {\scriptstyle \\{ ∨ E \\}}
} {∃x. (f(x) ∨ g(x))} {\scriptstyle \\{ ∃ I \\}}
$$

Exercise 15
-----------
Prove $(∀x. f(x)) ∨ (∀x. g(x)) ⊢ ∀x. (f(x) ∨ g(x))$

*Proof*.
$$
\dfrac{
    \dfrac{
        \dfrac{}{(∀x. f(x)) ∨ (∀x. g(x))}
        \quad
        \dfrac{
            \dfrac{
                \boxed{∀x. f(x)}
            }{f(x)}         {\scriptstyle \\{ ∀ E \\}}
        }{f(x) ∨ g(x)}      {\scriptstyle \\{ ∨ I_L \\}}
        \quad
        \dfrac{
            \dfrac{
                \boxed{∀x. g(x)}
            }{g(x)}         {\scriptstyle \\{ ∀ E \\}}
        }{f(x) ∨ g(x)}      {\scriptstyle \\{ ∨ I_R \\}}
    }{f(x) ∨ g(x)}          {\scriptstyle \\{ ∨ E \\}}
}{∀x. (f(x) ∨ g(x))}        {\scriptstyle \\{ ∀ I \\}}
$$
Exercise 16
-----------
Prove the converse of Theorem 63.

$P → ∀x. f(x) ⊢ ∀x. (P → f(x))$

$$
\dfrac{
    \dfrac{
        \dfrac{
            \dfrac{
                \boxed{P}
                \quad
                P → ∀x. f(x)
            }{∀x. f(x)}     {\scriptstyle \\{ → E \\}}
        }{f(q)}             {\scriptstyle \\{ ∀ E \\}}
    } {P → f(q)}            {\scriptstyle \\{ → I \\}}
}{∀x. (P → f(x))}           {\scriptstyle \\{ ∀ I \\}}
$$

Exercise 17
-----------
Find counterexamples that show that Laws 7.12 and 7.13, which
are implications, would not be valid as equations.

If $U = \\{1,2\\}$ and $f(x) ≡ x = 1$ and $g(x) ≡ x = 2$,
then the left side of 7.12 would expand as follows:

$$
\begin{align}
  & (1 = 1 ∧ 1 = 2) ∨ (1 = 2 ∧ 2 = 2) \\\
= & (True ∧ False) ∨ (False ∧ True) \\\
= & False ∨ False \\\
= & False
\end{align}
$$

yet the right hand side would be

$$
\begin{align}
  & ((1 = 1) ∨ (1 = 2)) ∧ ((2 = 1) ∨ (2 = 2)) \\\
= & (True ∨ False) ∧ (False ∨ True) \\\
= & True ∧ True \\\
= & True
\end{align}
$$

So the two are *not* equal.

For 7.13, the left side would expand to

$$
\begin{align}
  & ((1 = 1) ∧ (1 = 2)) ∨ ((2 = 1) ∧ (2 = 1)) \\\
= & (True ∧ False) ∨ (False ∧ True) \\\
= & False ∨ False \\\
= & False
\end{align}
$$

while the right side would be

$$
\begin{align}
  & ((1 = 1) ∨ (2 = 1)) ∧ ((1 = 2) ∨ (2 = 2)) \\\
= & (True ∨ False) ∧ (False ∨ True) \\\
= & True ∧ True \\\
= & True
\end{align}
$$

So the two are *not* equal.


Exercise 18
-----------
Prove the following implication:
$$
(∀x. f(x) → h(x) ∧ ∀x. g(x) → h(x)) \\\
→ ∀x. (f(x) ∨ g(x) → h(x))
$$
    
!!!TODO:!!
$$
\begin{align}
& (∀x. f(x) → h(x) ∧ ∀x. g(x) → h(x)) & \\\
& = ∀x. (f(x) → h(x) ∧ g(x) → h(x))     & \\{7.11\\} \\\
\end{align}
$$

Exercise 19
-----------
Define a predicate (with the natural numbers 0,1,2,... as its universe)
that expresses the notion that all of the elements that occur in either
of the sequences supplied as operands to the append operator (⧺) also
occur as elements of the sequence it delivers. That is, the predicate states
that under certain constraints on the number of elements in the sequence
`xs`, any element that occurs in either the sequence `xs` or the sequence
`ys` also occurs in the sequence `xs ++ ys`. Hint: Take
"x *occurs in* xs" to mean 
`∃.y ∃ys. (xs = (y : ys) ∧ (x = y) ∨ (x occurs in ys))`.
That is, the proposition "x occurs in xs" always has the same value as the
proposition `∃.y ∃ys. (xs = (y : ys) ∧ (x = y) ∨ (x occurs in ys))`.
Denote the predicate "x occurs in xs" by the forumate "x ∈ xs" (overloading
the ∈ symbol used to denote set membership)