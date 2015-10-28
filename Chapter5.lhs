> import Control.Applicative ((<$>), (<*>))

Chapter 5 (Trees)
================
Simple Int Binary Search Tree

> data BinTreeInt
>       = Leaf
>       | Node Integer BinTreeInt BinTreeInt

Example tree

> tree :: BinTreeInt
> tree = 
>   Node 4
>     (Node 2
>         (Node 1 Leaf Leaf)
>         (Node 3 Leaf Leaf))
>     (Node 7
>         (Node 5
>             Leaf
>             (Node 6 Leaf Leaf))
>         (Node 8 Leaf Leaf))

Polymorphic tree

> data BinTree a
>       = BinLeaf
>       | BinNode a (BinTree a) (BinTree a)
>       deriving Show

Example tree

> tree2 :: BinTree Int
> tree2 = 
>       BinNode 4
>           (BinNode 2
>               (BinNode 1 BinLeaf BinLeaf)
>               (BinNode 3 BinLeaf BinLeaf))
>           (BinNode 6
>               (BinNode 5 BinLeaf BinLeaf)
>               (BinNode 7 BinLeaf BinLeaf))

Exercise 1
----------
Define a Haskell datatype `Tree1` for a tree that contains 
a character and an integer in each node, along with exactly
three subtrees

> data Tree1
>       = Tree1Leaf
>       | Tree1Node (Char, Integer) Tree1 Tree1 Tree1

Exercise 2
----------
Define a Haskell datatype `Tree2` for a tree that contains
an integer in each node, and that allows each node to have any number
of subtrees.

> data Tree2
>       = Tree2Leaf
>       | Tree2Node Integer [Tree2]

5.3 Processing Trees with Recursion
===================================
Traversing trees with three different algorithms

> inorder :: BinTree a -> [a]
> inorder BinLeaf = []
> inorder (BinNode x l r) = inorder l ++ [x] ++ inorder r

> preorder :: BinTree a -> [a]
> preorder BinLeaf = []
> preorder (BinNode x l r) = [x] ++ preorder l ++ preorder r

> postorder :: BinTree a -> [a]
> postorder BinLeaf = []
> postorder (BinNode x l r) = postorder l ++ postorder r ++ [x] 

Exercise 3
----------
Calculate the inorder traversal of `tree2`

    tree2 = 
          BinNode 4
              (BinNode 2
                  (BinNode 1 BinLeaf BinLeaf)
                  (BinNode 3 BinLeaf BinLeaf))
              (BinNode 6
                  (BinNode 5 BinLeaf BinLeaf)
                  (BinNode 7 BinLeaf BinLeaf))

      inorder tree2
    = inorder (BinNode 4 l r)
    = inorder l ++ [4] ++ inorder r
    = (inorder l ++ [2] ++ inorder r) ++ [4] ++ (inorder l ++ [6] ++ inorder r)
    = ([1] ++ [2] ++ [3]) ++ [4] ++ ([5] ++ [6] ++ [7])
    = [1,2,3,4,5,6,7]

Exercise 4
----------
Suppose that a tree has type `BinTree a`, and we have a function
`f :: a -> b`. Write a new traversal function
`inorderf :: (a -> b) -> BinTree a -> [b]` that traverses the tree
using inorder, but applies `f` to the data value in each node
before placing theresult in the list.
For example, `inorder tree2` produces `[1,2,3,4,5,6,7]` but 
`inorderf (2*) tree6` produces `[2,4,6,8,10,12,14]`.

> inorderf :: (a -> b) -> BinTree a -> [b]
> inorderf _ BinLeaf = []
> inorderf f (BinNode x l r) = inorderf f l ++ [f x] ++ inorderf f r

5.3.2 Processing Tree Structure
-------------------------------
The `reflect` function takes a binary tree and returns its mirror image
where everything is reversed left-to-right

> reflect :: BinTree a -> BinTree a
> reflect BinLeaf = BinLeaf
> reflect (BinNode x l r) = BinNode x (reflect r) (reflect l)

The height of a tree is the distance between its root and its deepest leaf. An
empty tree, consisting only of a leaf, has height 0. The height of a nonempty
tree is the height of its taller subtree, plus one to account for the root node

> height :: BinTree a -> Integer
> height BinLeaf = 0
> height (BinNode x l r) = 1 + max (height l) (height r)

The size of a tree is the number of nodes that it contains. This is measured
simply by adding up the sizes of the subtrees, plus one for the root node.

