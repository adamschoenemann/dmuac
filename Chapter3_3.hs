module Chapter3_3 where

import Test.QuickCheck

data Peano = Zero | Succ Peano

zero :: Peano
zero = Zero

one :: Peano
one = Succ Zero

two :: Peano
two = Succ one

toInt :: Peano -> Int
toInt Zero = 0
toInt (Succ p) = 1 + toInt p

toPeano :: Int -> Peano
toPeano 0 = Zero
toPeano n = Succ (toPeano (n - 1))

add :: Peano -> Peano -> Peano
add Zero x = x
add (Succ p) q = Succ (add p q)

sub :: Peano -> Peano -> Peano
sub x Zero = x
sub Zero x = Zero
sub (Succ p) (Succ q) = sub p q

equals :: Peano -> Peano -> Bool
equals Zero Zero = True
equals Zero x 	 = False
equals x    Zero = False
equals (Succ x) (Succ y) = equals x y

lt :: Peano -> Peano -> Bool
Zero `lt` Zero         = False
_ 	 `lt` Zero         = False
Zero `lt` _            = True
(Succ p) `lt` (Succ q) = p `lt` q

instance Eq Peano where
	x == y = equals x y

instance Show Peano where
	show x = show $ toInt x

instance Arbitrary Peano where
	arbitrary = do
		Positive x <- arbitrary
		return $ toPeano x

genAddNegatesSubArgs :: Gen (Peano, Peano)
genAddNegatesSubArgs = do
	x <- choose (0, 100)
	y <- choose (x, 100)
	return (toPeano x, toPeano y)

prop_assoc_add x y = add x y == add y x
prop_add_zero x = add Zero x == x
prop_sub_zero x = x `sub` zero == x
prop_add_negates_sub x y = add y (x `sub` y) == y

check = do
	quickCheck prop_assoc_add
	quickCheck prop_add_zero
	quickCheck prop_sub_zero
	quickCheck $ forAll genAddNegatesSubArgs (\(x,y) -> prop_add_negates_sub x y)

main = check

