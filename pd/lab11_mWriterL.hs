
--- Monada Writer

    

newtype WriterLS a = Writer { runWriter :: (a, [String]) } 


instance  Monad WriterLS where
  return va = Writer (va, [])
  ma >>= k = let (va, log1) = runWriter ma
                 (vb, log2) = runWriter (k va)
             in  Writer (vb, log1 ++ log2)


instance  Applicative WriterLS where
  pure = return
  mf <*> ma = do
    f <- mf
    a <- ma
    return (f a)       

instance  Functor WriterLS where              
  fmap f ma = pure f <*> ma 



tell :: String -> WriterLS () 
tell log = Writer ((), [log])
  
logIncrement :: Int  -> WriterLS Int
logIncrement x = do
  tell("increment: " ++ show x ++ "; ")
  return (x + 1)

logIncrement2 :: Int  -> WriterLS Int
logIncrement2 x = do
  y <- logIncrement x
  logIncrement y

logIncrementN :: Int -> Int -> WriterLS Int
logIncrementN x 0 = return x
logIncrementN x n = do
  y <- logIncrement x
  logIncrementN y (n - 1)  
                         

isPos :: Int -> WriterLS Bool
isPos x = if (x>= 0) then (Writer (True, ["poz"])) else (Writer (False, ["neg"]))                           

mapWriterLS :: (a -> WriterLS b) -> [a] -> WriterLS [b]
mapWriterLS f xs = Writer (list1, list2)
  where
    list = map runWriter $ map f xs
    list1 = map fst list
    list2 = concat $ map snd list