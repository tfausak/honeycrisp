module Honeycrisp.Type.KeySecret
  ( KeySecret
  , byteStringToKeySecret
  , keySecretToByteString
  )
where

import qualified Data.ByteString as ByteString

newtype KeySecret
  = KeySecret ByteString.ByteString
  deriving (Eq, Show)

byteStringToKeySecret :: ByteString.ByteString -> KeySecret
byteStringToKeySecret = KeySecret

keySecretToByteString :: KeySecret -> ByteString.ByteString
keySecretToByteString (KeySecret byteString) = byteString
