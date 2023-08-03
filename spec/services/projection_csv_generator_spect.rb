# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProjectionCsvGenerator do
  describe "#generate" do
    it "return csv data" do
      params = {
        btc_data:{
          symbol: "BTC",
          price: 29156.844672102565
        },
        eth_data: {
          symbol: "ETH",
          price: 1839.7904097390538
        },
        projection: {
          "0"=>{month_number: "1", btc_amount: "0.0036040898577611937", eth_amount: "0.05599721582516021"},
          "1"=>{month_number: "2", btc_amount: "0.0037842943506492532", eth_amount: "0.057677132299915015"},
          "2"=>{month_number: "3", btc_amount: "0.0039735090681817156", eth_amount: "0.059407446268912464"},
          "3"=>{month_number: "4", btc_amount: "0.004172184521590802", eth_amount: "0.06118966965697984"},
          "4"=>{month_number: "5", btc_amount: "0.0043807937476703415", eth_amount: "0.06302535974668924"},
          "5"=>{month_number: "6", btc_amount: "0.004599833435053859", eth_amount: "0.06491612053908992"},
          "6"=>{month_number: "7", btc_amount: "0.004829825106806552", eth_amount: "0.06686360415526262"},
          "7"=>{month_number: "8", btc_amount: "0.0050713163621468795", eth_amount: "0.0688695122799205"},
          "8"=>{month_number: "9", btc_amount: "0.005324882180254223", eth_amount: "0.07093559764831811"},
          "9"=>{month_number: "10", btc_amount: "0.005591126289266934", eth_amount: "0.07306366557776765"},
          "10"=>{month_number: "11", btc_amount: "0.005870682603730281", eth_amount: "0.07525557554510068"},
          "11"=>{month_number: "12", btc_amount: "0.0061642167339167955", eth_amount: "0.07751324281145369"}
        }
      }

      csv_file = fixture_file_upload("csv_projection.csv", "text/csv")
      expect(described_class.new(params).generate).to eq(csv_file.read)
    end
  end
end
