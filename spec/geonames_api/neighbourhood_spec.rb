require 'spec_helper'

describe GeoNamesAPI::Neighbourhood do
  describe "::find" do
    it "expect to find NYC" do
      result = GeoNamesAPI::Neighbourhood.find(lat: 40.78343, lng: -73.96625)
      expect(result.hierarchy).to match_array(
        ["United States", "New York", "New York County", "New York City-Manhattan", "Central Park"])
    end

    it "expect to not find streets outside of the US" do
      expect { GeoNamesAPI::Neighbourhood.find(0, 0) }.to raise_error GeoNamesAPI::Error
    end
  end
end
