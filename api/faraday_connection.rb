require 'faraday'

module FaradayConnection
  def obtain_connection
    client = Faraday.new do |client|
      client.response :raise_error
    end
  end
end