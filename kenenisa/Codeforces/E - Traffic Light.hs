-- E. Traffic Light
-- time limit per test 1 second
-- memory limit per test 256 megabytes
-- input standard input
-- output standard output
-- You find yourself on an unusual crossroad with a weird traffic light. 
-- That traffic light has three possible colors: red (r), yellow (y), green (g). 
-- It is known that the traffic light repeats its colors every π seconds and at the π-th second the color π π is on.

-- That way, the order of the colors is described by a string. 
-- For example, if π ="rggry", then the traffic light works as the following: red-green-green-red-yellow-red-green-green-red-yellow- ... and so on.

-- More formally, you are given a string π 1,π 2,β¦,π π of length π. At the first second the color π 1is on, at the second β π 2, ..., at the π-th second the color π π is on, 
-- at the π+1-st second the color π 1 is on and so on.

-- You need to cross the road and that can only be done when the green color is on.

-- You know which color is on the traffic light at the moment, 
-- but you don't know the current moment of time. You need to find the minimum amount of time in which you are guaranteed to cross the road.

-- You can assume that you cross the road immediately.

-- For example, with π ="rggry" and the current color r there are two options: either the green color will be on after 1 second, or after 3. 
-- That way, the answer is equal to 3 β that is the number of seconds that we are guaranteed to cross the road, if the current color is r.

-- Input
-- The first line contains a single integer π‘ (1β€π‘β€104) β the number of test cases.

-- Then the description of the test cases follows.

-- The first line of each test case contains an integer π and a symbol π (1β€πβ€2β105, πis one of allowed traffic light colors r, y or g)
-- β the length of the string π  and the current color of the traffic light.

-- The second line of each test case contains a string π  of the length π, consisting of the letters r, y and g.

-- It is guaranteed that the symbol g is in the string π  and the symbol π is in the string π .

-- It is guaranteed, that the sum of π over all test cases does not exceed 2^105.

-- Output
-- For each test case output the minimal number of second in which you are guaranteed to cross the road.

-- Example

-- input
-- 6
-- 5 r
-- rggry
-- 1 g
-- g
-- 3 r
-- rrg
-- 5 y
-- yrrgy
-- 7 r
-- rgrgyrg
-- 9 y
-- rrrgyyygy

-- output
-- 3
-- 0
-- 2
-- 4
-- 1
-- 4

-- Note
-- The first test case is explained in the statement.

-- In the second test case the green color is on so you can cross the road immediately.

-- In the third test case, if the red color was on at the second second, then we would wait for the green color for one second, and if the red light was on at the first second, then we would wait for the green light for two seconds.

-- In the fourth test case the longest we would wait for the green color is if we wait for it starting from the fifth second.


countGreen :: String -> Int -> (String,Int)
countGreen [] _ = ([],0)
countGreen (x : xs) c
  | x == 'g' = (xs,c)
  | otherwise = countGreen xs (c + 1)
 
lookForTarget :: String -> Char -> Int -> Int
lookForTarget [] _ val = val
lookForTarget (x : xs) target val
  | target == 'g' = 0
  | x == target = lookForTarget (fst cg) target $ max val $ snd cg
  | otherwise = lookForTarget xs target val
            where cg = countGreen xs 1
 
testCases :: Int -> IO ()
testCases 0 = return ()
testCases n = do
  nAndTarget <- getLine
  lights <- getLine
  let target = last nAndTarget
      l = read (head $ words nAndTarget) :: Int
      looped = take (2 * l) (cycle lights)
  print $ lookForTarget looped target 0
  testCases (n - 1)
 
main :: IO ()
main = do
  t <- getLine
  testCases (read t :: Int)
