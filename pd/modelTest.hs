-- Ex 1
countSfRec :: String -> Int
countSfRec [] = 0
countSfRec (h:t)
    | h == '.' || h == ':' || h == '?' || h == '!' = 1 + countSfRec t
    | otherwise = countSfRec t

countSfComp :: String -> Int
countSfComp list = length [x | x <- list, elem x ".:?!"]


-- Ex 2
liniiN :: [[Int]] -> Int -> Bool
liniiN mat n = not (elem False $ map (\x -> length (filter (\y -> y > 0) x) == n) $ filter (\l -> length l == n) mat)  

-- sau
-- liniiN matrix n = foldr (&&) True (map (\ line -> length line == length (filter (>0) line)) (filter ((==n).length) matrix))

matrice :: [[Int]]
matrice = [[17, 2], [1, 2, 3], [4, 5, 6, 7], [1, 5], [0, 2]]

test_linii = liniiN matrice 2 == True


-- Ex 3
data Punct = Pt [Int] deriving Show

data Arb = Vid | F Int | N Arb Arb deriving Show

class ToFromArb a where
    toArb :: a -> Arb
    fromArb :: Arb -> a

instance ToFromArb Punct where
    toArb (Pt ([])) = Vid
    toArb (Pt (x:xs)) = N (F x) (toArb (Pt xs))

    fromArb Vid = Pt []
    fromArb (F x) = Pt [x]
    fromArb (N x y) = Pt (l1 ++ l2)
        where
            Pt l1 = fromArb x
            Pt l2 = fromArb y