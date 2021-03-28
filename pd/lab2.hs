-- la nevoie decomentati liniile urmatoare:

import Data.Char
-- import Data.List
-- import Test.QuickCheck


---------------------------------------------
-------RECURSIE: FIBONACCI-------------------
---------------------------------------------

fibonacciCazuri :: Integer -> Integer
fibonacciCazuri n
  | n < 2     = n
  | otherwise = fibonacciCazuri (n - 1) + fibonacciCazuri (n - 2)

fibonacciEcuational :: Integer -> Integer
fibonacciEcuational 0 = 0
fibonacciEcuational 1 = 1
fibonacciEcuational n =
    fibonacciEcuational (n - 1) + fibonacciEcuational (n - 2)

{-| @fibonacciLiniar@ calculeaza @F(n)@, al @n@-lea element din secvența
Fibonacci în timp liniar, folosind funcția auxiliară @fibonacciPereche@ care,
dat fiind @n >= 1@ calculează perechea @(F(n-1), F(n))@, evitănd astfel dubla
recursie. Completați definiția funcției fibonacciPereche.

Indicație:  folosiți matching pe perechea calculată de apelul recursiv.
-}
fibonacciLiniar :: Integer -> Integer
fibonacciLiniar 0 = 0
fibonacciLiniar n = snd (fibonacciPereche n)
  where
    fibonacciPereche :: Integer -> (Integer, Integer)
    fibonacciPereche 1 = (0, 1)
    fibonacciPereche n = (snd (fibonacciPereche (n - 1)), fst (fibonacciPereche (n - 1))  + snd (fibonacciPereche (n - 1)))


---------------------------------------------
----------RECURSIE PE LISTE -----------------
---------------------------------------------
semiPareRecDestr :: [Int] -> [Int]
semiPareRecDestr l
  | null l    = l
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where
    h = head l
    t = tail l
    t' = semiPareRecDestr t

semiPareRecEq :: [Int] -> [Int]
semiPareRecEq [] = []
semiPareRecEq (h:t)
  | even h    = h `div` 2 : t'
  | otherwise = t'
  where t' = semiPareRecEq t

---------------------------------------------
----------DESCRIERI DE LISTE ----------------
---------------------------------------------
semiPareComp :: [Int] -> [Int]
semiPareComp l = [ x `div` 2 | x <- l, even x ]


-- L2.3
inIntervalRec :: Int -> Int -> [Int] -> [Int]
inIntervalRec lo hi [] = []
inIntervalRec lo hi (h:t) 
  | h >= lo && h <= hi = h : inIntervalRec lo hi t
  | otherwise = inIntervalRec lo hi t


inIntervalComp :: Int -> Int -> [Int] -> [Int]
inIntervalComp lo hi xs = [ x | x <- xs, lo <= x && x <= hi ]

-- L2.4

pozitiveRec :: [Int] -> Int
pozitiveRec [] = 0
pozitiveRec (h:t) 
  | h > 0 = 1 + pozitiveRec t
  | otherwise = pozitiveRec t


pozitiveComp :: [Int] -> Int
pozitiveComp l = length [ x | x <- l, x > 0 ]

-- L2.5 
pozitii :: [Int] -> Int -> [Int]
pozitii [] _ = []
pozitii (h:t) n
  | odd h = n : pozitii t (n + 1)
  | otherwise = pozitii t (n + 1)

pozitiiImpareRec :: [Int] -> [Int]
pozitiiImpareRec [] = []
pozitiiImpareRec l = pozitii l 0

pozitiiImpareComp :: [Int] -> [Int]
pozitiiImpareComp l = [ x | (x, y) <- zip [0..] l, odd y ]


-- L2.6

multDigitsRec :: String -> Int
multDigitsRec [] = 1
multDigitsRec (h:t)
  | isDigit(h) = digitToInt(h) * multDigitsRec t
  | otherwise = multDigitsRec t

-- putea fi folosit si product in loc de foldr
multDigitsComp :: String -> Int
multDigitsComp sir = foldr (*) 1 [ digitToInt(h) | h <- sir, isDigit(h) ]

-- L2.7 

discountRec :: [Float] -> [Float]
discountRec [] = []
discountRec (h:t)
  | 0.75 * h < 200 = (0.75 * h) : discountRec t
  | otherwise = discountRec t

discountComp :: [Float] -> [Float]
discountComp list = [0.75 * x | x <- list, 0.75 * x < 200]


