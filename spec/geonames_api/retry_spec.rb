require 'spec_helper'

describe GeoNamesAPI::Base do
  describe "retries" do
    before :each do
      allow(GeoNamesAPI).to receive(:max_sleep_time_between_retries).and_return(0)
      @timeout = JSON.load <<-JSON
        {
          "status": {
            "message": "ERROR: canceling statement due to statement timeout",
            "value": 13
          }
        }
      JSON
      # This is not a correct, complete response, but that's not relevant to the spec:
      @response = JSON.load <<-JSON
        {"geonames": [{ "name": "Earth" }]}
      JSON
    end

    it "retries when geonames returns timeout errors" do
      allow(GeoNamesAPI::Hierarchy).to receive(:make_request).and_return(@timeout, @response)
      hierarchy = GeoNamesAPI::Hierarchy.find(6295630)
      earth = hierarchy.first
      expect(earth).to be_present
      expect(earth.name).to eq("Earth")
    end

    it "fails when geonames returns timeout errors too many times" do
      allow(GeoNamesAPI::Hierarchy).to receive(:make_request).and_return(@timeout, @timeout, @response)
      allow(GeoNamesAPI).to receive(:retries).and_return(1)
      expect { GeoNamesAPI::Hierarchy.find(6295630) }.to raise_error GeoNamesAPI::Timeout
    end
  end
end
