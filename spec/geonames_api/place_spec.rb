require 'spec_helper'

describe GeoNamesAPI::Place do
  describe "::find" do
    it "expect to find one place" do
      result = GeoNamesAPI::Place.find("50.01","10.2")
      expect(result).to be_present
    end
  end

  describe "::all" do
    it "expect to find multiple places in 100km radius" do
      result = GeoNamesAPI::Place.all("50.01","10.2","100")
      expect(result.size).to be > 0
    end
  end
end