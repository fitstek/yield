require 'rails_helper'

RSpec.describe Area, :type => :model do
  let!(:area) { Area.create(:postcode => 'NW106RB') }

  it 'can add rent to the rent column' do
    expect(area.property_rent=(800)).to eq Property.first.rent
  end

  it 'can add investment to the investment column' do
    expect(area.landlord_investment=(10000)).to eq Property.first.investment
  end
end
