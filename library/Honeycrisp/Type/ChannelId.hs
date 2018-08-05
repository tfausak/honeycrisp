module Honeycrisp.Type.ChannelId
  ( ChannelId
  , uuidToChannelId
  , channelIdToUuid
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.UUID as Uuid

newtype ChannelId
  = ChannelId Uuid.UUID
  deriving Eq

instance Aeson.FromJSON ChannelId where
  parseJSON = fmap uuidToChannelId . Aeson.parseJSON

instance Show ChannelId where
  show = show . Uuid.toString . channelIdToUuid

uuidToChannelId :: Uuid.UUID -> ChannelId
uuidToChannelId = ChannelId

channelIdToUuid :: ChannelId -> Uuid.UUID
channelIdToUuid (ChannelId uuid) = uuid
