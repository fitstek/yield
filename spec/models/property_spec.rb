require 'rails_helper'

RSpec.describe Property, :type => :model do
  let!(:property) { Property.create(:rent => 800, :investment => 100000) }

  it 'can add rent to the rent column' do
    expect(property.net_yield).to eq 9.6
  end

  it 'rent and initial investment must be supplied always' do
    expect(Property.create(rent: nil, investment: nil).valid?).to eq false
  end
end
