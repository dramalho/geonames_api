require 'spec_helper'

describe GeoNamesAPI::Street do
  describe "::find" do
    it "expect to find one Street" do
      result = GeoNamesAPI::Street.find(37.451, -122.18)
      expect(result).to be_present
    end

    it "expect to not find streets outside of the US" do
      result = GeoNamesAPI::Street.find(50.01, 10.2)
      expect(result).to be_nil
    end
  end

  describe "::all" do
    it "expect to find multiple Streets in 100km radius" do
      result = GeoNamesAPI::Street.all(37.8, -122.4, 1, 3)
      expect(result.size).to eq(3)
    end
  end
end
