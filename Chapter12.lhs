> module Chapter12 where

12. The AVL Tree Miracle
========================
What this describes is just a Binary Search Tree, indexed on integers
with a payload

> data SearchTree d = Leaf | Node Integer d (SearchTree d) (SearchTree d)
>
> instance Eq (SearchTree d) where
>    Leaf           == Leaf               = True
>    (Node _ _ _ _) == Leaf               = False
>    Leaf           == (Node _ _ _ _)     = False
>    (Node k v l r) == (Node k' v' l' r') =
>        k == k && l == l && r == r
>
> subtree :: SearchTree d -> SearchTree d -> Bool
> subtree Leaf Leaf = True
> subtree (Node _ _ _ _) Leaf = False
> subtree Leaf (Node _ _ _ _) = True
> subtree x@(Node _ _ _ _) y@(Node _ _ yl yr) =
>     x == y || x `subtree` yl || x `subtree` yr
>
> (⊆) :: SearchTree d -> SearchTree d -> Bool
> (⊆) = subtree
>
> properSubtree :: SearchTree d -> SearchTree d -> Bool
> properSubtree s Leaf = False
> properSubtree s (Node k v l r) = s `subtree` l || s `subtree` r
>
> (⊂) :: SearchTree d -> SearchTree d -> Bool
> (⊂) = properSubtree
>
> inTree :: Integer -> SearchTree d -> Bool
> inTree key (Node k _ l r) =
>     key == k || key `inTree` l || key `inTree` r
>
> (∈) :: Integer -> SearchTree d -> Bool
> (∈) = inTree
>
> ordered :: SearchTree d -> Bool
> ordered Leaf = True
> ordered (Node k _ l r) =
>     let compare cmp (Node k' _ _ _) = cmp k'
>         compare _ Leaf = True
>     in  compare (k >) l && compare (k <) r && ordered l && ordered r
>
> dataElems :: SearchTree d -> Integer -> [d]
> dataElems Leaf _ = []
> dataElems (Node k v l r) key =
>    let continue = dataElems l key ++ dataElems r key
>    in if k == key
>       then v : continue
>       else continue

The following theorems state that, in an ordered tree, if a key `k` is
in a tree $s$, then `length` of `dataElems s k` is 1.
If `k` is not in $s$, then  `dataElems s k == []`

Theorem 81
----------
(unique keys, part 1)
$$
∀s. (ordered\ (s) ∧ k ∈ s) → (\mathtt{length}\ (\mathtt{dataElems}\ s\ \mathtt{k}) == 1)
$$

Theorem 82
----------
(unique keys, part 2)
$$
∀s. (ordered\ (s) ∧ k ∉ s) → ((\mathtt{dataElems}\ s\ \mathtt{k}) == [])
$$

To prove t82, we will use a new form of induction called **tree induction**.

Principle of Tree Induction
---------------------------
$$
(∀t. (∀s ⊂ t. P(s)) → P(t)) → (∀t. P(t))
$$
This says, that if the predicate $P$ is true for every proper subtree of a particular, chosen
tree, then it must also be true for the chosen tree. The implication must be
proved for an arbitrarily chosen tree, but once this implication is proved, the
principle of tree induction delivers the conclusion that the predicate is true for
every search tree.

*Proof*. of Theorem 82 (unique keys, part 2):  
$∀s. (ordered\ (s) ∧ k ∉ s) → ((\mathtt{dataElems}\ s\ \mathtt{k}) == [])$

Proof by tree induction.

Base Case.

$$
\begin{array}
(ordered\ (\mathtt{Leaf}) ∧ k ∉ \mathtt{Leaf}) → ((\mathtt{dataElems\ Leaf\ k}) == []) & \\\
    \quad = \\{ord N, ∈ N\\} & \\\
(\mathtt{False} ∧ \mathtt{False} → ((\mathtt{dataElems\ Leaf\ k}) == [])) & \\\
    \quad = \\{∧\ idem \\} & \\\
\mathtt{False} → ((\mathtt{dataElems\ Leaf\ k}) == []) & \\\
    \quad = \\{\mathtt{False} → any = True \\} & \\\
\mathtt{True}
\end{array}
$$

First, we work with just the hypothesis of the implication we’re trying to
prove.
$$
\begin{array}
(ordered (\mathtt{Node\ x\ a\ lf\ rt)} ∧ k ∉ (\mathtt{Node\ x\ a\ lf\ rt)}) & \\\
    \quad = \\{∈ C\\} & \\\
(ordered (\mathtt{Node\ x\ a\ lf\ rt)} ∧ ¬(x = k ∨ k ∈ lf ∨ k ∈ rt)) & \\\
    \quad = \\{DM\\} & \\\
(ordered (\mathtt{Node\ x\ a\ lf\ rt)} ∧ (x =\not k) ∧ (k ∉ lf) ∨ (k ∉ rt))
\end{array}
$$

We are trying to prove that when the above formula is true, the formula in
the conclusion of the theorem is also true. That is, we want to prove that the
dataElems function delivers an empty sequence in this case.

$$
\begin{array}
\mathtt{dataElems}\ (\mathtt{Node\ x\ a\ lf\ rt})\ k \\\
    = \\{\mathtt{dataElems}\ C,x ≠ k\\} \\\
(\mathtt{dataElems\ lf\ k) ++\ (dataElems\ rt\ k)} \\\
    = \\{ord\ C,k ∉ lf,\text{induction hypothesis, applied twice}\\} \\\
[] ⧺ [] \\\
    = \\{⧺ []\\} \\\
[]
\end{array}
$$

The induction step in the proof occurred when we observed that with respect
to the formula (dataElems lf k), the hypotheses of the theorem are true. That
is, the tree lf is ordered (by the definition of ordered, since lf is a subtree of
an ordered tree) and the key k does not occur in that tree. As lf is a proper
subtree of the tree we started with, the principle of induction allows us to
assume that the theorem is true for the tree lf. (Remember, induction doesn’t
require a direct proof in the inductive case. It only requires that you prove
an implication whose hypothesis is that the theorem is true for every proper
subtree of the one you started with.) In this case, we apply the induction
hypothesis twice: once for the left subtree and again for the right subtree.

12.5.2 Retrieving Data from a Search Tree
=========================================
Since a given key in an ordered search tree appears only once, we can
search for a value associated with a key in the search tree. The result
is a `Maybe` value of `Just x` if the key was found, or `Nothing` if
it was not persent.

> getItem :: SearchTree d -> Integer -> Maybe d
> getItem Leaf _ = Nothing
> getItem (Node k v l r) key =
>    if k == key
>    then Just v
>    else if key < key
>    then getItem l key
>    else getItem r key