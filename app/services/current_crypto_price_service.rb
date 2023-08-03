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
      "x-messari-api-key": "Hg0v49hJlHMX1Ou5Xq6p0NML7Kymq7vhZ8VEYWXWF4oDDiOz" }).body
  rescue RestClient::InternalServerError, RestClient::Unauthorized, RestClient::BadRequest => e
    { }
  end

  def parse_data(body)
    return {} if body.blank?

    data = JSON.parse(body)["data"]
    {
      symbol: data["symbol"],
      name: data["name"],
      price_usd: data["market_data"]["price_usd"]
    }
  end
end
