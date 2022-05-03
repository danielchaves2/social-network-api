require 'faraday'

module FaradayConnection
    def obtain_connection
        conn = Faraday.new do |conn|
            conn.response :raise_error
        end
    end
end