require_relative 'facebook_api'
require_relative 'twitter_api'
require_relative 'instagram_api'
require_relative 'faraday_connection'

class SocialNetworksApi

    attr_reader :facebook, :twitter, :instagram

    include FaradayConnection

    def initialize
        @conn = obtain_connection
        @facebook  = FacebookApi.new(@conn)
        @twitter   = TwitterApi.new(@conn)
        @instagram = InstagramApi.new(@conn)
    end

    def highlights

        return {
                 facebook: @facebook.statuses,
                 twitter: @twitter.tweets,
                 instagram: @instagram.photos 
               }.to_json

    end
end