> size :: BinTree a -> Integer
> size BinLeaf = 0
> size (BinNode x l r) = 1 + size l + size r

A tree with data distributed evenly through the tree is said to be *balanced*.

> balanced :: BinTree a -> Bool
> balanced BinLeaf = True
> balanced (BinNode x l r) = balanced l && balanced r && (height r == height l)

Exercise 5
----------
Define two trees of size seven, one with the largest possible height
and the other with the smalles possible height

> highTree :: BinTree Integer
> highTree =
>       BinNode 1
>           BinLeaf
>           (BinNode 2
>               BinLeaf
>               (BinNode 3
>                   BinLeaf
>                   (BinNode 4
>                       BinLeaf
>                       (BinNode 5
>                           BinLeaf
>                           (BinNode 6
>                               BinLeaf
>                               (BinNode 7 
>                                   BinLeaf
>                                   BinLeaf))))))
>
> balancedTree :: BinTree Integer
> balancedTree =
>       BinNode 1
>           (BinNode 2
>               (BinNode 3 BinLeaf BinLeaf)
>               (BinNode 4 BinLeaf BinLeaf))
>           (BinNode 5
>               (BinNode 6 BinLeaf BinLeaf)
>               (BinNode 7 BinLeaf BinLeaf))

Exercise 6
----------
Suppose that the last equation of the function balanced were
changed to the following:
`balanced (BinNode x l r) = balanced l && balanced r`.
Give an example showing that the modified func-
tion returns True for an unbalanced tree.

> unbalancedTree = 
>       BinNode 1
>           (BinNode 2 BinLeaf BinLeaf)
>           BinLeaf

      balanced unbalancedTree
    = balanced (BinNode 1 l r)
    = balanced l && balanced r
    = balanced (BinNode 2 BinLeaf BinLeaf) && balanced BinLeaf
    = (balanced BinLeaf && balanced BinLeaf) && True
    = (True && True) && True
    = True
  
Exercise 7
----------
Suppose that the last equation of the function balanced were
changed to the following:
`balanced (BinNode x l r) = height l == height r`.
Give an example showing that the modified function
returns `True` for an unbalanced tree.

> unbalancedTree2 = 
>       BinNode 1
>           (BinNode 2
>               (BinNode 3 
>                   (BinNode 8 BinLeaf BinLeaf)
>                   BinLeaf)
>               (BinNode 4 BinLeaf BinLeaf))
>           (BinNode 5
>               (BinNode 6
>                   BinLeaf
>                   (BinNode 7 BinLeaf BinLeaf))
>               BinLeaf)

      balanced unbalancedTree2
    = balanced (BinNode 1 l r)
    = height l == height r
    = height (BinNode 2 l r) == height (BinNode 5 l2 r2)
    = 1 + max (height l) (height r) == 1 + max (height l2) (height r2)
    = 1 + max 2 1 == 1 + max (height l2) (height BinLeaf)
    = 3 == 1 + max (height l2) 0
    = 3 == 1 + height l2
    = 3 == 1 + height (BinNode 6 BinLeaf r)
    = 3 == 1 + 1 + height r
    = 3 == 1 + 1 + 1
    = 3 == 3

Exercise 8
----------
Define a function mapTree that takes a function and applies it to
every node in the tree, returning a new tree of results. The type should
be `mapTree :: (a->b) -> BinTree a -> BinTree b`.
This function is analogous to map, which operates over lists.

> mapTree :: (a -> b) -> BinTree a -> BinTree b
> mapTree _ BinLeaf = BinLeaf
> mapTree f (BinNode x l r) = BinNode (f x) (mapTree f l) (mapTree f r)

Exercise 9
----------
Write `concatTree`, a function that takes a tree of lists 
and concatenates the lists i norder from left to right. For example,

    concatTree (Node [2] (Node [3,4] Tip Tip)
                         (Node [5] Tip Tip))
        ==> [3,4,2,5]

> concatTree :: BinTree [a] -> [a]
> concatTree BinLeaf = []
> concatTree (BinNode xs l r) = concatTree l ++ xs ++ concatTree r

Exercise 10
-----------
Write zipTree, a function that takes two trees and pairs each of
the corresponding elements in a list. Your function should return Nothing
if the two trees do not have the same shape. For example,
    
    zipTree (Node 2 (Node 1 Tip Tip) (Node 3 Tip Tip))
            (Node 5 (Node 4 Tip Tip) (Node 6 Tip Tip))
    ==> Just [(1,4),(2,5),(3,6)]
    

