# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Calculator", type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: root_path).to route_to("calculator#index")
    end

    it "routes to #calculate" do
      expect(post: calculate_path).to route_to("calculator#calculate")
    end

    it "routes to #print_projection" do
      expect(post: print_projection_path).to route_to(
        { "format"=>"csv", "controller"=>"calculator", "action"=>"print_projection" }
      )
    end
  end
end