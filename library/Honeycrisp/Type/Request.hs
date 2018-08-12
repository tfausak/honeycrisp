module Honeycrisp.Type.Request
  ( Request
  , toRequest
  , fromRequest
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text

newtype Request a
  = Request a
  deriving (Eq, Show)

instance Aeson.ToJSON a => Aeson.ToJSON (Request a) where
  toJSON request = Aeson.object [Text.pack "data" Aeson..= fromRequest request]

toRequest :: a -> Request a
toRequest = Request

fromRequest :: Request a -> a
fromRequest (Request a) = a
