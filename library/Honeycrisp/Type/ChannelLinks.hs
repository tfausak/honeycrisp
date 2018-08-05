module Honeycrisp.Type.ChannelLinks
  ( ChannelLinks
  , channelLinksDefaultSectionLens
  , channelLinksSelfLens
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

-- | <https://developer.apple.com/documentation/apple_news/channellinks>
data ChannelLinks = ChannelLinks
  { channelLinksDefaultSection :: Url.Url
  , channelLinksSelf :: Url.Url
  } deriving (Eq, Show)

instance Aeson.FromJSON ChannelLinks where
  parseJSON = Aeson.withObject "ChannelLinks" $ \object ->
    ChannelLinks
      <$> object
      Aeson..: Text.pack "defaultSection"
      <*> object
      Aeson..: Text.pack "self"

channelLinksDefaultSectionLens :: Lens.Lens' ChannelLinks Url.Url
channelLinksDefaultSectionLens =
  Lens.lens channelLinksDefaultSection $ \channelLinks defaultSection ->
    channelLinks { channelLinksDefaultSection = defaultSection }

channelLinksSelfLens :: Lens.Lens' ChannelLinks Url.Url
channelLinksSelfLens = Lens.lens channelLinksSelf
  $ \channelLinks self -> channelLinks { channelLinksSelf = self }
