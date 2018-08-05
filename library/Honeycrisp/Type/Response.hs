module Honeycrisp.Type.Response
  ( Response
  , toResponse
  , fromResponse
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text

newtype Response a
  = Response a
  deriving (Eq, Show)

instance Aeson.FromJSON a => Aeson.FromJSON (Response a) where
  parseJSON = Aeson.withObject "Response"
    $ \object -> toResponse <$> object Aeson..: Text.pack "data"

toResponse :: a -> Response a
toResponse = Response

fromResponse :: Response a -> a
fromResponse (Response a) = a
