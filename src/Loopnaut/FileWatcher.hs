module Loopnaut.FileWatcher where

import Loopnaut.Cli
import Loopnaut.FileWatcher.Implementation
import System.Directory

watchFiles :: FileWatcher -> [File] -> (File -> IO ()) -> IO a -> IO a
watchFiles fileWatcher files handler action = do
  let innerHandler rawChangedFile = do
        changedFile <- canonicalizePath rawChangedFile
        let triggers = filter (\ w -> canonicalPath w == changedFile) files
        case triggers of
          trigger : _ -> do
            handler trigger
          [] -> return ()
  register fileWatcher (map canonicalPath files) innerHandler action