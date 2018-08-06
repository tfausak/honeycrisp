module Honeycrisp.Type.Section
  ( Section
  , sectionCreatedAt
  , sectionId
  , sectionLinks
  , sectionIsDefault
  , sectionModifiedAt
  , sectionName
  , sectionShareUrl
  , sectionType
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Data.Time as Time
import qualified Honeycrisp.Type.SectionId as SectionId
import qualified Honeycrisp.Type.SectionLinks as SectionLinks
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens

data Section = Section
  { section_createdAt :: Time.UTCTime
  , section_id :: SectionId.SectionId
  , section_links :: SectionLinks.SectionLinks
  , section_isDefault :: Bool
  , section_modifiedAt :: Time.UTCTime
  , section_name :: Text.Text
  , section_shareUrl :: Url.Url
  , section_type :: Text.Text -- TODO
  } deriving (Eq, Show)

instance Aeson.FromJSON Section where
  parseJSON = Aeson.withObject "Section" $ \object ->
    Section
      <$> object
      Aeson..: Text.pack "createdAt"
      <*> object
      Aeson..: Text.pack "id"
      <*> object
      Aeson..: Text.pack "links"
      <*> object
      Aeson..: Text.pack "isDefault"
      <*> object
      Aeson..: Text.pack "modifiedAt"
      <*> object
      Aeson..: Text.pack "name"
      <*> object
      Aeson..: Text.pack "shareUrl"
      <*> object
      Aeson..: Text.pack "type"

sectionCreatedAt :: Lens.Lens' Section Time.UTCTime
sectionCreatedAt = Lens.lens section_createdAt
  $ \section createdAt -> section { section_createdAt = createdAt }

sectionId :: Lens.Lens' Section SectionId.SectionId
sectionId =
  Lens.lens section_id $ \section id_ -> section { section_id = id_ }

sectionLinks :: Lens.Lens' Section SectionLinks.SectionLinks
sectionLinks =
  Lens.lens section_links $ \section links -> section { section_links = links }

sectionIsDefault :: Lens.Lens' Section Bool
sectionIsDefault = Lens.lens section_isDefault
  $ \section isDefault -> section { section_isDefault = isDefault }

sectionModifiedAt :: Lens.Lens' Section Time.UTCTime
sectionModifiedAt = Lens.lens section_modifiedAt
  $ \section modifiedAt -> section { section_modifiedAt = modifiedAt }

sectionName :: Lens.Lens' Section Text.Text
sectionName =
  Lens.lens section_name $ \section name -> section { section_name = name }

sectionShareUrl :: Lens.Lens' Section Url.Url
sectionShareUrl = Lens.lens section_shareUrl
  $ \section shareUrl -> section { section_shareUrl = shareUrl }

sectionType :: Lens.Lens' Section Text.Text
sectionType =
  Lens.lens section_type $ \section type_ -> section { section_type = type_ }
