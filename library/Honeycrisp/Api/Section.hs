module Honeycrisp.Api.Section
  ( getChannelSections
  , getSection
  , promoteSectionArticles
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.UUID as Uuid
import qualified Honeycrisp.Api.Request as Request
import qualified Honeycrisp.Type.ChannelId as ChannelId
import qualified Honeycrisp.Type.Config as Config
import qualified Honeycrisp.Type.PromotedArticles as PromotedArticles
import qualified Honeycrisp.Type.Request as Request
import qualified Honeycrisp.Type.Section as Section
import qualified Honeycrisp.Type.SectionId as SectionId
import qualified Network.HTTP.Client as Client
import qualified Network.HTTP.Types as Http

-- | <https://developer.apple.com/documentation/apple_news/list_all_sections>
getChannelSections
  :: Config.Config
  -> Client.Manager
  -> ChannelId.ChannelId
  -> IO [Section.Section]
getChannelSections config manager channelId = do
  request <-
    Request.createRequest config
    $ "channels/"
    <> Uuid.toString (ChannelId.channelIdToUuid channelId)
    <> "/sections"
  Request.performRequest config manager request

-- | <https://developer.apple.com/documentation/apple_news/read_section_information>
getSection
  :: Config.Config
  -> Client.Manager
  -> SectionId.SectionId
  -> IO Section.Section
getSection config manager sectionId = do
  request <- Request.createRequest config $ "sections/" <> Uuid.toString
    (SectionId.sectionIdToUuid sectionId)
  Request.performRequest config manager request

-- | <https://developer.apple.com/documentation/apple_news/promote_articles_in_a_section>
promoteSectionArticles
  :: Config.Config
  -> Client.Manager
  -> SectionId.SectionId
  -> PromotedArticles.PromotedArticles
  -> IO PromotedArticles.PromotedArticles
promoteSectionArticles config manager sectionId promotedArticles = do
  initialRequest <-
    Request.createRequest config
    $ "sections/"
    <> Uuid.toString (SectionId.sectionIdToUuid sectionId)
    <> "/promotedArticles"
  let
    request = initialRequest
      { Client.method = Http.methodPost
      , Client.requestBody =
        Client.RequestBodyLBS . Aeson.encode $ Request.toRequest
          promotedArticles
      }
  Request.performRequest config manager request
