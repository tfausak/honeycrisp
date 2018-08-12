module Honeycrisp.Api.Article
  ( getArticle
  , deleteArticle
  )
where

import qualified Data.UUID as Uuid
import qualified Honeycrisp.Api.Helper as Helper
import qualified Honeycrisp.Type.Article as Article
import qualified Honeycrisp.Type.ArticleId as ArticleId
import qualified Honeycrisp.Type.Config as Config
import qualified Network.HTTP.Client as Client
import qualified Network.HTTP.Types as Http

-- | <https://developer.apple.com/documentation/apple_news/read_article_information>
getArticle
  :: Config.Config
  -> Client.Manager
  -> ArticleId.ArticleId
  -> IO Article.Article
getArticle config manager articleId = do
  request <- Helper.createRequest config $ "articles/" <> Uuid.toString
    (ArticleId.articleIdToUuid articleId)
  Helper.performRequest config manager request

-- | <https://developer.apple.com/documentation/apple_news/delete_an_article>
deleteArticle
  :: Config.Config -> Client.Manager -> ArticleId.ArticleId -> IO ()
deleteArticle config manager articleId = do
  initialRequest <- Helper.createRequest config $ "articles/" <> Uuid.toString
    (ArticleId.articleIdToUuid articleId)
  let request = initialRequest { Client.method = Http.methodDelete }
  Helper.performRequest config manager request
