require 'spec_helper'
require_relative '../api/facebook_api'

describe FacebookApi do
    let(:conn) { Faraday.new { |faraday| faraday.response :raise_error } }
    let(:api) { FacebookApi.new(conn) }

    it 'initializes connection attr at initialization method' do
      api = FacebookApi.new(conn)

      expect(api.conn).to eq(conn)
    end

    it 'returns generic error message when 500' do
      message = 'I am trapped in a social media factory send help'

      stub_request(:get, FacebookApi::URL).to_return(status: 500, 
        body: message)
        
        response = api.statuses

        expect(response).to eq({ error: FacebookApi::GENERIC_ERROR_MESSAGE })

    end

    it 'returns statuses when 200 status' do
      json = [{name:"Some Friend",status:"Here's some photos of my holiday. Look how much more fun I'm having than you are!"},
          {name:"Drama Pig",status:"I am in a hospital. I will not tell you anything about why I am here."}].to_json
      
      response = '{"statuses":[{name:"Some Friend",status:"Here\'s some photos of my holiday. Look how much more fun I\'m having than you are!"},
      {name:"Drama Pig",status:"I am in a hospital. I will not tell you anything about why I am here."}]}'

      stub_request(:get, FacebookApi::URL).to_return(status: 200, 
        body: json)

        response = api.statuses

        expect(response).to eq(response)

    end
  end