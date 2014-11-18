class Area < ActiveRecord::Base
  attr_reader :property_rent
  attr_reader :landlord_investment

  has_many :properties
  validates :postcode, presence: true
  validate :valid_postcode

  def valid_postcode
    begin
      uri = URI.parse("http://mapit.mysociety.org/postcode/#{postcode}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if JSON.parse(response.body)["code"] == 400
        errors.add(:postcode, "The Value you entered is not a valid UK postcode")
      end
    rescue Exception => e
      errors.add(:postcode, e.message)
    end
  end
end
