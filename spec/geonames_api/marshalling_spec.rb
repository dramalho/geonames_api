require 'spec_helper'
require 'pathname'

describe GeoNamesAPI::Entity do
  let(:filename) do
    (Pathname.new(__FILE__).parent + "place.ser").realdirpath
  end

  class TestPlace < GeoNamesAPI::ListEndpoint
    METHOD = "findNearbyJSON"
    FIND_PARAMS = %w(lat lng radius maxRows)
  end

  def ensure_place_exists
    unless filename.exist?
      puts "Sorry, #{filename} didn't exist yet. Run this test again."
      place = TestPlace.find(lat: 37.8018, lng: -122.3971, radius: 0.25)
      filename.open('wb') { |io| Marshal.dump(place, io) }
    end
  end

  # NOTE: if these fail, try deleting place.ser and re-running the spec.
  it 'round-trips when an Entity has not been loaded yet' do
    ensure_place_exists
    obj = Marshal.load(filename.open('rb'))
    expect(obj).to respond_to(:geoname_id)
    expect(obj).to respond_to(:country_code)
    expect(obj).to respond_to(:lat)
    expect(obj).to respond_to(:lng)
    expect(obj).to be_a(TestPlace)

    expect(obj.geoname_id).to eq(5382567)
    expect(obj.country_code).to eq('US')
    expect(obj.lat).to be_within(0.001).of(37.8018)
    expect(obj.lng).to be_within(0.001).of(-122.3971)
  end
end
