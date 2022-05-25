require 'rails_helper'
require 'json_web_token'

RSpec.describe 'Jokes', type: :request do
  let(:valid_token){ ReadHelper.read("validToken") }
  let(:expired_token){ ReadHelper.read("expiredToken") }
  let(:joke) {
    {
      category: "category",
      content: "the funny joke"
    } 
  }
  describe 'POST /jokes' do
    it 'returns error if there is no token' do

      post '/jokes', params: { joke: { category: "funny", content: "yes" } }
                      
      expect(response).to be_unauthorized
    end

    it 'returns error if the token is expired' do
      post '/jokes', params: { joke: { category: "funny", content: "yes" } }, headers: {'Authorization' => "Bearer #{expired_token}"}

      expect(response).to be_unauthorized
    end

    it 'returns ok for valid token' do
      post '/jokes', params: { joke: { category: "funny", content: "yes" } }, headers: {'Authorization' => "Bearer #{valid_token}"}

      expect(response).to have_http_status(:no_content)

      message = 'The API successfully validated your access token.'
    end
  end
end