require 'faraday'

class InstagramApi

  attr_reader :conn

  URL = 'https://takehome.io/instagram'
  GENERIC_ERROR_MESSAGE = 'There was an unknown problem retrieving photos. Please try again later'

  def initialize(conn)
    @conn = conn
  end

  def photos
    begin
      response = @conn.get(URL)
      return { photos: JSON.parse(response.body) }

    rescue Faraday::ServerError => e
      return { error: GENERIC_ERROR_MESSAGE }
    end
  end
end