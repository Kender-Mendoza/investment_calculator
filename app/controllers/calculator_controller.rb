class CalculatorController < ApplicationController
  def index
    render :index, locals: current_crypto_data
  end

  def calculate
    projection = CalculateProjectionService.new(params_permite[:amount].to_i).call

    render json: { data: projection }, status: 200
  end

  def print_projection
    respond_to do |format|
      format.csv { render csv: to_csv, filename: "cars-#{Date.today}.csv" }
    end
  end

  private

  def to_csv
    attributes = %w{id name price} #customize columns here

    CSV.generate(headers: true) do |csv|
      csv << attributes
    end
  end

  def params_permite
    params.permit(:amount)
  end

  def current_crypto_data
    @current_crypto_data = CurrentCryptoPriceService.new.call
  end
end