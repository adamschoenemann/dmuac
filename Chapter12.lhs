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
>     let key (Node k _ _ _) = k
>     in  k > key l && k < key r && ordered l && ordered r
>
> dataElems :: SearchTree d -> Integer -> [d]
> dataElems Leaf _ = []
> dataElems (Node k v l r) key =
>    let continue = dataElems l key ++ dataElems r key
>    in if k == key
>       then v : continue
>       else continue


