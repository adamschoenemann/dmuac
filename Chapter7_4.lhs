7.4 Algebraic Laws of Predicate Logic
=====================================
The following two laws express, in algebraic form,
the $\\{ ∀E \\}$ and $\\{ ∃ I \\}$ inference rules.
As they correspond to inference rules, these laws are
logical implications, not equations

$$
\begin{align}
∀x. f(x) & → f(c)     & (7.3)\\\
f(c)     & → ∃x. f(x) & (7.4)
\end{align}
$$

$c$ must, of course, be *arbitrary*.

The following theorem combines these two laws and is often useful
in proving other theorems. Its proof use the line-by-line style,
which is standard when reasoning about predicate logic with
algebraic laws.

Theorem 67
----------
$∀x. f(x) → ∃x. f(x)$

*Proof*  
$$
\begin{align}
& ∀x. f(x) \\\
& \quad → f(c)    \\\
& \quad → ∃x. f(x)
\end{align}
$$

The next two laws state how the quantifiers combien with negation.
The first one says that if $f(x)$ is always false, then it is never
true; the second says that if $f(x)$ is ever untrue, then it is not
always true.

$$
\begin{align}
∀x. ¬f(x) & = ¬∃x. f(x) & (7.5) \\\
∃x. ¬f(x) & = ¬∀x. f(x) & (7.6)
\end{align}
$$

The following four laws show how a predicate $f(x)$ combines
with a proposition $q$ that does not contain $x$. These are
useful for bringing constant terms int oor out of quantified
expressions.

$$
\begin{align}
(∀x. f(x)) ∧ q & = ∀x. (f(x) ∧ q) & (7.7) \\\
(∀x. f(x)) ∨ q & = ∀x. (f(x) ∨ q) & (7.8) \\\
(∃x. f(x)) ∧ q & = ∃x. (f(x) ∧ q) & (7.9) \\\
(∃x. f(x)) ∨ q & = ∃x. (f(x) ∨ q) & (7.10)
\end{align}
$$

The final group of laws concerns the combination of quantifiers
with $∧$ and $∨$. It is important to note that two of them are
equations (or double implications), whereas the other two are 
implications. Therefore they can be used in only one direction,
and they must be used at the top level, not on subexpressions.

$$
\begin{align}
∀x. f(x) ∧ ∀x. g(x) & = ∀x. (f(x) ∧ g(x))   & (7.11)  \\\
∀x. f(x) ∨ ∀x. g(x) & → ∀x. (f(x) ∨ g(x))   & (7.12)  \\\
∃x. (f(x) ∧ g(x))   & → ∃x. f(x) ∧ ∃x. g(x) & (7.13)  \\\
∃x. f(x) ∨ ∃x. g(x) & = ∃x. (f(x) ∨ g(x))   & (7.14) 
\end{align}
$$

Example 9
---------
The following equation can be proved algebraically:
$$
∀x. (f(x) ∧ ¬g(x)) = ∀x. f(x) ∧ ¬∃x. g(x)
$$

This is established through a sequence of steps. Each step should
be justified by one of the algebraic laws, or by another equation
that has already been proved. When the purpose is actually to prove
a theorem, the justifications should be written explicitly.
Often this kind of reasoning is used informally, like a straight-
forward algebraic calculation, and the formal jusitications are
sometimes omitted.

$$
\begin{align}
& ∀x. (f(x) ∧ ¬g(x))    & \\\
& ∀x. f(x)  ∧ ∀x. ¬g(x) & \\{ 7.11  \\} \\\
& ∀x. f(x)  ∧ ¬∃x. g(x) & \\{ 7.5   \\}
\end{align}
$$

Example 10
----------
The following equation says that if $f(x)$ sometimes implies
$g(x)$, and $f(x)$ is always true, then $g(x)$ is sometimes true.

$$
∃x. (f(x) → g(x)) ∧ (∀x. f(x)) → ∃x. g(x)
$$

The first step of the proof replaces the local variable $x$ by
$y$ in the $∀$ expression. This is not actually necessary,
but it may help to avoid confusion; whenever the same
variable is playing different roles in different expressions,
and there seems to be a danger of getting them mixed up,
it is safest just to change the local variable. In the next
step, the $∀$ expression is brought inside the $∃$; in the
following step it is now possible to pick a particular value for $y$:
namely, the $x$ bound by $∃$.

$$
\begin{align}
  & ∃x. (f(x) → g(x)) ∧ (∀x. f(x))   & \\\
= & ∃x. (f(x) → g(x)) ∧ (∀y. f(y))   & \text{change of variable} \\\
= & ∃x. ((f(x) → g(x)) ∧ (∀y. f(y))) & \\{7.9 \\} \\\
= & ∃x. ((f(x) → g(x)) ∧ f(x))       & \\{7.3 \\} \\\
→ & ∃x. g(x)                         & \\{\textit{Modus Ponens} \\}
\end{align}
$$