require 'spec_helper'


describe GeoNamesAPI::CountrySubdivision do
  def expected_sf(result)
    expect(result).to be_present
    expect(result.admin_code1).to eq('CA')
    expect(result.admin_name1).to eq('California')
    expect(result.country_code).to eq('US')
    expect(result.country_name).to eq('United States')
  end

  describe '::find' do
    it 'expect to find one subdivision' do
      result = GeoNamesAPI::CountrySubdivision.find(37.8, -122.4)
      expected_sf(result)
    end
  end

  describe '::all' do
    it 'expect to find multiple subdivisions' do
      result = GeoNamesAPI::CountrySubdivision.all(37.8, -122.4)
      expect(result.size).to be > 0
      expected_sf(result.first)
    end
  end
end
