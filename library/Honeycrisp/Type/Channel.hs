module Honeycrisp.Type.Channel
  ( Channel
  , channelCreatedAtLens
  , channelIdLens
  , channelLinksLens
  , channelModifiedAtLens
  , channelNameLens
  , channelShareUrlLens
  , channelTypeLens
  , channelWebsiteLens
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
  { channelCreatedAt :: Time.UTCTime
  , channelId :: ChannelId.ChannelId
  , channelLinks :: ChannelLinks.ChannelLinks
  , channelModifiedAt :: Time.UTCTime
  , channelName :: Text.Text
  , channelShareUrl :: Url.Url
  , channelType :: Text.Text -- TODO
  , channelWebsite :: Url.Url
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

channelCreatedAtLens :: Lens.Lens' Channel Time.UTCTime
channelCreatedAtLens = Lens.lens channelCreatedAt
  $ \channel createdAt -> channel { channelCreatedAt = createdAt }

channelIdLens :: Lens.Lens' Channel ChannelId.ChannelId
channelIdLens =
  Lens.lens channelId $ \channel id_ -> channel { channelId = id_ }

channelLinksLens :: Lens.Lens' Channel ChannelLinks.ChannelLinks
channelLinksLens =
  Lens.lens channelLinks $ \channel links -> channel { channelLinks = links }

channelModifiedAtLens :: Lens.Lens' Channel Time.UTCTime
channelModifiedAtLens = Lens.lens channelModifiedAt
  $ \channel modifiedAt -> channel { channelModifiedAt = modifiedAt }

channelNameLens :: Lens.Lens' Channel Text.Text
channelNameLens =
  Lens.lens channelName $ \channel name -> channel { channelName = name }

channelShareUrlLens :: Lens.Lens' Channel Url.Url
channelShareUrlLens = Lens.lens channelShareUrl
  $ \channel shareUrl -> channel { channelShareUrl = shareUrl }

channelTypeLens :: Lens.Lens' Channel Text.Text
channelTypeLens =
  Lens.lens channelType $ \channel type_ -> channel { channelType = type_ }

channelWebsiteLens :: Lens.Lens' Channel Url.Url
channelWebsiteLens = Lens.lens channelWebsite
  $ \channel website -> channel { channelWebsite = website }
