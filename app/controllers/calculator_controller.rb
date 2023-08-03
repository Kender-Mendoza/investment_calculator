class CalculatorController < ApplicationController
  require 'csv'

  def index
    render :index, locals: current_crypto_data
  end

  def calculate
    projection = CalculateProjectionService.new(params_permite[:amount].to_i).call

    render json: { data: projection }, status: 200
  end

  def print_projection
    respond_to do |format|
      format.csv do
        send_data to_csv, content_type: 'text/csv'
      end
    end
  end

  private

  def to_csv
    headers = [
      "Month",
      "#{params[:btc_data][:symbol]} - #{params[:btc_data][:price]}",
      "#{params[:eth_data][:symbol]} - #{params[:eth_data][:price]}"
    ]

    CSV.generate(col_sep: ';') do |csv|
      csv << headers

      (params[:projection] || {}).each do |_, element|
        csv << [element[:month_number], element[:btc_amount], element[:eth_amount]]
      end
    end
  end

  def params_permite
    params.permit(:amount)
  end

  def current_crypto_data
    @current_crypto_data = CurrentCryptoPriceService.new.call
  end
end