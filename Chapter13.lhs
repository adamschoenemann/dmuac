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

13.2.3 Multiplexors
-------------------

> -- multiplexor has a control input a and two data inputs
> mux1 a x y = (and2 (inv a) x) `or2` (and2 a y)

> -- demultiplexor has a single data input and a control input
> demux1 a x = ((inv a) `and2` x, a `and2` x)

Exercise 2
----------
Recall the informal description of the multiplexor: if a is 0 then
the output is x, but if a is 1 then the output is y. Write a truth table that
states this formally, and then use the procedure from Section 13.2.2 to
design a multiplexor circuit. Compare your solution with the definition
of mux1 given above.

|  a  |  x  |  y  | mux1 a x y |
| :-: | :-: | :-: | :--------: |
|  0  |  0  |  0  |     0      |
|  0  |  0  |  1  |     0      |
|  0  |  1  |  0  |     1      |
|  0  |  1  |  1  |     1      |
|  1  |  0  |  0  |     0      |
|  1  |  0  |  1  |     1      |
|  1  |  1  |  0  |     0      |
|  1  |  1  |  1  |     1      |

    mux a x y = r3 || r4 || r6 || r8 where
        r3 = not a && x && not y
        r4 = not a && x && y
        r6 = a && not x && y
        r8 = a && x && y

13.2.4 Bit Arithmetic
---------------------
Half-adder, to produce (carry, sum)

> halfAdd a b = (and2 a b, xor a b)

> bitValue x = if x == zero then 0 else 1

The following theorem says that the half adder circuit produces the correct
result; that is, if we interpret the output (c,s) as a binary number, then this is
actually the sum of the numeric values of the inputs.
Theorem 106
-----------
    Let (c,s) = halfAdd a b. Then
    2 × bitValue c + bitValue s = bitValue a + bitValue b.

Proof. This theorem is easily proved by checking the equation for each of the
four possible combinations of input values. This is essentially the same as
using Haskell to simulate the circuit for all the input combinations; the only
difference is notational. The details of this proof are left to you to work out.
For larger circuits, correctness proofs are not at all like simulators. We will see
the difference later in this chapter.

In order to add words representing binary numbers, it will be necessary to
add three bits: one data bit from each of the words, and a carry input bit.
This function is provided by the full adder circuit as with the
half adder, there is a two-bit result $(c', s)$, where $c'$ is the carry 
output and s is the sum.

|  a  |  b  |  c  |  c' |  s  |
| :-: | :-: | :-: | :-: | :-: |
|  0  |  0  |  0  |  0  |  0  |
|  0  |  0  |  1  |  0  |  1  |
|  0  |  1  |  0  |  0  |  1  |
|  0  |  1  |  1  |  1  |  0  |
|  1  |  0  |  0  |  0  |  1  |
|  1  |  0  |  1  |  1  |  0  |
|  1  |  1  |  0  |  1  |  0  |
|  1  |  1  |  1  |  1  |  1  |

> fullAdd (a, b) c =
>    let (c',  s ) = halfAdd a b
>        (c'', s') = halfAdd c s
>     in (c'' `or2` c', s')
