module HCat (runHCat) where

import qualified System.Environment as Env

runHCat :: IO ()
runHCat =
  handleArgs
    >>= \fnameOrError ->
      case fnameOrError of
        Left err -> putStrLn $ "Error processing: " <> err
        Right fname -> readFile fname >>= putStrLn

handleArgs :: IO (Either String FilePath)
handleArgs =
  parseArgs <$> Env.getArgs
  where
    parseArgs argumentList =
      case argumentList of
        [fname] -> Right fname
        [] -> Left "no filename provided"
        _ -> Left "multiple files not supported"
