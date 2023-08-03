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
      #pending
    end
  end
end