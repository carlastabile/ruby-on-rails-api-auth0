require 'rails_helper'

require 'json_web_token'

describe JsonWebToken do
  subject { described_class }

  let(:valid_token){ TokenHelper.read_token("validToken")}
  let(:expired_token){ TokenHelper.read_token("expiredToken")}

  let(:jwks_raw) do
    "{\"keys\":[{\"alg\":\"RS256\",\"kty\":\"RSA\",\"use\":\"sig\",\"n\":\"0cBhPmRoHRaWs6NSlmpr3CxcF1bZlhD_1tBMQ026BitWzHVb1rST-_F1ZhPG9y7zyacTvVu-IE8HJwDegylhTgdKPk4c1s1tomomETJkrxeyG77pHl3jR5cP8LpoqHAFtQKHFe_YR0sgTu038jNZPtr4ZB-kSIu5DE_J5dnprRn4Zr1e2euJecpyhmcOVscGQWagkCOgknUNMP7Yc0VlfqW1Qcmv7ri__LhbaDsuqA4vNWLwf3JEg-sV1I7Yq04Uru6ZE6uaXhhbIardVhrGztEGzj4xz5P6yV-XLb19Bj0S8gnPPDtQr8H1J7VR-ftjNumS6mvM4tpGMB8J97Bj_Q\",\"e\":\"AQAB\",\"kid\":\"CoxMMDDYi1nNiiOjrxllh\",\"x5t\":\"lIzVyZbbZ8KRza6mNQeU7l539ls\",\"x5c\":[\"MIIDDTCCAfWgAwIBAgIJA8FWcpkDbdANMA0GCSqGSIb3DQEBCwUAMCQxIjAgBgNVBAMTGWRldi0wODVyM3V4ai51cy5hdXRoMC5jb20wHhcNMjIwNTE0MTgyMjI0WhcNMzYwMTIxMTgyMjI0WjAkMSIwIAYDVQQDExlkZXYtMDg1cjN1eGoudXMuYXV0aDAuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0cBhPmRoHRaWs6NSlmpr3CxcF1bZlhD/1tBMQ026BitWzHVb1rST+/F1ZhPG9y7zyacTvVu+IE8HJwDegylhTgdKPk4c1s1tomomETJkrxeyG77pHl3jR5cP8LpoqHAFtQKHFe/YR0sgTu038jNZPtr4ZB+kSIu5DE/J5dnprRn4Zr1e2euJecpyhmcOVscGQWagkCOgknUNMP7Yc0VlfqW1Qcmv7ri//LhbaDsuqA4vNWLwf3JEg+sV1I7Yq04Uru6ZE6uaXhhbIardVhrGztEGzj4xz5P6yV+XLb19Bj0S8gnPPDtQr8H1J7VR+ftjNumS6mvM4tpGMB8J97Bj/QIDAQABo0IwQDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSbEZJ6RXCdHCteX+fdPnWPel4WjzAOBgNVHQ8BAf8EBAMCAoQwDQYJKoZIhvcNAQELBQADggEBADdH+RKN8sqvprj/JjV/vZ2ebDPcKXuSmCp9EvgUHZkrtu4wHS/MXqJ7mxMVqFZHeGnnqC9RHbMv/7dppx8KRuKg9+2MuDAvjt4AjAA8rj0Wsy8+Rlihkp/ypSCFjDnhG+r1XuEcGdHmNuQIQz+afv0RhLNCUQkBCelpPE4vackUsHiH3tiKU6M06wWXK4EUcZff6qjNElHNuL4ckGIHE90j92nWTQlAgMRW3cfANLyn98QQsS3l0RdED6+Svl2iU8kaipiLdgWdDvQtx6VeV2Mjs9T3n2ykVhsA3R66Fh/MkbP+sThQnaK/kMCDIsvxGFk8TySM/C8EXkCnQ49nsVI=\"]},{\"alg\":\"RS256\",\"kty\":\"RSA\",\"use\":\"sig\",\"n\":\"uOJ_xLaSBP-VUQkYyPqiBXc84o1AZcD7a7zBPLP4qrf5EtZat-hWStXNzMINtU4vo18HpHt4JAJP7JQcrAwjBLnzb-Ax-qHHehZR1wO2KbV5eMPDC4sR_tXQ9Wn8G1vQD_AlnQe24rN5KNdUbQQKZ1TrGMNqqau502fmVaooJoMu5DAewsAgJXZo8ue8TgQw43rTioHP1d3NNQ6VFvooxrnL9ugN6pn5C5Ota7ehH58-PNpraWSoo2B3dmDfkCBSg8qXecMJZbBZB0gZzsM1T03uP8-21oEbrg8-GhTgzXlhAulHPd1x9vAWTEQzdeHaox9JlbdWGPAt9Qbir4JFTw\",\"e\":\"AQAB\",\"kid\":\"dml4LTIeQDL1X9hqaYlaX\",\"x5t\":\"RSJCGFlHfJcZqA8XuJc_mwQJ5u0\",\"x5c\":[\"MIIDDTCCAfWgAwIBAgIJNV6RIMmHlxICMA0GCSqGSIb3DQEBCwUAMCQxIjAgBgNVBAMTGWRldi0wODVyM3V4ai51cy5hdXRoMC5jb20wHhcNMjIwNTE0MTgyMjI0WhcNMzYwMTIxMTgyMjI0WjAkMSIwIAYDVQQDExlkZXYtMDg1cjN1eGoudXMuYXV0aDAuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuOJ/xLaSBP+VUQkYyPqiBXc84o1AZcD7a7zBPLP4qrf5EtZat+hWStXNzMINtU4vo18HpHt4JAJP7JQcrAwjBLnzb+Ax+qHHehZR1wO2KbV5eMPDC4sR/tXQ9Wn8G1vQD/AlnQe24rN5KNdUbQQKZ1TrGMNqqau502fmVaooJoMu5DAewsAgJXZo8ue8TgQw43rTioHP1d3NNQ6VFvooxrnL9ugN6pn5C5Ota7ehH58+PNpraWSoo2B3dmDfkCBSg8qXecMJZbBZB0gZzsM1T03uP8+21oEbrg8+GhTgzXlhAulHPd1x9vAWTEQzdeHaox9JlbdWGPAt9Qbir4JFTwIDAQABo0IwQDAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTl+U2YmCmM7SZ3QG8RELmzTsKJkTAOBgNVHQ8BAf8EBAMCAoQwDQYJKoZIhvcNAQELBQADggEBAC4toPUMWaYHX9f6iczuRZ/K4N65id7IyzEmhFUex9uB/Alga63FZASKDRx3GoYW/6ksC7mrJ9OEsFgOUPfvUreAx8lA2r71JVoIyuiyLCCDgOJ26J60EcKvkZAKjgNRL6Vorjc5c2fYUKdiz12s8LMJmza3hTCO8PTF2uc9NoleO3AOAQzosqPKk5K1PVudJo+6+K9HHmDqDOgpPTLv413KKy8PWXDwSAHH7isih2yyEw4KoA9xqFqJpoOdvN/oaXoNMWn8Mbg2poDV/W5dxxCbgcv2FMS5IdxhkgHld4+993mJq7fFvGkSzquknMr6ft5SKErbBg4VcqGc4lE1x20=\"]}]}"
  end

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