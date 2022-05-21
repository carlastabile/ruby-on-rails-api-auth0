require 'rails_helper'

RSpec.describe 'Jokes', type: :request do
  describe 'GET /index' do
    before do
      FactoryBot.create_list(:joke, 10)
      get '/jokes'
    end
    
    it 'returns all jokes' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end
end