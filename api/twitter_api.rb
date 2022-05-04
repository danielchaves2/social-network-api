require 'faraday'

class TwitterApi

  attr_reader :conn

  URL = 'https://takehome.io/twitter'
  GENERIC_ERROR_MESSAGE = 'There was an unknown problem retrieving tweets. Please try again later'

  def initialize(conn)
    @conn = conn
  end

  def tweets
    begin
      response = @conn.get(URL)
      return { tweets: JSON.parse(response.body) }

    rescue Faraday::ServerError => e
      return { error: GENERIC_ERROR_MESSAGE }
    end
  end
end