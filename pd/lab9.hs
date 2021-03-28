import Data.Char (toUpper)

-- Exemplul 1
prelStr strin = map toUpper strin
ioString = do
    strin <- getLine
    putStrLn $ "Intrare \n" ++ strin
    let strout = prelStr strin
    putStrLn $ "Iesire\n" ++ strout


-- Exemplul 2
prelNumber nr = sqrt nr
ioNumber = do
    nrIn <- readLn :: IO Double
    putStrLn $ "Intrare\n" ++ (show nrIn)
    let nrOut = prelNumber nrIn
    putStrLn $ "Iesire\n" ++ (show nrOut)
    print nrOut


-- Exemplul 3
inOutFile = do
    sin <- readFile "lab9_input.txt"
    putStrLn $ "intrare\n" ++ sin
    let sout = prelStr sin
    putStrLn $ "Iesire\n" ++ sout
    writeFile "lab9_output.txt" sout


-- Ex 1
ex1aux :: Int -> [String] -> Int -> IO()
ex1aux 0 x _ = do putStrLn $ concat $ x
ex1aux n x ma = do
   nume <- getLine
   varsta  <- readLn :: IO Int
   if varsta == ma
      then ex1aux (n-1) (nume:x) varsta
      else
        if varsta > ma
           then ex1aux (n-1) [nume] varsta
           else ex1aux (n-1) x ma

ex1 = do
            n  <- readLn :: IO Int
            ex1aux n [] 0


-- Ex 2
mySplit :: Char -> String -> String -> [String]
mySplit sep "" s = [s]
mySplit sep (c:cs) s
   | c == sep = [s] ++ mySplit sep cs ""
   | otherwise = mySplit sep cs (s ++ [c])

aux :: [String] -> (String,Int)
aux [a,b] = (a,read b)
ex2 = do
            continut  <- readFile "...\\Laborator 9\\ex2.in"
            let linii= lines continut
            let persoane = map (\lin -> aux $ mySplit ',' lin "") linii
            let ma = foldr (\(_,b) c -> max b c) 0 persoane
            let fil = filter (\(a,b) -> b==ma) persoane
            putStrLn $ concat $ map fst fil