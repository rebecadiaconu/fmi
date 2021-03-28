import Data.List (nub)
import Data.Maybe (fromJust)

data Fruct
    = Mar String Bool
    | Portocala String Int
      -- deriving(Show)

instance Show Fruct where
  show (Mar s b) = "Marul " ++ show s ++ (if b then " are viermi." else " nu are viermi.")
  show (Portocala s i) = "Portocala " ++ show s ++ " are " ++ show i ++ (if i == 1 then " felie." else " felii.") 

ionatanFaraVierme = Mar "Ionatan" False
goldenCuVierme = Mar "Golden Delicious" True
portocalaSicilia10 = Portocala "Sanguinello" 10
listaFructe = [Mar "Ionatan" False, Portocala "Sanguinello" 10, Portocala "Valencia" 22, Mar "Golden Delicious" True, Portocala "Sanguinello" 15, Portocala "Moro" 12, Portocala "Tarocco" 3, Portocala "Moro" 12, Portocala "Valencia" 2, Mar "Golden Delicious" False, Mar "Golden" False, Mar "Golden" True]


ePortocalaDeSicilia :: Fruct -> Bool
ePortocalaDeSicilia (Portocala s i) = elem s ["Tarocco", "Moro", "Sanguinello"]
ePortocalaDeSicilia _ = False

test_ePortocalaDeSicilia1 = ePortocalaDeSicilia (Portocala "Moro" 12) == True
test_ePortocalaDeSicilia2 = ePortocalaDeSicilia (Mar "Ionatan" True) == False


nrFeliiSicilia :: [Fruct] -> Int
nrFeliiSicilia [] = 0
nrFeliiSicilia (h@(Portocala s i):t)
  | ePortocalaDeSicilia h = i + nrFeliiSicilia t
  | otherwise  = nrFeliiSicilia t
nrFeliiSicilia (_:t) = nrFeliiSicilia t

nrFeliiSiciliaComp list = sum [ i | Portocala s i <- list, elem s ["Tarocco", "Moro", "Sanguinello"]]

nrFeliiSiciliaComp2 list = sum [ i | x@(Portocala s i) <- list, ePortocalaDeSicilia x]

nrFeliiSiciliaHof list = foldr (+) 0  $ map (\ (Portocala s i) -> i) (filter ePortocalaDeSicilia list)


test_nrFeliiSicilia = nrFeliiSicilia listaFructe == 52

nrMereViermi :: [Fruct] -> Int
nrMereViermi [] = 0
nrMereViermi (h@(Mar s b):t)
  | b == True = 1 + nrMereViermi t
  | otherwise = nrMereViermi t
nrMereViermi (_:t) = nrMereViermi t

nrMereViermi2 list = length [s | Mar s b <- list, b == True]

test_nrMereViermi = nrMereViermi2 listaFructe == 2


type NumeA = String
type Rasa = String
data Animal = Pisica NumeA | Caine NumeA Rasa

instance Show Animal where
  show (Pisica nume) = show nume ++ " este pisica."
  show (Caine nume rasa) = show nume ++ " este caine de rasa " ++ show rasa

sara = Pisica "Sara"

vorbeste :: Animal -> String
vorbeste (Pisica s) = "meow"
vorbeste (Caine s r) = "ham!"

rasa :: Animal -> Maybe String
rasa (Caine s r) = Just r
rasa _ = Nothing


type Nume = String
data Prop
    = Var Nume
    | F
    | T
    | Not Prop
    | Prop :|: Prop
    | Prop :&: Prop
    | Prop :->: Prop
    | Prop :<->: Prop
    deriving (Eq, Read)
infixr 2 :|:
infixr 3 :&:
infixr 4 :->:
infixr 5 :<->:

p1 :: Prop
p1 = (Var "P" :|: Var "Q") :&: (Var "P" :&: Var "Q")

p2 :: Prop
p2 = (Var "P" :|: Var "Q") :&: (Not (Var "P") :&: Not (Var "Q"))

p3 :: Prop
p3 = (Var "P" :&: (Var "Q" :|: Var "R")) :&: (Not (Var "P") :|: Not (Var "Q")) :&: (Not (Var "P") :|: Not (Var "R"))

