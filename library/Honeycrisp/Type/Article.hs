module Honeycrisp.Type.Article
  ( Article
  , articleAccessoryText
  , articleCreatedAt
  , articleDocument
  , articleId
  , articleIsCandidateToBeFeatured
  , articleIsPreview
  , articleIsSponsored
  , articleLinks
  , articleMaturityRating
  , articleModifiedAt
  , articleRevision
  , articleShareUrl
  , articleState
  , articleTitle
  , articleType
  , articleWarnings
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Data.Time as Time
import qualified Honeycrisp.Type.ArticleId as ArticleId
import qualified Honeycrisp.Type.ArticleLinks as ArticleLinks
import qualified Honeycrisp.Type.Url as Url
import qualified Honeycrisp.Type.Warning as Warning
import qualified Lens.Micro as Lens

data Article = Article
  { article_accessoryText :: Text.Text
  , article_createdAt :: Time.UTCTime
  , article_document :: Aeson.Value -- TODO
  , article_id :: ArticleId.ArticleId
  , article_isCandidateToBeFeatured :: Bool
  , article_isPreview :: Bool
  , article_isSponsored :: Bool
  , article_links :: ArticleLinks.ArticleLinks
  , article_maturityRating :: Maybe Text.Text
  , article_modifiedAt :: Time.UTCTime
  , article_revision :: Text.Text
  , article_shareUrl :: Url.Url
  , article_state :: Text.Text
  , article_title :: Text.Text
  , article_type :: Text.Text
  , article_warnings :: [Warning.Warning]
  } deriving (Eq, Show)

instance Aeson.FromJSON Article where
  parseJSON = Aeson.withObject "Article" $ \object -> Article
    <$> object Aeson..: Text.pack "accessoryText"
    <*> object Aeson..: Text.pack "createdAt"
    <*> object Aeson..: Text.pack "document"
    <*> object Aeson..: Text.pack "id"
    <*> object Aeson..: Text.pack "isCandidateToBeFeatured"
    <*> object Aeson..: Text.pack "isPreview"
    <*> object Aeson..: Text.pack "isSponsored"
    <*> object Aeson..: Text.pack "links"
    <*> object Aeson..: Text.pack "maturityRating"
    <*> object Aeson..: Text.pack "modifiedAt"
    <*> object Aeson..: Text.pack "revision"
    <*> object Aeson..: Text.pack "shareUrl"
    <*> object Aeson..: Text.pack "state"
    <*> object Aeson..: Text.pack "title"
    <*> object Aeson..: Text.pack "type"
    <*> object Aeson..: Text.pack "warnings"

articleAccessoryText :: Lens.Lens' Article Text.Text
articleAccessoryText =
  Lens.lens article_accessoryText $ \article accessoryText ->
    article { article_accessoryText = accessoryText }

articleCreatedAt :: Lens.Lens' Article Time.UTCTime
articleCreatedAt = Lens.lens article_createdAt
  $ \article createdAt -> article { article_createdAt = createdAt }

articleDocument :: Lens.Lens' Article Aeson.Value
articleDocument = Lens.lens article_document
  $ \article document -> article { article_document = document }

articleId :: Lens.Lens' Article ArticleId.ArticleId
articleId =
  Lens.lens article_id $ \article id_ -> article { article_id = id_ }

articleIsCandidateToBeFeatured :: Lens.Lens' Article Bool
articleIsCandidateToBeFeatured =
  Lens.lens article_isCandidateToBeFeatured
    $ \article isCandidateToBeFeatured ->
        article { article_isCandidateToBeFeatured = isCandidateToBeFeatured }

articleIsPreview :: Lens.Lens' Article Bool
articleIsPreview = Lens.lens article_isPreview
  $ \article isPreview -> article { article_isPreview = isPreview }

articleIsSponsored :: Lens.Lens' Article Bool
articleIsSponsored = Lens.lens article_isSponsored
  $ \article isSponsored -> article { article_isSponsored = isSponsored }

articleLinks :: Lens.Lens' Article ArticleLinks.ArticleLinks
articleLinks =
  Lens.lens article_links $ \article links -> article { article_links = links }

articleMaturityRating :: Lens.Lens' Article (Maybe Text.Text)
articleMaturityRating =
  Lens.lens article_maturityRating $ \article maturityRating ->
    article { article_maturityRating = maturityRating }

articleModifiedAt :: Lens.Lens' Article Time.UTCTime
articleModifiedAt = Lens.lens article_modifiedAt
  $ \article modifiedAt -> article { article_modifiedAt = modifiedAt }

articleRevision :: Lens.Lens' Article Text.Text
articleRevision = Lens.lens article_revision
  $ \article revision -> article { article_revision = revision }

articleShareUrl :: Lens.Lens' Article Url.Url
articleShareUrl = Lens.lens article_shareUrl
  $ \article shareUrl -> article { article_shareUrl = shareUrl }

articleState :: Lens.Lens' Article Text.Text
articleState =
  Lens.lens article_state $ \article state -> article { article_state = state }

articleTitle :: Lens.Lens' Article Text.Text
articleTitle =
  Lens.lens article_title $ \article title -> article { article_title = title }

articleType :: Lens.Lens' Article Text.Text
articleType =
  Lens.lens article_type $ \article type_ -> article { article_type = type_ }

articleWarnings :: Lens.Lens' Article [Warning.Warning]
articleWarnings = Lens.lens article_warnings
  $ \article warnings -> article { article_warnings = warnings }
