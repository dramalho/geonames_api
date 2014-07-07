require 'spec_helper'

describe GeoNamesAPI::PlaceName do
  describe "::find" do
    it "expect to find one place" do
      result = GeoNamesAPI::PlaceName.find("50.01","10.2")
      expect(result).to be_present
    end

     it 'expect to find one place with a hash' do
      result = GeoNamesAPI::PlaceName.find(lat: 50.01, lng: 10.2)
      expect(result).to be_present
    end
  end

  describe "::all" do
    it "expect to find maxRow places in 100km radius" do
      result = GeoNamesAPI::PlaceName.all("50.01","10.2","100", "3")
      expect(result.size).to eq(3)
    end
  end
end
