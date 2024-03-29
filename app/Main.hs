module Main where

import Lib
import Category
import Rule
import Parse
import Output

main :: IO ()
main = cateAnalyze

cateAnalyze :: IO()
cateAnalyze
  = do line <- getLine
       let cateStrInput = words line
       putStr "You have inputed: "
       showNStr cateStrInput
       let cateInput = map getCateFromString cateStrInput
       putStr "Accepted category sequence: "
       showNCate cateInput
       putStr "\n"
       let phraCateInput = initPhraCate cateInput
       putStr "Initial phrase categories: "
       showNPhraCate phraCateInput    
       let phraCateClosure1 = parse phraCateInput
       putStr "Parsing result: "
       showNPhraCate phraCateClosure1
       let phraCateClosure = [pc | pc <- phraCateClosure1, caOfCate pc /= []]
       putStr "After deleting category [], parsing result: "
       showNPhraCate phraCateClosure
       let sp = getNuOfInputCates phraCateClosure - 1
       let roots = findCate (0, sp) phraCateClosure
       putStr "Primitive forest: "
       showNPhraCate roots
       let forest = growForest [[t]|t<-roots] phraCateClosure
       putStrLn "Forests that no longer grow:"
       showForest forest
       showForestCateStartPos forest      -- [OK]
       showForestWithTreeStru forest 
