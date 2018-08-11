module Honeycrisp.Api.Section
  ( getChannelSections
  , getSection
  )
where

import qualified Data.UUID as Uuid
import qualified Honeycrisp.Api.Request as Request
import qualified Honeycrisp.Type.ChannelId as ChannelId
import qualified Honeycrisp.Type.Config as Config
import qualified Honeycrisp.Type.Section as Section
import qualified Honeycrisp.Type.SectionId as SectionId
import qualified Network.HTTP.Client as Client

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
