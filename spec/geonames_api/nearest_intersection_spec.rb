require 'spec_helper'

describe GeoNamesAPI::NearestIntersection do
  
  describe '::find' do
    
    context 'given the latitude and longitude for a point inside the United States' do
      
      # Manhattan, Kansas, USA
      let(:latitude)  { 39.191253   }
      let(:longitude) { -96.573737  }
      
      it 'returns the two street names of the nearest intersection' do
        response = described_class.find(latitude,longitude)
        
        expect(response.intersection["street1"]).to eq('Bertrand St')
        expect(response.intersection["street2"]).to eq('N 11th St')
      end
    end
  end
end