instance Show Prop where
    show (Var x) = x
    show T = "T"
    show F = "F"
    show (Not x) = "(~" ++ show x ++ ")"
    show (a :|: b) = "(" ++ show a ++ "|" ++ show b ++ ")"
    show (a :&: b) = "(" ++ show a ++ "&" ++ show b ++ ")"
    show (a :->: b) = "(" ++ show a ++ "->" ++ show b ++ ")"
    show (a :<->: b) = "(" ++ show a ++ "<->" ++ show b ++ ")"

test_ShowProp :: Bool
test_ShowProp = show (Not (Var "P") :&: Var "Q") == "((~P)&Q)"

type Env = [(Nume, Bool)]

impureLookup :: Eq a => a -> [(a,b)] -> b
impureLookup a = fromJust . lookup a

eval :: Prop -> Env -> Bool
eval (Var x) env = impureLookup x env
eval T _ = True
eval F _ = False
eval (Not x) env = not (eval x env)
eval (x :|: y) env = (eval x env) || (eval y env)
eval (x :&: y) env = (eval x env) && (eval y env)
eval (x :->: y) env = (not (eval x env)) || (eval y env)
eval (x :<->: y) env = ((not (eval x env)) || (eval y env)) && ((not (eval y env)) || (eval x env))

test_eval = eval  (Var "P" :|: Var "Q") [("P", True), ("Q", False)] == True
test_eval2 = eval (Not(Var "P") :->: (Var "Q" :&: Var "R")) [("P", True), ("Q", False), ("R", True)] == True
test_eval3 = eval (Not(Var "P") :->: (Var "Q" :&: Var "R")) [("P", False), ("Q", False), ("R", True)] == False


variabile :: Prop -> [Nume]
variabile (Var x) = [x]
variabile T = []
variabile F = []
variabile (Not x) = variabile x
variabile (x :|: y) = nub (variabile x ++ variabile y)
variabile (x :&: y) = nub (variabile x ++ variabile y)
variabile (x :->: y) = nub (variabile x ++ variabile y)
variabile (x :<->: y) = nub (variabile x ++ variabile y)


test_variabile = variabile (Not (Var "P") :&: Var "Q") == ["P", "Q"]

evalValue :: Nume -> Env
evalValue nume = [(nume, False), (nume, True)]

envs :: [Nume] -> [Env]
envs (x:[]) = [evalValue x]
envs (x:xs:[]) = [[a] ++ [b] | a <- evalValue x, b <- evalValue xs]
envs (x:xs) = [[a] ++ b | a <- evalValue x, b <- envs xs]

test_envs =
      envs ["P", "Q"]
      ==
      [ [ ("P",False)
        , ("Q",False)
        ]
      , [ ("P",False)
        , ("Q",True)
        ]
      , [ ("P",True)
        , ("Q",False)
        ]
      , [ ("P",True)
        , ("Q",True)
        ]
      ]

satisfiabila :: Prop -> Bool
satisfiabila prop = length [x | x <- (map (\x -> eval prop x) env), x == True] >= 1
  where 
    env = envs $ variabile prop

-- sau
-- satisfiabila prop = length [eval prop x | x <- envs (variabile prop), eval prop x == True] >= 1


test_satisfiabila1 = satisfiabila (Not (Var "P") :&: Var "Q") == True
test_satisfiabila2 = satisfiabila (Not (Var "P") :&: Var "P") == False

valida :: Prop -> Bool
valida prop = satisfiabila (Not prop) == False

test_valida1 = valida (Not (Var "P") :&: Var "Q") == False
test_valida2 = valida (Not (Var "P") :|: Var "P") == True



--- pentru exercitiul 8 puteam definii functiile urmatoare
impl :: Bool -> Bool -> Bool
impl False _ = True
impl _ x = x

echiv :: Bool -> Bool -> Bool
echiv x y = x==y

--- pe care le-am fi folosit astfel
-- eval (p :->: q) env = eval p env `impl` eval q env
-- eval (p :<->: q) env = eval p env `echiv` eval q env