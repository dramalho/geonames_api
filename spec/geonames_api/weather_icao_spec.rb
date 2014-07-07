require 'spec_helper'

describe GeoNamesAPI::WeatherICAO do
  describe "::find" do
    it "expect to find one station" do
      result = GeoNamesAPI::WeatherICAO.find('KHAF')
      expect(result).to be_present
    end
  end
end
