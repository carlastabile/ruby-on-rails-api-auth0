require 'rails_helper'

require 'json_web_token'

describe JsonWebToken do
  subject { described_class }

  let(:valid_token){ ReadHelper.read("validToken")}
  let(:expired_token){ ReadHelper.read("expiredToken")}
  let(:jwks_raw){ ReadHelper.read("jwks_raw")}

  describe '.verify' do
    before do
      allow(Net::HTTP).to receive(:get).and_return(jwks_raw)
    end

    it 'authorizes the request if token is correct' do
      expect { subject.verify(valid_token) }.not_to raise_error
    end

    it 'raises exception if the token is incorrect' do
      expect { subject.verify('') }.to raise_exception(JWT::DecodeError)
    end

    it 'raises exception if the token is expired' do
      expect { subject.verify(expired_token) }.to raise_exception(JWT::DecodeError)
    end
  end
end