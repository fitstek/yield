require 'rails_helper'

RSpec.describe Area, :type => :model do

  it 'postcode must be supplied always' do
    expect(Area.create(postcode: nil).valid?).to eq false
  end
end
