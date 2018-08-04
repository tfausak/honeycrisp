module Honeycrisp.Type.SectionId
  ( SectionId
  , uuidToSectionId
  , sectionIdToUuid
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.UUID as Uuid

newtype SectionId
  = SectionId Uuid.UUID
  deriving (Eq, Show)

instance Aeson.FromJSON SectionId where
  parseJSON = fmap uuidToSectionId . Aeson.parseJSON

uuidToSectionId :: Uuid.UUID -> SectionId
uuidToSectionId = SectionId

sectionIdToUuid :: SectionId -> Uuid.UUID
sectionIdToUuid (SectionId uuid) = uuid
