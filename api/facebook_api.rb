require 'faraday'

class FacebookApi

  attr_reader :conn

  URL = 'https://takehome.io/facebook'
  GENERIC_ERROR_MESSAGE = 'There was an unknown problem retrieving statuses. Please try again later'

  def initialize(conn)
    @conn = conn
  end

  def statuses
    begin
      response = @conn.get(URL)
      return { statuses: JSON.parse(response.body) }

    rescue Faraday::ServerError => e
      return { error: GENERIC_ERROR_MESSAGE }
    end
  end
end