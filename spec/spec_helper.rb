require 'dotenv'
Dotenv.load

require "uri"
require "net/http"
require "json"
require 'simplecov'
require 'base64'

SimpleCov.start do
  add_filter "spec"
end
