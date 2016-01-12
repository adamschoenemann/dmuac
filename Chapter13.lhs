13. Discrete Mathematics in Circuit Design
==========================================

> module Chapter13 where

> class Signal a where
>    zero, one  :: a
>    inv :: a -> a
>    and2, or2, xor :: a -> a -> a
>    and3 :: a -> a -> a -> a

> instance Signal Bool where
>     zero = False
>     one  = True
>     inv False = True
>     inv True  = False
>     and2 = (&&)
>     and3 x y z = x && y && z
>     or2  = (||)
>     xor a b = not (a == b)

> instance Signal Int where
>     zero = 0
>     one  = 1
>     inv 0 = 1
>     inv 1 = 0
>     and2 x y = if x == 1 && y == 1 then 1 else 0
>     and3 x y z = if all (== 1) [x,y,z] then 1 else 0
>     or2  x y = if x == 1 || y == 1 then 1 else 0
>     xor  x y = if x == y then 0 else 1

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
> demux1 s x = ((inv s) `and2` x, s `and2` x)

| a | x | demux1 a x |
| 0 | 0 | (0,0)      |
| 0 | 1 | (1,0)      |
| 1 | 0 | (0,0)      |
| 1 | 1 | (0,1)      |

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

Theorem 107 (Correctness of full adder).
----------------------------------------
Let $(c' ,s) = fullAdd\ (a,b) c$, so that $c'$ is the carry output
and $s$ is the sum output.
Then $bitValue\ c' × 2 + bitValue\ s = bitValue\ a + bitValue\ b + bitValue\ c$.

Exercise 3
----------
Use Haskell to test the half adder on the following test cases, and check
that it procduces the correct results.

    Test cases for half adder, with predicted results
    halfAdd False False -- 0 0
    halfAdd False True  -- 0 1
    halfAdd True False  -- 1 0
    halfAdd True True   -- 1 1

Exercise 4
----------
Prove Theorem 106 using truth tables.

|  a  |  b  |  c  |  s  |
| :-: | :-: | :-: | :-: |
|  0  |  0  |  0  |  0  |
|  0  |  1  |  0  |  1  |
|  1  |  0  |  0  |  1  |
|  1  |  1  |  1  |  0  |

    1. 2 × 0 + 0 = 0 + 0 ==> 0 = 0
    2. 2 x 0 + 1 = 0 + 1 ==> 1 = 1
    3. 2 × 0 + 1 = 1 + 0 ==> 1 = 1
    4. 2 × 1 + 0 = 1 + 1 ==> 2 = 2


Exercise 5
----------
Prove Theorem 107. 

    0 × 2 + 0 = 0 + 0 + 0  ===> 0 = 0
    0 × 2 + 1 = 0 + 0 + 1  ===> 1 = 1
    0 × 2 + 1 = 0 + 1 + 0  ===> 1 = 1
    1 × 2 + 0 = 0 + 1 + 1  ===> 2 = 2
    0 × 2 + 1 = 1 + 0 + 0  ===> 1 = 1
    1 × 2 + 0 = 1 + 0 + 1  ===> 2 = 2
    1 × 2 + 0 = 1 + 1 + 0  ===> 2 = 2
    1 × 2 + 1 = 1 + 1 + 1  ===> 3 = 3

13.2.5 Binary Representation
============================
We can build "words" from bits by stringing them together, like so

$$
[x_0,x_1,x_2,x_3]
$$

Where $x_0$ is the most significant digit.

In general the value of a $k$-bit word $x = [x_0, ..., x_{k-1}]$ is
$$
    \sum_{i=0}^{k-1} x_i × 2^{k - (i + 1)}
$$

In Haskell

> wordValue :: (Eq a, Signal a) => [a] -> Integer
> wordValue [] = 0
> wordValue (x:xs) = let 
>    k = length xs
>    in (bitValue x) * 2 ^ k + wordValue xs

Exercise 6
----------
Work out the numeric value of the word $[1,0,0,1,0]$. Then check
your result by using the computer to evaluate:

    wordValue [True, False, False, True, False]

$$
1 × 2^4 + 0 × 2^3 + 0 × 2^2 + 1 × 2^1 + 0 × 2^0 = 16 + 2 = 18
$$

13.3 Ripple Carry Addition
==========================
Calculate sum of two words

> add4 :: Signal a => a -> [(a,a)] -> (a, [a])
> add4 c [(x0, y0),(x1,y1),(x2,y2),(x3,y3)] =
>    let (c0, s0) = fullAdd (x0, y0) c1
>        (c1, s1) = fullAdd (x1, y1) c2
>        (c2, s2) = fullAdd (x2, y2) c3
>        (c3, s3) = fullAdd (x3, y3) c
>    in (c0, [s0, s1, s2, s3])

> mscanr :: (b -> a -> (a, c)) -> a -> [b] -> (a, [c])
> mscanr f a [] = (a, [])
> mscanr f a (x:xs) = 
>    let (a2, cs) = mscanr f a xs
>        (a3, c) = f x a2
>    in  (a3, c:cs)

> rippleAdd :: Signal a => a -> [(a,a)] -> (a, [a])
> rippleAdd c zs = mscanr fullAdd c zs

Exercise 9
----------
Work out a test case using the ripple carry adder to calculate
13+41=54, using 6-bit words. Test it using the computer.

Helper functions

By hand

    13 = 8 + 4 + 1  = 001101
    41 = 32 + 8 + 1 = 101001 +
                    = 110110

13.3.3 Correctness of the Ripple Carry Adder
============================================
Theorem 108
-----------
Let $xs$ and $ys$ be $k$-bit words, so $xs,ys :: Signal\ a => [a]$. Define
$(c,sum) = rippleAdd\ zero\ (zip\ xs\ ys)$; thus $c :: a$ is the carry output
and $ss :: [a]$ is the sum word. Then

$$
    bitValue\ c × 2^k + wordValue\ ss = wordValue\ xs + wordValue\ ys
$$

*Proof*. Induction over $k$. For the base case, $k = 0$, and $xs = ys = []$. First we
simplify:

    (c, ss) = rippleAdd zero []
      = mscanr fullAdd zero []
      = (zero, [])
      
    c = zero
    ss = []
    wordValue [] + wordValue [] = 0 + 0 = 0
    
    bitValue\ c × 2ᵏ + wordValue ss
      = 0 × 2⁰ + 0
      = 0 × 2⁰ + wordValue []
      = 0

For the inductive case, let $k = length\ xs = length\ ys$, and assume
$$
    bitValue\ c × 2^k + wordValue\ ss = wordValue\ xs + wordValue\ ys
$$
where $(c,ss) = rippleAdd\ zero\ (zip\ xs\ ys)$. The aim is to prove that
$$
    bitValue\ c × 2^{k+1} + wordValue\ ss = \\\
    \quad\quad\quad wordValue (x : xs) + wordValue (y : ys)
$$
where $(c,ss) = rippleAdd\ zero\ (zip\ (x : xs) (y : ys))

First we simplify:

    (c,ss)  = mscanr fullAdd zero (zip (x :xs) (y : ys))  {rippleAdd}
            = mscanr fullAdd zero ((x,y) : zip xs ys)     {zip}
            = let (c', ss) = mscanr fullAdd zero (zip xs ys)
                = rippleAdd zero (zip xs ys)
            (c'', s) = fullAdd (x,y) c'
            in (c'', s : ss)

Now the left-hand side of the equation can be transformed into the right-hand
side, using equational reasoning:

    lhs (numeric value of output from the adder)
        = bitValue c × 2ᵏ⁺¹ + wordValue ss
        = bitValue c'' × 2ᵏ⁺¹ + wordValue (s : ss)         {substitute}
        = bitValue c'' × 2ᵏ⁺¹ + bitValue s × 2ᵏ + wordValue ss
        = (bitValue c'' × 2 + bitValue s) × 2ᵏ + wordValue ss
        = (bitValue x + bitValue y + bitValue c ? ) × 2ᵏ + wordValue ss
        = (bitValue x + bitValue y) × 2ᵏ + (bitValue c ? ) × 2ᵏ + wordValue ss)
        = (bitValue x + bitValue y) × 2ᵏ + wordValue xs + wordValue ys
        = (bbitValue x × 2ᵏ + wordValue xs) + (bitValue y × 2ᵏ + wordValue ys)
        = wordValue (x : xs) + wordValue (y : ys)
        = rhs (numeric value of inputs to the adder)

13.3.4 Binary Comparison
========================
Compare 2 bits, outputting $(lt,eq,gt)$

> halfCmp :: Signal a => (a,a) -> (a,a,a)
> halfCmp (x, y) =
>   let lt = (and2 (inv x) y)
>       eq = inv (xor x y)
>       gt = (and2 x (inv y))
>   in (lt, eq, gt)

Full compare, that takes $(lt,eq,gt)$ "until now" (from left to right) and two bits

> fullCmp :: Signal a => (a,a,a) -> (a,a) -> (a,a,a)
> fullCmp (lt,eq,gt) (x,y) =
>    let lt' = or2 lt (and3 eq (inv x) y)
>        eq' = and2 eq (inv (xor x y))
>        gt' = or2 gt (and3 eq x (inv y))
>    in (lt', eq', gt')

Compare n-sized words, outputting $(lt,eq,gt)$. Goes left (most significant) to right

> rippleCmp :: Signal a => [(a,a)] -> (a,a,a)
> rippleCmp z = foldl fullCmp (zero, one, zero) z

Exercise 10
-----------
Define a full set of test cases for the circuit halfCmp, which
compares two bits, and execute them using the computer.

> testHalfCmp = and $ do
>     g <- [False, True]
>     g2 <- [False, True]
>     map test $ return (g,g2)
>     where
>        test x = halfCmp x == base x
>        base (False,True) = (True,False,False)
>        base (True,False) = (False,False,True)
>        base _            = (False,True,False)

Exercise 11
-----------
Define three test cases for the rippleCmp circuit, with a word
size of three bits, demonstrating each of the three possible results. Run
your test cases on the computer.

    1. rippleCmp (zip [True,False,False]  [False,False,False]) == (False,False,True)
    2. rippleCmp (zip [False,False,False] [False,False,False]) == (False,True,False)
    3. rippleCmp (zip [False,True,False]  [True,False,False ]) == (True,False,False)

13.5 Review Exercises
=====================
Exercise 12
-----------
Show that the `and4` logic gate, which takes four inputs $a, b, c$,
and $d$ and outputs $a ∧ b ∧ c ∧ d$, can be implemented using only `and2`
gates.

> and4 a b c d = and2 (and2 (and2 a b) c) d

Exercise 13
-----------
Work out a complete set of test cases for the full adder, and
calculate the expected results. Then simulate the test cases and compare
with the predicted results.

> testFullAdder = and $ do
>     g <- [False, True]
>     g' <- [False, True]
>     g'' <- [False, True]
>     inputs <- [(g,(g',g''))] -- (carry, (x,y))
>     map test $ return inputs
>     where
>        test :: (Bool, (Bool, Bool)) -> Bool
>        test (c,x) = fullAdd x c == base x c
>        base (x,y) True = 
>            case (x,y) of
>               (False,False) -> (False,True)
>               (True,True)   -> (True,True)
>               _             -> (True,False)
>        base (x,y) False = 
>            case (x,y) of
>               (False,False) -> (False,False)
>               (True,True)   -> (True,False)
>               _             -> (False,True)


Exercise 14
-----------
Suppose that a computer has 8 memory locations, with addresses
$0,1,2,...7$. Notice that we can represent an address with 3 bits,
and the size of the memory is $2^3$ locations. We name the address bits
$a_0 a_1 a_2$ , where $a_0$ is the most significant bit and $a_2$ is the least significant.
When a memory location is accessed, the hardware needs to send a signal
to each location, telling it whether it is the one selected by the address
$a_0 a_1 a_2$. Thus there are 8 *select* signals, one for each location, named
$s_0 ,s_1 ,...,s_7$. Design a circuit that takes as inputs the three address bits
$a_0 ,a_1 ,a_2$, and outputs the select signals $s_0 ,s_1 ,...,s_7$.
Hint: use demultiplexors, arranged in a tree-like structure.
(Note: modern computers
have an address size from 32 to 64 bits, allowing for a large number of
locations, but a 3-bit address makes this exercise more tractable!)

    0 -> 01
    1 -> 10

    00 -> 0001
    01 -> 0010
    10 -> 0100 
    11 -> 1000 

    000 --> 00000001
    001 --> 00000010
    010 --> 00000100
    011 --> 00001000
    100 --> 00010000
    101 --> 00100000
    110 --> 01000000
    111 --> 10000000

> memSel1 x = demux1 (inv x) one
>        
> memSel2 [x0,x1] =
>    let (y0, y1) = memSel1 x0
>        (z0, z1) = demux1 x1 y0
>        (z2, z3) = demux1 x1 y1
>    in [z1,z0,z3,z2]
>
> memSel3 [x0,x1,x2] =
>    let (a0, a1) = demux1 (inv x0) one
>        (b0, b1) = demux1 (inv x1) a0
>        (b2, b3) = demux1 (inv x1) a1
>        (c0, c1) = demux1 (inv x2) b0
>        (c2, c3) = demux1 (inv x2) b1
>        (c4, c5) = demux1 (inv x2) b2
>        (c6, c7) = demux1 (inv x2) b3
>    in [c0,c1,c2,c3,c4,c5,c6,c7]
>
> -- general memsel for any n bits
> memSel (x:xs) = memSel' (demux1 (inv x) one) xs where
>    memSel' (y0, y1) (x:xs) =
>        let l = demux1 (inv x) y0
>            r = demux1 (inv x) y1
>        in memSel' l xs ++ memSel' r xs
>    memSel' (y0, y1) [] =
>        [y0,y1]

Exercise 15
-----------
Does the definition of rippleAdd allow the word size to be 0? If
not, what prevents it? If so, what does it mean?

Yeap, then the result is just the carry, which means overflow?

Exercise 16
-----------
Does the definition of rippleAdd allow the word size to be neg-
ative? If not, what prevents it? If so, what does it mean?

No, mscanr only works on lists, and lists cannot have a negative size.

Exercise 17
-----------
Note that for the half adder and full adder, we did thorough
testing — we checked the output of the circuit for every possible input.
Note also that we did not do this for the ripple carry adder, where we just
tried out a few particular examples. The task: Explain why it is infeasible
to do thorough testing of a ripple carry adder circuit, and estimate how
long it would take to test all possible input values for the binary adder
in a modern processor where the words are 64 bits wide.

For a digital circuit with $n$ inputs there are $2^n$ possible permutations
of input values. So with a ripple carry adder that takes two 64 bit words,
it would be $2$ for the carry bit and $2^(2 × 64)$ for the words.
These should be multiplied so its $2 × 2^{2 × n}$ where $n = 64$, which
is $2^{^129}$ which is unbelieveably huge.

Exercise 18
-----------
Computer programs sometimes need to perform arithmetic,
including additions and comparisons, on big integers consisting of many
words. Most computer processor architectures provide hardware support
for this, and part of that hardware support consists of the ability to per-
form an addition where the carry input is supplied externally, and is not
assumed to be 0. Explain why the carry input to the `rippleAdd` circuit
helps to implement multiword addition, but we don’t need an analogous
horizontal input to rippleCmp for multiword comparisons.

Because of carry bit, we can "nest" ripple adders to add "infitely"
bigger words. The comparison circuits do not need this, because we
can just compare each word with eachother, and then compare the results
again.