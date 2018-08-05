module Honeycrisp.Type.KeySecret
  ( KeySecret
  , byteStringToKeySecret
  , keySecretToByteString
  , stringToKeySecret
  )
where

import qualified Data.ByteArray.Encoding as Memory
import qualified Data.ByteString as ByteString
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text

newtype KeySecret
  = KeySecret ByteString.ByteString
  deriving Eq

instance Show KeySecret where
  show = const "\"[SECRET]\""

byteStringToKeySecret :: ByteString.ByteString -> KeySecret
byteStringToKeySecret = KeySecret

keySecretToByteString :: KeySecret -> ByteString.ByteString
keySecretToByteString (KeySecret byteString) = byteString

stringToKeySecret :: String -> Either String KeySecret
stringToKeySecret string =
  either
      (const . Left $ "invalid KeySecret: " <> show string)
      (Right . byteStringToKeySecret)
    . Memory.convertFromBase Memory.Base64
    . Text.encodeUtf8
    $ Text.pack string
