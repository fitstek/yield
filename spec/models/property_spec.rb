require 'rails_helper'

RSpec.describe Property, :type => :model do
  let!(:property) { Property.create(:rent => 800, :investment => 100000) }

  it 'can add rent to the rent column' do
    expect(property.net_yield).to eq 9.6
  end

  it 'rent and initial investment must be supplied always' do
    expect(Property.create(rent: nil, investment: nil).valid?).to eq false
  end

  it 'validates that rent and initial investment are positive float numbers' do
    expect(Property.create(rent: -1, investment: 0).valid?).to eq false
  end
end
