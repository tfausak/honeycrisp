module Honeycrisp.Type.ArticleLinks
  ( ArticleLinks
  , articleLinksChannel
  , articleLinksSections
  , articleLinksSelf
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

-- | <https://developer.apple.com/documentation/apple_news/articlelinks>
data ArticleLinks = ArticleLinks
  { articleLinks_channel :: Url.Url
  , articleLinks_sections :: [Url.Url]
  , articleLinks_self :: Url.Url
  } deriving (Eq, Show)

instance Aeson.FromJSON ArticleLinks where
  parseJSON = Aeson.withObject "ArticleLinks" $ \object -> ArticleLinks
    <$> object Aeson..: Text.pack "channel"
    <*> object Aeson..: Text.pack "sections"
    <*> object Aeson..: Text.pack "self"

articleLinksChannel :: Lens.Lens' ArticleLinks Url.Url
articleLinksChannel = Lens.lens articleLinks_channel
  $ \articleLinks channel -> articleLinks { articleLinks_channel = channel }

articleLinksSections :: Lens.Lens' ArticleLinks [Url.Url]
articleLinksSections =
  Lens.lens articleLinks_sections $ \articleLinks sections ->
    articleLinks { articleLinks_sections = sections }

articleLinksSelf :: Lens.Lens' ArticleLinks Url.Url
articleLinksSelf = Lens.lens articleLinks_self
  $ \articleLinks self -> articleLinks { articleLinks_self = self }
