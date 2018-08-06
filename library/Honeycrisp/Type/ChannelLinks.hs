module Honeycrisp.Type.ChannelLinks
  ( ChannelLinks
  , channelLinksDefaultSection
  , channelLinksSelf
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

-- | <https://developer.apple.com/documentation/apple_news/channellinks>
data ChannelLinks = ChannelLinks
  { channelLinks_defaultSection :: Url.Url
  , channelLinks_self :: Url.Url
  } deriving (Eq, Show)

instance Aeson.FromJSON ChannelLinks where
  parseJSON = Aeson.withObject "ChannelLinks" $ \object ->
    ChannelLinks
      <$> object
      Aeson..: Text.pack "defaultSection"
      <*> object
      Aeson..: Text.pack "self"

channelLinksDefaultSection :: Lens.Lens' ChannelLinks Url.Url
channelLinksDefaultSection =
  Lens.lens channelLinks_defaultSection $ \channelLinks defaultSection ->
    channelLinks { channelLinks_defaultSection = defaultSection }

channelLinksSelf :: Lens.Lens' ChannelLinks Url.Url
channelLinksSelf = Lens.lens channelLinks_self
  $ \channelLinks self -> channelLinks { channelLinks_self = self }