> zipTree :: BinTree a -> BinTree b -> Maybe [(a,b)]
> zipTree BinLeaf BinLeaf = Just []
> zipTree (BinNode _ _ _) BinLeaf = Nothing
> zipTree BinLeaf (BinNode _ _ _) = Nothing
> zipTree (BinNode x l r) (BinNode y l' r') = 
>       (++) <$> ((++) <$> left <*> node) <*> right
>           where
>               left = zipTree l l'
>               node = Just [(x,y)]
>               right = zipTree r r'

Exercise 11
-----------
Write zipWithTree, a function that is like zipWith except that
it takes trees instead of lists. The first argument is a function of type
`a -> b -> c`, the second argument is a tree with elements of type a, and the
third argument is a tree with elements of type b. The function returns a
list with type `[c]`.

> zipWithTree :: (a -> b -> c) -> BinTree a -> BinTree b -> Maybe [c]
> zipWithTree _ BinLeaf BinLeaf = Just []
> zipWithTree _ BinLeaf (BinNode _ _ _) = Nothing
> zipWithTree _ (BinNode _ _ _) BinLeaf = Nothing
> zipWithTree f (BinNode x l r) (BinNode y l' r') =
>       (++) <$> ((++) <$> left <*> node) <*> right
>           where
>               left = zipWithTree f l l'
>               node = Just [f x y]
>               right = zipWithTree f r r'

5.4 Induction on Trees
======================
Recall the reflect function, which reverses the order of the data in a binary
tree. The following theorem says that if you reflect a tree twice, you get the
same tree back.

Theorem 29
----------
l `t :: BinTree a`. Then `reflect (reflect t) = t`.  
*Proof*. The proposition $P(t)$ that we need to prove says `reflect (reflect t) = t`.
The theorem is proved by indution over `t`. The base case is `BinLeaf`

      reflect (reflect BinLeaf)
    = reflect (BinLeaf)             { reflect.1 }
    = BinLeaf                       { reflect.1 }
                                    ☐ 

For the inductive case, let `t1, t2 :: BinTree a` be trees, and assume
$P(t1)$ and $P(t2)$. These are the inductive hypotheses. The aim is prove that the
proposition holds for a larger tree $P($`Node x t1 t2`$)$

      reflect (reflect (Node x t1 t2))
    = reflect (Node x (reflect t2) (reflect t1))                 { reflect.2 }
    = Node x (reflect (reflect t1)) (reflect (reflect t2))       { reflect.2 }
    = Node x t1 t2                                               { hypothesis }
                                        ☐ 

5.4.2 Reflection and Reversing
==============================
Reflecting a tree changes the order of data values, in a similar way to the
reversal of a list. It seems that reflect and reverse are somehow doing the
same thing, but these functions are definitely not equal.

To state precisely the relationship between reflecting a tree and reversing a
list, we need to use an explicit translation between trees and lists. The `inorder`
function is exactly what we need.

Theorem 30
----------
Let `t :: BinTree a` be an arbitrary binary tree of finite size.
Then `inorder (reflect t) = reverse (inorder t)`.

The proof requires two lemmas that describe properties of `reverse`
and `(++)`. We leave the proofs of the lemmas as an exercise

    lemma 1 := reverse xs ++ [x] = reverse ([x] ++ xs)
    lemma 2 := reverse (xs ++ ys) = reverse ys ++ reverse xs

*Proof*. Start with the base case

      inorder (reflect BinLeaf)
    = inorder BinLeaf               { reflect.1 }
    = []                            { inorder.1 }
    = inorder BinLeaf               { inorder.1 }
    = reverse (inorder BinLeaf)     { reverse.1 }
                                    ☐ 
                                    
Induction case. Let `t1, t2 :: BinTree a` be arbitrary trees, and let
`x :: a` be an arbitrar data value. Assume the inductive hypotheses.

    inorder (reflect t1) = reverse (inorder t1)
    inorder (reflect t2) = reverse (inorder t2)

