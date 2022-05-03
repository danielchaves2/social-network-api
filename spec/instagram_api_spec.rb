require 'spec_helper'
require_relative '../api/instagram_api'

describe InstagramApi do
    let(:conn) { Faraday.new { |faraday| faraday.response :raise_error } }
    let(:api) { InstagramApi.new(conn) }

    it 'initializes connection attr at initialization method' do
      api = InstagramApi.new(conn)

      expect(api.conn).to eq(conn)
    end

    it 'returns generic error message when 500' do
      message = 'I am trapped in a social media factory send help'

      stub_request(:get, InstagramApi::URL).to_return(status: 500, 
        body: message)

        response = api.photos

        expect(response).to eq({ error: InstagramApi::GENERIC_ERROR_MESSAGE })
    end

    it 'returns photos when 200 status' do
      json = [{"username":"hipster1","picture":"food"},
              {"username":"hipster2","picture":"coffee"},
              {"username":"hipster3","picture":"coffee"},
              {"username":"hipster4","picture":"food"},
              {"username":"hipster5","picture":"this one is of a cat"}].to_json
      
      response = '{"photos":[{"username":"hipster1","picture":"food"},
          {"username":"hipster2","picture":"coffee"},
          {"username":"hipster3","picture":"coffee"},
          {"username":"hipster4","picture":"food"},
          {"username":"hipster5","picture":"this one is of a cat"}]}'

      stub_request(:get, InstagramApi::URL).to_return(status: 200, 
        body: json)

        response = api.photos

        expect(response).to eq(response)
    end
  end
  