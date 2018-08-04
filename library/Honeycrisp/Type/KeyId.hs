module Honeycrisp.Type.KeyId
  ( KeyId
  , uuidToKeyId
  , keyIdToUuid
  )
where

import qualified Data.UUID as Uuid

newtype KeyId
  = KeyId Uuid.UUID
  deriving (Eq, Show)

uuidToKeyId :: Uuid.UUID -> KeyId
uuidToKeyId = KeyId

keyIdToUuid :: KeyId -> Uuid.UUID
keyIdToUuid (KeyId uuid) = uuid
