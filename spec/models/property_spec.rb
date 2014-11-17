require 'rails_helper'

RSpec.describe Property, :type => :model do
  let!(:property) { Property.create(:rent => 800, :investment => 100000) }

  it 'can add rent to the rent column' do
    expect(property.net_yield).to eq 9.6
  end
end
