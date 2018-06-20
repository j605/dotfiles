{-# LANGUAGE OverloadedStrings #-}
import Data.Conduit.Binary
import Data.List
import qualified Data.ByteString.Lazy as LBS
import qualified Data.ByteString.UTF8 as UTF8
import Network.HTTP.Simple
import Network.HTTP.Client.Conduit
import Network.HTTP.Client.MultipartFormData
import System.Environment
import System.IO

main = do
    req  <- parseRequest "POST https://0x0.st"
    args <- getArgs
    body <- case args of
          [url] | "http" `isPrefixOf` url -> return $ partBS "url" (UTF8.fromString url)

          [file] -> return $ partFileSource "file" file

          [] -> partFileRequestBody "file" "stdin.txt" . RequestBodyLBS <$> LBS.getContents

          _ -> error "Invalid usage!"

    flip httpSink (\_ -> sinkHandle stdout) =<< formDataBody [body] req
