class Property < ActiveRecord::Base

  validates :rent, presence: true
  validates :investment, presence: true

  belongs_to :area
  belongs_to :user
  
  def net_yield
    ((rent * 12) / investment) * 100
  end
end
