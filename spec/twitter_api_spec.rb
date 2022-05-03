require 'spec_helper'
require_relative '../api/twitter_api'

describe TwitterApi do
    let(:conn) { Faraday.new { |faraday| faraday.response :raise_error } }
    let(:api) { TwitterApi.new(conn) }

    it 'initializes connection attr at initialization method' do
      api = TwitterApi.new(conn)

      expect(api.conn).to eq(conn)
    end

    it 'returns generic error message when 500' do
      message = 'I am trapped in a social media factory send help'

      stub_request(:get, TwitterApi::URL).to_return(status: 500, 
        body: message)
        
        response = api.tweets

        expect(response).to eq({ error: TwitterApi::GENERIC_ERROR_MESSAGE })

    end

    it 'returns tweets when 200 status' do
      json = [{username:"@GuyEndoreKaiser",tweet:"If you live to be 100, you should make up some fake reason why, just to mess with people..."},
        {username:"@mikeleffingwell", tweet:"STOP TELLING ME YOUR NEWBORN'S WEIGHT AND LENGTH I DON'T KNOW WHAT TO DO WITH THAT INFORMATION."}].to_json

      response = '{"tweets":[{"username":"@GuyEndoreKaiser",tweet:"If you live to be 100, you should make up some fake reason why, just to mess with people..."},
        {"username":"@mikeleffingwell", tweet:"STOP TELLING ME YOUR NEWBORN\'S WEIGHT AND LENGTH I DON\'T KNOW WHAT TO DO WITH THAT INFORMATION."}]'

      stub_request(:get, TwitterApi::URL).to_return(status: 200, 
        body: json)

        response = api.tweets

        expect(response).to eq(response)

    end
  end