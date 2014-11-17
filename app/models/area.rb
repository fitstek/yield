class Area < ActiveRecord::Base
  attr_reader :property_rent
  attr_reader :landlord_investment

  validates :postcode, presence: true

  has_many :properties

end
