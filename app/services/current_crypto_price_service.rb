class CurrentCryptoPriceService
  def call
    {
      btc_data: btc_data,
      eth_data: eth_data
    }
  end

  private

  def btc_data
    parse_data(send("btc"))
  end

  def eth_data
    parse_data(send("eth"))
  end

  def send(assetKey)
    RestClient::Request.execute(
      method: "GET",
      url: "https://data.messari.io/api/v1/assets/#{assetKey}/metrics",
      headers: {
      "x-messari-api-key": ENV["MESSARI_API_KEY"] }).body
  rescue RestClient::InternalServerError, RestClient::Unauthorized, RestClient::BadRequest, RestClient::NotFound => e
    { error: e }
  end

  def parse_data(body)
    parsed_body = JSON.parse(body)

    return { symbol: "", name: "", price_usd: 0, error: parsed_body[:error] } if parsed_body[:error].present?

    data = parsed_body["data"]

    {
      symbol: data["symbol"],
      name: data["name"],
      price_usd: data["market_data"]["price_usd"]
    }
  end
end
