require 'rails_helper'
require 'json_web_token'

RSpec.describe 'Jokes', type: :request do
  let(:joke) {
    {
      category: "category",
      content: "the funny joke"
    } 
  }
  describe 'POST /jokes' do
    it 'returns error if there is no token' do
      # request.headers["Authorization"] = "foo"

      post '/jokes', params: { joke: { category: "funny", content: "yes" } }
                      
      expect(response).to be_unauthorized
    end

    it 'returns error if the token is expired' do
      post '/jokes', params: { joke: { category: "funny", content: "yes" } }, headers: {'Authorization' => 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3lvdXJUZW5hbnQuZXUuYXV0aDAuY29tLyIsInN1YiI6InVzZXIiLCJhdWQiOlsidGFyZ2V0QXVkaWVuY2UuYXV0aDAuY29tIiwiaHR0cHM6Ly95b3VyVGVuYW50LmV1LmF1dGgwLmNvbS91c2VyaW5mbyJdLCJpYXQiOjExMjEzNjkxMzAsImV4cCI6MTI5MTQ1NTUzMCwiYXpwIjoiVGhFa2dkRzFObmRMbFdvTk1jRWRFcjJLSklzOXZLYWQiLCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGVtYWlsIn0.tXmU5UkTnfgo4nHWnkvpf93Dz6I7PD_SL4AAYPSjz8U'}

      expect(response).to be_unauthorized
    end

    it 'returns ok for valid token' do
      post '/jokes', params: { joke: { category: "funny", content: "yes" } }, headers: {'Authorization' => 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IkNveE1NRERZaTFuTmlpT2pyeGxsaCJ9.eyJpc3MiOiJodHRwczovL2Rldi0wODVyM3V4ai51cy5hdXRoMC5jb20vIiwic3ViIjoiZzRLUEtITklJd1BoQ251dmhzYjhVVGJuYzF4M04ydnlAY2xpZW50cyIsImF1ZCI6Imh0dHBzOi8vbXktam9rZXMtYXBpIiwiaWF0IjoxNjUyNjM2ODcyLCJleHAiOjE2NTI3MjMyNzIsImF6cCI6Imc0S1BLSE5JSXdQaENudXZoc2I4VVRibmMxeDNOMnZ5IiwiZ3R5IjoiY2xpZW50LWNyZWRlbnRpYWxzIn0.Mkx7KZhTbEzI4-XDFwNgGXMtttjQv6evFTrQjLV2RDiQRn350bbKz-IIuURl8nD1sURvGM3J6_xWGFhsvh3rG0rs0_dqKXu_rGOO5kKBxXqJLxVVmE8zQc2nwwGIbtBTrSbyIGwUk04LMWMDlm0Niot8xrjTbd8Krg82Y2bc8CRxCiaqKiqmbr0cKqXLb8_aBHS3ZZs4oTjXXJSvNLSjIB6rjlPYLwVKNMvV_yMmcSyQAvFxftnjeh78SlmDSMlwqnklbFkOW84jxi9qMV6U4OruyR4uhhtBgIbrjDgR8KpLyz4qXfr335m6VGhrarTPXsRLjy-4gID_8eESJ5BWxQ'}

      expect(response).to have_http_status(:no_content)

      message = 'The API successfully validated your access token.'
    end
  end
end