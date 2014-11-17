class Area < ActiveRecord::Base
  attr_reader :property_rent
  attr_reader :landlord_investment

  validates :postcode, presence: true

  has_many :properties

  def property_rent=(amount)
    Property.create(rent: amount)
  end

  def landlord_investment=(amount)
    Property.create(investment: amount)
  end
end
