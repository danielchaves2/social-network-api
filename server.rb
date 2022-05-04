require 'sinatra'
require_relative 'api/social_networks_api'
require 'faraday'

set :port, 3000

get '/' do
  SocialNetworksApi.new.highlights
end