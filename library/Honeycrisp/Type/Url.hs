module Honeycrisp.Type.Url
  ( Url
  , uriToUrl
  , urlToUri
  , stringToUrl
  , urlToString
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

urlToString :: Url -> String
urlToString url =
  let
    uri = urlToUri url
    scheme = Uri.uriScheme uri
  in scheme
    <> case Uri.uriAuthority uri of
         Nothing -> ""
         Just authority ->
           "//"
             <> Uri.uriUserInfo authority
             <> Uri.uriRegName authority
             <> case (scheme, Uri.uriPort authority) of
                  ("http:", ":80") -> ""
                  ("https:", ":443") -> ""
                  (_, port) -> port
    <> Uri.uriPath uri
    <> Uri.uriQuery uri
    <> Uri.uriFragment uri
