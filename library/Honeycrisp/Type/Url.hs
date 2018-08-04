module Honeycrisp.Type.Url
  ( Url
  , uriToUrl
  , urlToUri
  , stringToUrl
  )
where

import qualified Network.URI as Uri

newtype Url
  = Url Uri.URI
  deriving (Eq, Show)

uriToUrl :: Uri.URI -> Url
uriToUrl = Url

urlToUri :: Url -> Uri.URI
urlToUri (Url uri) = uri

stringToUrl :: String -> Either String Url
stringToUrl string =
  maybe (Left $ "invalid Url: " <> show string) (Right . uriToUrl)
    $ Uri.parseAbsoluteURI string
