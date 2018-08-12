module Honeycrisp.Api.Channel
  ( getChannel
  )
where

import qualified Data.UUID as Uuid
import qualified Honeycrisp.Api.Helper as Helper
import qualified Honeycrisp.Type.Channel as Channel
import qualified Honeycrisp.Type.ChannelId as ChannelId
import qualified Honeycrisp.Type.Config as Config
import qualified Network.HTTP.Client as Client

-- | <https://developer.apple.com/documentation/apple_news/read_channel_information>
getChannel
  :: Config.Config
  -> Client.Manager
  -> ChannelId.ChannelId
  -> IO Channel.Channel
getChannel config manager channelId = do
  request <- Helper.createRequest config $ "channels/" <> Uuid.toString
    (ChannelId.channelIdToUuid channelId)
  Helper.performRequest config manager request
