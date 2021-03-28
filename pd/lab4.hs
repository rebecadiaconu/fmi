import Numeric.Natural

produsRec :: [Integer] -> Integer
produsRec [] = 1
produsRec (h:t) = h * produsRec t

produsFold :: [Integer] -> Integer
produsFold list = foldr (*) 1 list


andRec :: [Bool] -> Bool
andRec (x:xs) = and [ x && y | (x, y) <- zip (x:xs) xs]

andFold :: [Bool] -> Bool
andFold list = foldr (&&) True list


concatRec :: [[a]] -> [a]
concatRec [] = []
concatRec (h:t) = h ++ concatRec t

concatFold :: [[a]] -> [a]
concatFold list = foldr (++) [] list


rmChar :: Char -> String -> String
rmChar ch list = [x | x <- list, x /= ch]


rmCharsRec :: String -> String -> String
rmCharsRec [] sir = sir
rmCharsRec (x:xs) sir = rmCharsRec xs $ rmChar x sir


test_rmchars :: Bool
test_rmchars = rmCharsFold ['a'..'l'] "fotbal" == "ot"


rmCharsFold :: String -> String -> String
rmCharsFold chList list = foldr rmChar list chList

logistic :: Num a => a -> a -> Natural -> a
logistic rate start = f
  where
    f 0 = start
    f n = rate * f (n - 1) * (1 - f (n - 1))




logistic0 :: Fractional a => Natural -> a
logistic0 = logistic 3.741 0.00079

ex1 :: Natural
ex1 = 20


ex20 :: Fractional a => [a]
ex20 = [1, logistic0 ex1, 3] -- da

ex21 :: Fractional a => a
ex21 = head ex20 -- nu

ex22 :: Fractional a => a
ex22 = ex20 !! 2 -- nu

ex23 :: Fractional a => [a]
ex23 = drop 2 ex20 -- nu

ex24 :: Fractional a => [a]
ex24 = tail ex20 -- da


ex31 :: Natural -> Bool
ex31 x = x < 7 || logistic0 (ex1 + x) > 2

ex32 :: Natural -> Bool
ex32 x = logistic0 (ex1 + x) > 2 || x < 7

ex33 :: Bool
ex33 = ex31 5 -- nu

ex34 :: Bool
ex34 = ex31 7 -- da

ex35 :: Bool
ex35 = ex32 5 -- da

ex36 :: Bool
ex36 = ex32 7 -- da