Then

      inorder (reflect (Node x t1 t2))
    = inorder (Node x (reflect t2) (reflect t1))            { reflect.2 }
    = inorder (reflect t2) ++ [x] ++ inorder (reflect t1)   { inorder.2 }
    = reverse (inorder t2) ++ [x] ++ reverse (inorder t1)   { hypotheses }
    = reverse ([x] ++ inorder t2) ++ reverse (inorder t1)   { lemma 1 }
    = reverse (inorder t1 ++ [x] ++ inorder t2)             { lemma 2 }
    = reverse (inorder (BinNode x t1 t2))                   { inorder.1 }
                                                            ☐ 

5.4.3 The Height of a Balanced Tree
===================================
If a binary tree is balanced then its shape is determined, and the number of
nodes is determined by the height. The following theorem states this relation-
ship precisely.

Theorem 31
----------
Let $h = \mathtt{height}\ t$. If $\mathtt{balanced}\ t$, then $\mathtt{size}\ t =2^h − 1$.

*Proof*. The proposition we want to prove is
$\mathtt{balanced}\ t \rightarrow \mathtt{size}\ t = 2^h - 1$
The proof is an induction over the tree structure. For the base case, we need
to prove that the theorem holds for a leaf.

    balanced BinLeaf = True
    h = height BinLeaf = 0
    size BinLeaf = 0
    0 = 2^h - 1
      = 2^0 - 1
      = 1 - 1
      = 0

For the inductive case, let $t = \mathtt{Node\ x\ l\ r}$ and let $hl = \mathtt{height\ l}$
and $hr = \mathtt{height\ r}$.
Assume $P(\mathtt{l})$ and $P(\mathtt{r})$; the aim is to prove $P(t)$. There are two
cases to consider. If $t$ is not balanced, then the implication
$\mathtt{balanced}\ t \rightarrow P(t)$ is vacuously (i.e. maybe) true.
If $t$ is balanced, however, then the implication is true if and only if $P(t)$
is true. Therefore we need to prove $P(t)$ given the following three assumptions:
(1) $P(\mathtt{l})$ (inductive hypothesis), (2) $P(\mathtt{r})$ (inductive hypothesis),
and $\mathtt{balanced}\ t$ (premise of implication to be proved)

    h = height (Node x l r)
      = 1 + max (height l) (height r)           { height.2 }
      = 1 + height l                            { assumption }
      = 1 + hl                                  { def hl }
    size t
      = size (Node x l r)
      = 1 + size l + size r                     { size.2 }
      = 1 + 2^hl - 1 + 2^hr - 1                 { hypothesis }
      = 2^hl + 2^hr - 1                         { arithmetic }
      = 2^hl  + 2^hl - 1                        { hr = hl (because balanced)}
      = 2 * 2^hl - 1                            { algebra }
      = 2^(hl + 1) - 1                          { algebra }
      = 2^h - 1                                 { def h }

The base and inductive cases have been proved, so the theorem holds by
the principle of tree induction.

5.4.4 Length of a Flattened Tree
================================
The following theorem says that if you faltten a tree, then the length
of the resulting list is the same as the number of nodes in tree.

Theorem 32
----------
Let `t :: BinTree a` be any finite binary tree.
then `length (inorder t) = size t`

*Proof*. The proof is a tree induction over `t`.
Base case:

      length (inorder BinLeaf)
    = length []                 { inorder.1 }
    = 0                         { length.1 }
    = size BinLeaf              { size.1 }

Induction case. Assume the induction hypotheses:

    length (inorder t1) = size t1
    length (inorder t2) = size t2

And the following lemma
    
    lemma 3 := length (xs ++ ys)= length xs + length ys

Then

      length (inorder (BinNode x t1 t2))
    = length (inorder t1 ++ [x] ++ inorder t2)                  { inorder.2 }
    = length (inorder t1) + length [x] + length (inorder t2)    { lemma 3 }
    = size t1 + length [x] + size t2                            { hypotheses }
    = size t1 + 1 + size t2                                     { length.2 }
    = size (BinNode x t1 t2)                                    { size.2 }
    
Exercises
=========

Exercise 12
-----------
Write `appendTree`, a function that takes a binary tree and a
list, and appends the contents of the tree (traversed from left to right) to
the front of the list. For example,

    appendTree (BinNode 2 (BinNode 1 BinLeaf BinLeaf)
                          (BinNode 3 BinLeaf BinLeaf))
               [4,5]

evaluates to `[1,2,3,4,5]`. Try to find an efficient solution that minimises
recopying.

> appendTree :: BinTree a -> [a] -> [a]
> appendTree BinLeaf xs = xs
> appendTree (BinNode x l r) xs = appendTree l (x : appendTree r xs)