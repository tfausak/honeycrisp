module Honeycrisp.Type.Warning
  ( Warning
  , warningKeyPath
  , warningMessage
  , warningValue
  )
where

import qualified Data.Aeson as Aeson
import qualified Data.Text as Text
import qualified Lens.Micro as Lens

data Warning = Warning
  { warning_keyPath :: [Text.Text]
  , warning_message :: Text.Text
  , warning_value :: Text.Text
  } deriving (Eq, Show)

instance Aeson.FromJSON Warning where
  parseJSON = Aeson.withObject "Warning" $ \object -> Warning
    <$> object Aeson..: Text.pack "keyPath"
    <*> object Aeson..: Text.pack "message"
    <*> object Aeson..: Text.pack "value"

warningKeyPath :: Lens.Lens' Warning [Text.Text]
warningKeyPath = Lens.lens warning_keyPath
  $ \warning keyPath -> warning { warning_keyPath = keyPath }

warningMessage :: Lens.Lens' Warning Text.Text
warningMessage = Lens.lens warning_message
  $ \warning message -> warning { warning_message = message }

warningValue :: Lens.Lens' Warning Text.Text
warningValue =
  Lens.lens warning_value $ \warning value -> warning { warning_value = value }
