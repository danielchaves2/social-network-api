require_relative '../api/social_networks_api'
require 'spec_helper'

describe SocialNetworksApi do
  let (:api) { SocialNetworksApi.new }

  it 'instantiates each inner API at the initialization' do

    expect(api.facebook).to be
    expect(api.twitter).to be
    expect(api.instagram).to be
  end

  it 'returns highlights of social media' do
    facebook_return = [{name:"Ale",status:"Away"},{name:"Laura",status:"Online"}]
    twitter_return = [{name:"Ale",tweet:"Hello"},{name:"Laura",tweet:"Hey"}]
    instagram_return = [{name:"Ale",picture:"On the gym"},{name:"Laura",picture:"on the beach"}]

    response = '{"facebook":{"statuses":[{"name":"Ale","status":"Away"},{"name":"Laura","status":"Online"}]},"twitter":{"tweets":[{"name":"Ale","tweet":"Hello"},{"name":"Laura","tweet":"Hey"}]},"instagram":{"photos":[{"name":"Ale","picture":"On the gym"},{"name":"Laura","picture":"on the beach"}]}}'

    stub_request(:get, FacebookApi::URL).to_return(status: 200, body: facebook_return.to_json)
    stub_request(:get, TwitterApi::URL).to_return(status: 200, body: twitter_return.to_json)
    stub_request(:get, InstagramApi::URL).to_return(status: 200, body: instagram_return.to_json)

    expect(api.highlights).to eq(response)
  end

  it 'returns highlights with error in Facebook' do
    twitter_return = [{name:"Ale",tweet:"Hello"},{name:"Laura",tweet:"Hey"}]
    instagram_return = [{name:"Ale",picture:"On the gym"},{name:"Laura",picture:"on the beach"}]

    response = '{"facebook":{"error":"' + FacebookApi::GENERIC_ERROR_MESSAGE+'"},"twitter":{"tweets":[{"name":"Ale","tweet":"Hello"},{"name":"Laura","tweet":"Hey"}]},"instagram":{"photos":[{"name":"Ale","picture":"On the gym"},{"name":"Laura","picture":"on the beach"}]}}'

    stub_request(:get, FacebookApi::URL).to_return(status: 500, body: 'Whatever')
    stub_request(:get, TwitterApi::URL).to_return(status: 200, body: twitter_return.to_json)
    stub_request(:get, InstagramApi::URL).to_return(status: 200, body: instagram_return.to_json)

    expect(api.highlights).to eq(response)
  end

  it 'returns highlights with error on 500 in Twitter' do
    facebook_return = [{name:"Ale",status:"Away"},{name:"Laura",status:"Online"}]
    instagram_return = [{name:"Ale",picture:"On the gym"},{name:"Laura",picture:"on the beach"}]

    response = '{"facebook":{"statuses":[{"name":"Ale","status":"Away"},{"name":"Laura","status":"Online"}]},"twitter":{"error":"'+ TwitterApi::GENERIC_ERROR_MESSAGE+'"},"instagram":{"photos":[{"name":"Ale","picture":"On the gym"},{"name":"Laura","picture":"on the beach"}]}}'

    stub_request(:get, FacebookApi::URL).to_return(status: 200, body: facebook_return.to_json)
    stub_request(:get, TwitterApi::URL).to_return(status: 500, body: 'Whatever')
    stub_request(:get, InstagramApi::URL).to_return(status: 200, body: instagram_return.to_json)

    expect(api.highlights).to eq(response)
  end

  it 'returns highlights with error on 500 in Instagram' do
    facebook_return = [{name:"Ale",status:"Away"},{name:"Laura",status:"Online"}]
    twitter_return = [{name:"Ale",tweet:"Hello"},{name:"Laura",tweet:"Hey"}]

    response = '{"facebook":{"statuses":[{"name":"Ale","status":"Away"},{"name":"Laura","status":"Online"}]},"twitter":{"tweets":[{"name":"Ale","tweet":"Hello"},{"name":"Laura","tweet":"Hey"}]},"instagram":{"error":"'+InstagramApi::GENERIC_ERROR_MESSAGE+'"}}'

    stub_request(:get, FacebookApi::URL).to_return(status: 200, body: facebook_return.to_json)
    stub_request(:get, TwitterApi::URL).to_return(status: 200, body: twitter_return.to_json)
    stub_request(:get, InstagramApi::URL).to_return(status: 500, body: 'Whatever')

    expect(api.highlights).to eq(response)
  end
end