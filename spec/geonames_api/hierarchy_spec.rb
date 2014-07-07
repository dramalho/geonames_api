require 'spec_helper'

describe GeoNamesAPI::Hierarchy do
  def expect_sb(h)
    expect(h.first.name).to eq('Earth')
    expect(h.map(&:name)).to match_array(
      ['Earth', 'North America', 'United States', 'California', 'Santa Barbara County', 'Santa Barbara'])
  end

  def expect_roma(h)
    expect(h.map(&:name)).to match_array(
      ['Terra', 'Europa', 'Italia', 'Lazio', 'Roma', 'Roma', 'Roma'])
  end

  describe '::find' do
    it 'works for Santa Barbara' do
      h = GeoNamesAPI::Hierarchy.find(5392952)
      expect_sb(h)
    end

    it 'works for Roma ' do
      begin
        GeoNamesAPI.lang = :it
        h = GeoNamesAPI::Hierarchy.find(3169070)
        expect_roma(h)
      ensure
        GeoNamesAPI.lang = :en
      end
    end
  end

  describe '::where' do
    it 'works for Santa Barbara' do
      h = GeoNamesAPI::Hierarchy.where(geonameId: 5392952)
      expect_sb(h)
    end
  end
end
