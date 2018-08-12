module Honeycrisp.Api.Helper
  ( createRequest
  , performRequest
  )
where

import qualified Crypto.Hash as Crypto
import qualified Crypto.MAC.HMAC as Crypto
import qualified Data.Aeson as Aeson
import qualified Data.ByteArray.Encoding as Memory
import qualified Data.ByteString as ByteString
import qualified Data.ByteString.Builder as Builder
import qualified Data.ByteString.Lazy as LazyByteString
import qualified Data.IORef as IORef
import qualified Data.Maybe as Maybe
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import qualified Data.Time as Time
import qualified Data.UUID as Uuid
import qualified Honeycrisp.Type.Config as Config
import qualified Honeycrisp.Type.KeyId as KeyId
import qualified Honeycrisp.Type.KeySecret as KeySecret
import qualified Honeycrisp.Type.Response as Response
import qualified Honeycrisp.Type.Url as Url
import qualified Honeycrisp.Version as Version
import qualified Lens.Micro.Extras as Lens
import qualified Network.HTTP.Client as Client
import qualified Network.HTTP.Types as Http
import qualified Network.URI as Uri

createRequest :: Config.Config -> String -> IO Client.Request
createRequest config path = do
  request <-
    Client.requestFromURI
    . Uri.relativeTo Uri.nullURI { Uri.uriPath = path }
    . Url.urlToUri
    $ Lens.view Config.configBaseUrl config
  pure request
    { Client.checkResponse = Client.throwErrorStatusCodes
    , Client.requestHeaders = [(Http.hUserAgent, userAgent)]
    }

userAgent :: ByteString.ByteString
userAgent = toUtf8 $ "honeycrisp-" <> Version.versionString

performRequest
  :: Aeson.FromJSON a
  => Config.Config
  -> Client.Manager
  -> Client.Request
  -> IO a
performRequest config manager request = do
  response <- httpRequest
    manager
    (Lens.view Config.configKeyId config)
    (Lens.view Config.configKeySecret config)
    request
  either fail (pure . Response.fromResponse)
    . Aeson.eitherDecode
    $ Client.responseBody response

httpRequest
  :: Client.Manager
  -> KeyId.KeyId
  -> KeySecret.KeySecret
  -> Client.Request
  -> IO (Client.Response LazyByteString.ByteString)
httpRequest manager keyId keySecret request = do
  authorizedRequest <- authorizeRequest keyId keySecret request
  Client.httpLbs authorizedRequest manager

authorizeRequest
  :: KeyId.KeyId -> KeySecret.KeySecret -> Client.Request -> IO Client.Request
authorizeRequest keyId keySecret request = do
  now <- Time.getCurrentTime
  body <- bodyToBytes $ Client.requestBody request
  let message = toMessage request body now
  let authorization = toAuthorization keyId keySecret message now
  pure request
    { Client.requestHeaders = withAuthorization authorization
      $ Client.requestHeaders request
    , Client.requestBody = Client.RequestBodyBS body
    }

withAuthorization
  :: ByteString.ByteString -> Http.RequestHeaders -> Http.RequestHeaders
withAuthorization authorization headers =
  (Http.hAuthorization, authorization) : headers

toAuthorization
  :: KeyId.KeyId
  -> KeySecret.KeySecret
  -> ByteString.ByteString
  -> Time.UTCTime
  -> ByteString.ByteString
toAuthorization keyId keySecret message time =
  toUtf8 "HHMAC; key=\""
    <> Uuid.toASCIIBytes (KeyId.keyIdToUuid keyId)
    <> toUtf8 "\"; signature=\""
    <> toBase64 (hmac keySecret message)
    <> toUtf8 "\"; date=\""
    <> toUtf8 (formatTime time)
    <> toUtf8 "\""

toMessage
  :: Client.Request
  -> ByteString.ByteString
  -> Time.UTCTime
  -> ByteString.ByteString
toMessage request body time =
  Client.method request
    <> toUtf8 (Url.urlToString . Url.uriToUrl $ Client.getUri request)
    <> toUtf8 (formatTime time)
    <> if Client.method request == Http.methodPost
         then
           (Maybe.fromMaybe ByteString.empty
             . lookup Http.hContentType
             $ Client.requestHeaders request
             )
             <> body
         else ByteString.empty

toBase64 :: Crypto.HMAC Crypto.SHA256 -> ByteString.ByteString
toBase64 = Memory.convertToBase Memory.Base64

hmac
  :: KeySecret.KeySecret -> ByteString.ByteString -> Crypto.HMAC Crypto.SHA256
hmac = Crypto.hmac . KeySecret.keySecretToByteString

formatTime :: Time.UTCTime -> String
formatTime = Time.formatTime Time.defaultTimeLocale "%FT%XZ"

toUtf8 :: String -> ByteString.ByteString
toUtf8 = Text.encodeUtf8 . Text.pack

bodyToBytes :: Client.RequestBody -> IO ByteString.ByteString
bodyToBytes body = case body of
  Client.RequestBodyBS byteString -> pure byteString
  Client.RequestBodyBuilder _ builder -> pure $ builderToByteString builder
  Client.RequestBodyIO getBody -> do
    newBody <- getBody
    bodyToBytes newBody
  Client.RequestBodyLBS lazyByteString ->
    pure $ LazyByteString.toStrict lazyByteString
  Client.RequestBodyStream _ givesPopper -> takesPopper givesPopper
  Client.RequestBodyStreamChunked givesPopper -> takesPopper givesPopper

builderToByteString :: Builder.Builder -> ByteString.ByteString
builderToByteString = LazyByteString.toStrict . Builder.toLazyByteString

takesPopper :: Client.GivesPopper () -> IO ByteString.ByteString
takesPopper givesPopper = do
  ref <- IORef.newIORef mempty
  givesPopper $ needsPopperWith ref
  builderToByteString <$> IORef.readIORef ref

needsPopperWith :: IORef.IORef Builder.Builder -> Client.NeedsPopper ()
needsPopperWith ref popper = do
  chunk <- popper
  if ByteString.null chunk
    then pure ()
    else do
      IORef.modifyIORef' ref (<> Builder.byteString chunk)
      needsPopperWith ref popper
