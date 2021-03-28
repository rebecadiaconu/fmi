import Data.List

myInt = 5555555555555555555555555555555555555555555555555555555555

double :: Integer -> Integer
double x = x + x

maxim :: Integer -> Integer -> Integer
maxim x y =
  if (x > y)
    then x
    else y


-- Ex 1.4

maxim3 :: Integer -> Integer -> Integer -> Integer
-- var 1
maxim3 x y z = maxim x (maxim y z)

-- var 2
-- maxim3 x y z =
--   if (x >= y && x >= z)
--     then x
--     else if (y >= x && y >= z)
--       then y
--       else z
--
--
-- -- var 3
-- maxim3 x y z =
--   let
--     u = (maxim x y)
--   in
--     (maxim u z)

maxim4 :: Integer -> Integer -> Integer -> Integer -> Integer
maxim4 x y z t =
  let
    u = (maxim3 x z y)
  in
    (maxim u t)

equal :: Integer -> Integer -> Integer -> Integer -> Bool
equal x y z t = if m >= x && m >= y && m >= z && m >= t then True else False
    where
      m = (maxim4 x y z t)


-- Ex 1.5
sumPatr a b = (a * a) + (b ^ 2)

parity x = if mod x 2 == 0 then True else False

fact x = if x <= 1 then 1 else x * (fact (x - 1))

doubleValue x y = if x > y * 2 then True else False
