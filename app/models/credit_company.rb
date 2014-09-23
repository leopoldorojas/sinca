class CreditCompany < ActiveRecord::Base
  belongs_to :location
  validates :location, presence: true
end
