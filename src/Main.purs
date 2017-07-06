module Main where

import Prelude
import Data.Time.Duration (Milliseconds(..))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Aff (Aff, launchAff, forkAff, delay)
import Control.Monad.Aff.Console (log)
import Control.Monad.Aff.AVar (AVAR, makeVar, putVar, takeVar)

main :: Eff (avar :: AVAR, exception :: EXCEPTION, console :: CONSOLE) Unit
main = void $ launchAff aff

aff :: Aff (avar :: AVAR, console :: CONSOLE) Unit
aff = do
  v <- makeVar
  void $ forkAff do
    delay (Milliseconds 1000.0)
    putVar v 1.0
  log $ "not blocked"
  a <- takeVar v
  log $ "Succeded with " <> show a
