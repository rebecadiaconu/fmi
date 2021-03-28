-- http://www.inf.ed.ac.uk/teaching/courses/inf1/fp/



import Data.Char
import Data.List

-- 1.
rotate :: Int -> [Char] -> [Char]
rotate n (h:t) 
    | n < 0 = error "Numarul este negativ."
    | n > length (h:t) = error "Numarul este prea mare!"
    | n == 0 = (h:t)
    | otherwise = rotate (n - 1) (t ++ [h])

-- 2.
prop_rotate :: Int -> String -> Bool
prop_rotate k str = rotate (l - m) (rotate m str) == str
  where
    l = length str
    m = if l == 0 then 0 else k `mod` l

-- 3.
makeKey :: Int -> [(Char, Char)]
makeKey n = zip "ABCDEFGHIJKLMNOPQRSTUVWXYZ" (rotate n "ABCDEFGHIJKLMNOPQRSTUVWXYZ")

-- 4.
lookUp :: Char -> [(Char, Char)] -> Char
lookUp ch [] = ch
lookUp ch ((h1,h2):t)
    | ch == h1 = h2
    | otherwise = lookUp ch t

-- 5.
encipher :: Int -> Char -> Char
encipher n ch = lookUp ch (makeKey n)

-- 6.
normalize :: [Char] -> String
normalize [] = []
normalize (h:t)
    | elem h " .,!-?;" = normalize t
    | elem h ['a'..'z'] = [toUpper h] ++ normalize t
    | otherwise = [h] ++ normalize t

-- 7.
encipherStr :: Int -> String -> String
encipherStr n str = map (\x -> encipher n x) $ normalize str

-- 8.
reverseKey :: [(Char, Char)] -> [(Char, Char)]
reverseKey list = [(y, x) | (x, y) <- list]

-- 9.
decipher :: Int -> Char -> Char
decipher n ch = lookUp ch $ reverseKey $ makeKey n


decipherStr :: Int -> String -> String
decipherStr n str = map (\x -> decipher n x) str