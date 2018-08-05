module Honeycrisp.Type.KeyId
  ( KeyId
  , uuidToKeyId
  , keyIdToUuid
  , stringToKeyId
  )
where

import qualified Data.UUID as Uuid

newtype KeyId
  = KeyId Uuid.UUID
  deriving Eq

instance Show KeyId where
  show = show . Uuid.toString . keyIdToUuid

uuidToKeyId :: Uuid.UUID -> KeyId
uuidToKeyId = KeyId

keyIdToUuid :: KeyId -> Uuid.UUID
keyIdToUuid (KeyId uuid) = uuid

stringToKeyId :: String -> Either String KeyId
stringToKeyId string =
  maybe (Left $ "invalid KeyId: " <> show string) (Right . uuidToKeyId)
    $ Uuid.fromString string
