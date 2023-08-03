# frozen_string_literal: true

require "rails_helper"

RSpec.describe CurrentCryptoPriceService do
  describe "#call" do
    it "return crypto params" do
      btc_request
      eth_request

      params = {
        btc_data:{
          symbol: "BTC",
          name: "Bitcoin",
          price_usd: 29156.844672102565
        },
        eth_data: {
          symbol: "ETH",
          name: "Ethereum",
          price_usd: 1839.7904097390538
        }
      }

      expect(described_class.new.call).to eq(params)
    end
  end

  def btc_request
    btc_body = {
      data: {
        symbol: "BTC",
        name: "Bitcoin",
        market_data: {
          price_usd: 29156.844672102565
        }
      }
    }

    stub_request(:get, "https://data.messari.io/api/v1/assets/btc/metrics").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host'=>'data.messari.io',
              'User-Agent'=>'rest-client/2.1.0 (darwin22 arm64) ruby/3.1.2p20',
        }).
      to_return(status: 200, body: btc_body.to_json)
  end

  def eth_request
    eth_body = {
      data: {
        symbol: "ETH",
        name: "Ethereum",
        market_data: {
          price_usd: 1839.7904097390538
        }
      }
    }

    stub_request(:get, "https://data.messari.io/api/v1/assets/eth/metrics").
      with(
        headers: {
              'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host'=>'data.messari.io',
              'User-Agent'=>'rest-client/2.1.0 (darwin22 arm64) ruby/3.1.2p20',
        }).
      to_return(status: 200, body: eth_body.to_json)
  end
end
