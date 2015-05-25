require 'sinatra'
require "sinatra/reloader" if development?
require 'json'

use Rack::Deflater
use Rack::Cors do |config|
  config.allow do |allow|
    allow.origins '*'
    allow.resource '*', methods: [:get], headers: :any
  end
end

get '/ping' do
  status 200
  headers['Content-Type'] = 'application/json'
  body '{"status":true}'
end
