require "rails_helper"

RSpec.describe CalculatorController, :type => :request do
  before do
    btc_request
    eth_request
  end

  describe "#index" do
    it "render index" do
      get root_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end
  end

  describe "#calculate" do
    it "render json projection" do
      post calculate_path(amount: 100)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]).to eq(
        [{"month_number"=>1, "btc_amount"=>0.003601212723147117, "eth_amount"=>0.055984637953737884},
          {"month_number"=>2, "btc_amount"=>0.0037812733593044733, "eth_amount"=>0.05766417709235002},
          {"month_number"=>3, "btc_amount"=>0.003970337027269697, "eth_amount"=>0.05939410240512052},
          {"month_number"=>4, "btc_amount"=>0.004168853878633182, "eth_amount"=>0.061175925477274136},
          {"month_number"=>5, "btc_amount"=>0.004377296572564841, "eth_amount"=>0.06301120324159236},
          {"month_number"=>6, "btc_amount"=>0.004596161401193084, "eth_amount"=>0.06490153933884013},
          {"month_number"=>7, "btc_amount"=>0.004825969471252738, "eth_amount"=>0.06684858551900534},
          {"month_number"=>8, "btc_amount"=>0.005067267944815375, "eth_amount"=>0.0688540430845755},
          {"month_number"=>9, "btc_amount"=>0.005320631342056143, "eth_amount"=>0.07091966437711276},
          {"month_number"=>10, "btc_amount"=>0.00558666290915895, "eth_amount"=>0.07304725430842615},
          {"month_number"=>11, "btc_amount"=>0.005865996054616898, "eth_amount"=>0.07523867193767894},
          {"month_number"=>12, "btc_amount"=>0.006159295857347743, "eth_amount"=>0.0774958320958093}]
      )
    end
  end

  describe "#print_projection" do
    it "render csv" do
      post print_projection_path(
        format: :csv,
        btc_data:{
          symbol: "BTC",
          price: 29156.844672102565
        },
        eth_data: {
          symbol: "ETH",
          price: 1839.7904097390538
        }
      )

      expect(response).to have_http_status(:ok)
      expect(response.header["Content-Type"]).to include "text/csv"
      expect(response.body).to include(
        "Month;BTC - 29156.844672102565;ETH - 1839.7904097390538\n")
    end
  end

  describe "#projection" do
    it "render json projection" do
      get projection_path(amount: 100)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"]).to eq(
        [{"month_number"=>1, "btc_amount"=>0.003601212723147117, "eth_amount"=>0.055984637953737884},
          {"month_number"=>2, "btc_amount"=>0.0037812733593044733, "eth_amount"=>0.05766417709235002},
          {"month_number"=>3, "btc_amount"=>0.003970337027269697, "eth_amount"=>0.05939410240512052},
          {"month_number"=>4, "btc_amount"=>0.004168853878633182, "eth_amount"=>0.061175925477274136},
          {"month_number"=>5, "btc_amount"=>0.004377296572564841, "eth_amount"=>0.06301120324159236},
          {"month_number"=>6, "btc_amount"=>0.004596161401193084, "eth_amount"=>0.06490153933884013},
          {"month_number"=>7, "btc_amount"=>0.004825969471252738, "eth_amount"=>0.06684858551900534},
          {"month_number"=>8, "btc_amount"=>0.005067267944815375, "eth_amount"=>0.0688540430845755},
          {"month_number"=>9, "btc_amount"=>0.005320631342056143, "eth_amount"=>0.07091966437711276},
          {"month_number"=>10, "btc_amount"=>0.00558666290915895, "eth_amount"=>0.07304725430842615},
          {"month_number"=>11, "btc_amount"=>0.005865996054616898, "eth_amount"=>0.07523867193767894},
          {"month_number"=>12, "btc_amount"=>0.006159295857347743, "eth_amount"=>0.0774958320958093}]
      )
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
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "Host"=>"data.messari.io",
              "User-Agent"=>"rest-client/2.1.0 (darwin22 arm64) ruby/3.1.2p20",
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
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "Host"=>"data.messari.io",
              "User-Agent"=>"rest-client/2.1.0 (darwin22 arm64) ruby/3.1.2p20",
        }).
      to_return(status: 200, body: eth_body.to_json)
  end
end