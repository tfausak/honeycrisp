module Honeycrisp.Version
  ( version
  )
where

import qualified Data.Version as Version
import qualified Paths_honeycrisp as Package

version :: Version.Version
version = Package.version
