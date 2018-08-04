module Honeycrisp.Type.Url
  ( Url
  , uriToUrl
  , urlToUri
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
