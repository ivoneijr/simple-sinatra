require 'sinatra'
require "sinatra/reloader" if development?
require 'json'

# require_relative 'jsodbc'

# include JSODBC

use Rack::Deflater
use Rack::Cors do |config|
  config.allow do |allow|
    allow.origins '*'
    allow.resource '*', methods: [:get], headers: :any
  end
end

require_relative 'app/models/statement'
require_relative 'app/models/parameter'

# post '/api/statements' do
#   data = JSON.parse(request.body.gets, symbolize_names: true)
#   statement = Statement.new data[:statement]
#   statement.prepare
#   status 200
#   headers['Content-Type'] = 'application/json'
#   json = JSODBC::execute('DSN=atlas;', statement.sql, statement.limit, statement.offset, statement.extended)
#   headers['Cache-Control'] = 'no-transform' if json.bytesize < 512
#   body json
# end

# post '/api/aggregations' do
#   data = JSON.parse(request.body.gets, symbolize_names: true)
#   statements = data[:aggregation][:statements]
#   results = []
#   data[:aggregation][:operations].each do |operation|
#     case operation[:type]
#       when "execution"
#         index = operation[:parameters][0]
#         statement = Statement.new statements[index]
#         statement.prepare
#         results[index] = JSON.parse(JSODBC::execute('DSN=atlas;',statement.sql, statement.limit, statement.offset, statement.extended), symbolize_names: true)
#       when "script"
#         eval(operation[:parameters][0])
#     end
#   end
#   result = eval(data[:aggregation][:result])
#   body JSON.generate(result)
#   headers['Content-Type'] = 'application/json'
#   status 200
# end

# get '/api/schema' do
#   status 200
#   headers['Content-Type'] = 'application/json'
#   json = JSODBC::get_schema('DSN=atlas;','',false)
#   body json
# end

# get '/api/schema/extended' do
#   status 200
#   headers['Content-Type'] = 'application/json'
#   json = JSODBC::get_schema('DSN=atlas;','',true)
#   body json
# end

get '/ping' do
  status 200
  headers['Content-Type'] = 'application/json'
  body '{"status":true}'
end

# get '/api/resources/search' do
#   if params[:query] =~ /^[\s|\n|\t|\r]*SELECT\b/i
#     limit = params[:limit] ? params[:limit].to_i : 0
#     offset = params[:offset] ? params[:offset].to_i : 0
#     extended = params[:extended] ? !!params[:extended] : false
#     status 200
#     headers['Content-Type'] = 'application/json'
#     p params[:query]
#     json = JSODBC::execute('DSN=atlas;',params[:query], limit, offset, extended)
#     headers['Cache-Control'] = 'no-transform' if json.bytesize < 512
#     body json
#   else
#     status 422
#   end
# end