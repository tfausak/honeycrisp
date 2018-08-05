module Honeycrisp.Type.Config
  ( Config
  , getConfig
  , configBaseUrlLens
  , configKeyIdLens
  , configKeySecretLens
  )
where

import qualified Data.Maybe as Maybe
import qualified Honeycrisp.Type.KeyId as KeyId
import qualified Honeycrisp.Type.KeySecret as KeySecret
import qualified Honeycrisp.Type.Url as Url
import qualified Lens.Micro as Lens
import qualified System.Environment as Environment

data Config = Config
  { configBaseUrl :: Url.Url
  , configKeyId :: KeyId.KeyId
  , configKeySecret :: KeySecret.KeySecret
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

configBaseUrlLens :: Lens.Lens' Config Url.Url
configBaseUrlLens = Lens.lens configBaseUrl
  $ \config baseUrl -> config { configBaseUrl = baseUrl }

configKeyIdLens :: Lens.Lens' Config KeyId.KeyId
configKeyIdLens =
  Lens.lens configKeyId $ \config keyId -> config { configKeyId = keyId }

configKeySecretLens :: Lens.Lens' Config KeySecret.KeySecret
configKeySecretLens = Lens.lens configKeySecret
  $ \config keySecret -> config { configKeySecret = keySecret }
