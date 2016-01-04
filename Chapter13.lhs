13. Discrete Mathematics in Circuit Design
==========================================

> module Chapter13 where

> class Signal a where
>    zero, one  :: a
>    inv :: a -> a
>    and2, or2, xor :: a -> a -> a

> instance Signal Bool where
>     zero = False
>     one  = True
>     inv False = True
>     inv True  = False
>     and2 = (&&)
>     or2  = (||)
>     xor a b = not (a == b)

Exercise 1
----------
Design a circuit that implements the following truth table:

|  a  |  b  |  c  | f a b c |
| :-: | :-: | :-: | :-----: |
|  0  |  0  |  0  |    1    |
|  0  |  0  |  1  |    1    |
|  0  |  1  |  0  |    0    |
|  0  |  1  |  1  |    0    |
|  1  |  0  |  0  |    0    |
|  1  |  0  |  1  |    1    |
|  1  |  1  |  0  |    1    |
|  1  |  1  |  1  |    1    |

> exercise1 a b c = ex1 || ex2 || ex3 || ex4 || ex5 where
>     ex1 = not a && not b && not c
>     ex2 = not a && not b && c
>     ex3 = a && not b && c
>     ex4 = a && b && not c
>     ex5 = a && b && c

> test1 f = [f False, f True]
> test2 f = [ [x, y,    f x y]   | x <- gen, y <- gen] where gen = [False, True]
> test3 f = [ [x, y, z, f x y z] | x <- gen, y <- gen, z <- gen] where gen = [False, True]

> mux1 a x y = (and2 (inv a) x) `or2` (and2 a y)