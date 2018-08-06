module Honeycrisp.Type.SectionLinks
  ( SectionLinks
  , sectionLinksChannel
  , sectionLinksSelf
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

data SectionLinks = SectionLinks
  { sectionLinks_channel :: Url.Url
  , sectionLinks_self :: Url.Url
  } deriving (Eq, Show)

instance Aeson.FromJSON SectionLinks where
  parseJSON = Aeson.withObject "SectionLinks" $ \object ->
    SectionLinks
      <$> object
      Aeson..: Text.pack "channel"
      <*> object
      Aeson..: Text.pack "self"

sectionLinksChannel :: Lens.Lens' SectionLinks Url.Url
sectionLinksChannel = Lens.lens sectionLinks_channel
  $ \sectionLinks channel -> sectionLinks { sectionLinks_channel = channel }

sectionLinksSelf :: Lens.Lens' SectionLinks Url.Url
sectionLinksSelf = Lens.lens sectionLinks_self
  $ \sectionLinks self -> sectionLinks { sectionLinks_self = self }
