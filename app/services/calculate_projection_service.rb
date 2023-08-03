class CalculateProjectionService
  BTC_INSTEREST_PERCENTAGE = 0.05
  ETH_INSTEREST_PERCENTAGE = 0.03

  def initialize(amount)
    @amount = amount
    @cripto_data = CurrentCryptoPriceService.new.call
  end

  def call
    calculate_projection
  end

  private

  attr_accessor :amount, :cripto_data

  def calculate_projection
    btc_amount = amount / cripto_data[:btc_data][:price_usd]
    eth_amount = amount / cripto_data[:eth_data][:price_usd]

    (1..12).each_with_object([]) do |element, array|
      btc_interest = (btc_amount * BTC_INSTEREST_PERCENTAGE)
      eth_interest = (eth_amount * ETH_INSTEREST_PERCENTAGE)

      array << {
        month_number: element,
        btc_amount: btc_amount =+ btc_amount + btc_interest,
        eth_amount: eth_amount =+ eth_amount + eth_interest }
    end
  end
end