class ProjectionCsvGenerator
  require 'csv'

  def initialize(params)
    @projection = params[:projection] || {}
    @headers = [
      "Month",
      "#{params[:btc_data][:symbol]} - #{params[:btc_data][:price]}",
      "#{params[:eth_data][:symbol]} - #{params[:eth_data][:price]}"
    ]
  end

  def generate
    CSV.generate(col_sep: ';') do |csv|
      csv << headers

      projection.each do |_, element|
        csv << [element[:month_number], element[:btc_amount], element[:eth_amount]]
      end
    end
  end

  private

  attr_reader :headers, :projection

end
