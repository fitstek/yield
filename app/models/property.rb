class Property < ActiveRecord::Base

  belongs_to :area
  belongs_to :user
  validates :rent, :investment, presence: true, numericality: { greater_than: 0 }

  def net_yield
    ((rent * 12) / investment) * 100
  end
end
