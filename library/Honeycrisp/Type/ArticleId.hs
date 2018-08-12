module Honeycrisp.Type.ArticleId
  ( ArticleId
  , uuidToArticleId
  , articleIdToUuid
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.UUID as Uuid

newtype ArticleId
  = ArticleId Uuid.UUID
  deriving Eq

instance Aeson.FromJSON ArticleId where
  parseJSON = fmap uuidToArticleId . Aeson.parseJSON

instance Aeson.ToJSON ArticleId where
  toJSON = Aeson.toJSON . articleIdToUuid

instance Show ArticleId where
  show = show . Uuid.toString . articleIdToUuid

uuidToArticleId :: Uuid.UUID -> ArticleId
uuidToArticleId = ArticleId

articleIdToUuid :: ArticleId -> Uuid.UUID
articleIdToUuid (ArticleId uuid) = uuid
