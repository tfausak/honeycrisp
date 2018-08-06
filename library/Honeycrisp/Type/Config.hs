module Honeycrisp.Type.Config
  ( Config
  , getConfig
  , configBaseUrl
  , configKeyId
  , configKeySecret
  )
where

import qualified Data.Maybe as Maybe
import qualified Honeycrisp.Type.KeyId as KeyId
import qualified Honeycrisp.Type.KeySecret as KeySecret
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens
import qualified System.Environment as Environment

data Config = Config
  { config_baseUrl :: Url.Url
  , config_keyId :: KeyId.KeyId
  , config_keySecret :: KeySecret.KeySecret
  } deriving (Eq, Show)

getConfig :: IO Config
getConfig = Config <$> getBaseUrl <*> getKeyId <*> getKeySecret

getBaseUrl :: IO Url.Url
getBaseUrl = do
  maybeString <- Environment.lookupEnv "HONEYCRISP_BASE_URL"
  either fail pure . Url.stringToUrl $ Maybe.fromMaybe
    "https://news-api.apple.com"
    maybeString

getKeyId :: IO KeyId.KeyId
getKeyId = do
  string <- Environment.getEnv "HONEYCRISP_KEY_ID"
  either fail pure $ KeyId.stringToKeyId string

getKeySecret :: IO KeySecret.KeySecret
getKeySecret = do
  string <- Environment.getEnv "HONEYCRISP_KEY_SECRET"
  either fail pure $ KeySecret.stringToKeySecret string

configBaseUrl :: Lens.Lens' Config Url.Url
configBaseUrl = Lens.lens config_baseUrl
  $ \config baseUrl -> config { config_baseUrl = baseUrl }

configKeyId :: Lens.Lens' Config KeyId.KeyId
configKeyId =
  Lens.lens config_keyId $ \config keyId -> config { config_keyId = keyId }

configKeySecret :: Lens.Lens' Config KeySecret.KeySecret
configKeySecret = Lens.lens config_keySecret
  $ \config keySecret -> config { config_keySecret = keySecret }
