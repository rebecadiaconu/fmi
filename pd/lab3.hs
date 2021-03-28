import   Data.List

-- L3.1 Încercati sa gasiti valoarea expresiilor de mai jos si
-- verificati raspunsul gasit de voi în interpretor:
{-
[x^2 | x <- [1 .. 10], x `rem` 3 == 2]
[(x, y) | x <- [1 .. 5], y <- [x .. (x+2)]]
[(x, y) | x <- [1 .. 3], let k = x^2, y <- [1 .. k]]
[x | x <- "Facultatea de Matematica si Informatica", elem x ['A' .. 'Z']]
[[x .. y] | x <- [1 .. 5], y <- [1 .. 5], x < y ]

-}

factori :: Int -> [Int]
factori x = [ d | d <- [1..(abs x)], mod x d == 0 ]

prim :: Int -> Bool
prim x = length (factori x) == 2

numerePrime :: Int -> [Int]
numerePrime x = [ n | n <- [2..x], prim n]


-- L3.2 Testati si sesizati diferenta:
-- [(x,y) | x <- [1..5], y <- [1..3]]
-- zip [1..5] [1..3]

myzip3 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip3 l1 l2 l3 = [(h1, h2, h3) | ((h1, h2), h3) <- zip (zip l1 l2) l3]


--------------------------------------------------------
----------FUNCTII DE NIVEL INALT -----------------------
--------------------------------------------------------
aplica2 :: (a -> a) -> a -> a
--aplica2 f x = f (f x)
--aplica2 f = f.f
--aplica2 f = \x -> f (f x)
aplica2  = \f x -> f (f x)


(*<*) :: (Integer, Integer) -> (Integer, Integer) -> Bool
(x,y) *<* (z,t) = (sqrt . fromIntegral $ x^2 + y^2) <= (sqrt . fromIntegral $ z^2 + t^2)


-- L3.3
{-

map (\ x -> 2 * x) [1 .. 10]
map (1 `elem` ) [[2, 3], [1, 2]]
map ( `elem` [2, 3] ) [1, 3, 4, 5]

-}

-- firstEl [ ('a', 3), ('b', 2), ('c', 1)]
firstEl list = map (\ (x, y) -> x) list
-- firstEl list = [ x | (x, y) <- list]
-- firstEl xs = map fst xs


-- sumList [[1, 3],[2, 4, 5], [], [1, 3, 5, 6]]
sumList :: [[Integer]] -> [Integer]
sumList list = map (\x -> sum x) list

-- prel2 [2,4,5,6]
prel2 list = map (\x -> if (odd x) then (2 * x) else (div x 2)) list


-- L3.4
findCh :: Char -> [String] -> [String]
findCh _ [] = []
findCh ch list = filter (\x -> elem ch x) list

patrateImpare :: [Integer] -> [Integer]
patrateImpare list = map (\x -> x*x) (filter (\y -> odd y) list)

pozitiiImpare :: [Integer] -> [Integer]
pozitiiImpare list = map (\(x, y) -> y*y) (filter (\(x, y) -> odd x) (zip [0..] list))

numaiVocale :: [String] -> [String]
numaiVocale list = map (\x -> filter (\ch -> elem ch "aeiouAEIOU") x) list


-- L3.5
mymap f [] = []
mymap f (h:t) =
    let
        hh = f h
        tt = mymap f t
    in
        (hh:tt)

myfilter f [] = []
myfilter f (h:t)
    | f h = h:(myfilter f t)
    | otherwise = myfilter f t


numerePrimeCiur :: Int -> [Int]
numerePrimeCiur n 
    | n < 2 = []
    | otherwise = ciur [2..n]

ciur :: [Int] -> [Int]
ciur [] = []
ciur (h:t) = h: ciur (filter (\x -> mod x h /= 0) t)


-- Ex 1
ordonataNat [] = True
ordonataNat [x] = True
ordonareNat (x:xs) = and [ x <= y | (x,y) <- zip (x:xs) xs ]

--  Ex 4
compuneList :: ( b -> c ) -> [( a -> b )] -> [( a -> c )]
compuneList f xh = map (f.) xh

aplicaList x xh = map (x$) xh

myzip32 :: [Int] -> [Int] -> [Int] -> [(Int, Int, Int)]
myzip32 l1 l2 l3 = map (\((h1, h2), h3) -> (h1, h2, h3)) (zip (zip l1 l2) l3)