module Honeycrisp.Type.Channel
  ( Channel
  , channelCreatedAt
  , channelId
  , channelLinks
  , channelModifiedAt
  , channelName
  , channelShareUrl
  , channelType
  , channelWebsite
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Data.Time as Time
import qualified Honeycrisp.Type.ChannelId as ChannelId
import qualified Honeycrisp.Type.ChannelLinks as ChannelLinks
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

-- | <https://developer.apple.com/documentation/apple_news/channel>
data Channel = Channel
  { channel_createdAt :: Time.UTCTime
  , channel_id :: ChannelId.ChannelId
  , channel_links :: ChannelLinks.ChannelLinks
  , channel_modifiedAt :: Time.UTCTime
  , channel_name :: Text.Text
  , channel_shareUrl :: Url.Url
  , channel_type :: Text.Text
  , channel_website :: Url.Url
  } deriving (Eq, Show)

instance Aeson.FromJSON Channel where
  parseJSON = Aeson.withObject "Channel" $ \object ->
    Channel
      <$> object
      Aeson..: Text.pack "createdAt"
      <*> object
      Aeson..: Text.pack "id"
      <*> object
      Aeson..: Text.pack "links"
      <*> object
      Aeson..: Text.pack "modifiedAt"
      <*> object
      Aeson..: Text.pack "name"
      <*> object
      Aeson..: Text.pack "shareUrl"
      <*> object
      Aeson..: Text.pack "type"
      <*> object
      Aeson..: Text.pack "website"

channelCreatedAt :: Lens.Lens' Channel Time.UTCTime
channelCreatedAt = Lens.lens channel_createdAt
  $ \channel createdAt -> channel { channel_createdAt = createdAt }

channelId :: Lens.Lens' Channel ChannelId.ChannelId
channelId =
  Lens.lens channel_id $ \channel id_ -> channel { channel_id = id_ }

channelLinks :: Lens.Lens' Channel ChannelLinks.ChannelLinks
channelLinks =
  Lens.lens channel_links $ \channel links -> channel { channel_links = links }

channelModifiedAt :: Lens.Lens' Channel Time.UTCTime
channelModifiedAt = Lens.lens channel_modifiedAt
  $ \channel modifiedAt -> channel { channel_modifiedAt = modifiedAt }

channelName :: Lens.Lens' Channel Text.Text
channelName =
  Lens.lens channel_name $ \channel name -> channel { channel_name = name }

channelShareUrl :: Lens.Lens' Channel Url.Url
channelShareUrl = Lens.lens channel_shareUrl
  $ \channel shareUrl -> channel { channel_shareUrl = shareUrl }

channelType :: Lens.Lens' Channel Text.Text
channelType =
  Lens.lens channel_type $ \channel type_ -> channel { channel_type = type_ }

channelWebsite :: Lens.Lens' Channel Url.Url
channelWebsite = Lens.lens channel_website
  $ \channel website -> channel { channel_website = website }
