module Honeycrisp.Type.PromotedArticles
  ( PromotedArticles
  , toPromotedArticles
  , fromPromotedArticles
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Honeycrisp.Type.ArticleId as ArticleId

newtype PromotedArticles
  = PromotedArticles [ArticleId.ArticleId]
  deriving Eq

instance Aeson.FromJSON PromotedArticles where
  parseJSON = Aeson.withObject "PromotedArticles" $ \object ->
    toPromotedArticles <$> object Aeson..: Text.pack "promotedArticles"

instance Show PromotedArticles where
  show = show . fromPromotedArticles

instance Aeson.ToJSON PromotedArticles where
  toJSON promotedArticles = Aeson.object
    [Text.pack "promotedArticles" Aeson..= fromPromotedArticles promotedArticles]

toPromotedArticles :: [ArticleId.ArticleId] -> PromotedArticles
toPromotedArticles = PromotedArticles

fromPromotedArticles :: PromotedArticles -> [ArticleId.ArticleId]
fromPromotedArticles (PromotedArticles articleIds) = articleIds
