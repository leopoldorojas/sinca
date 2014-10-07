class CreditCompany < ActiveRecord::Base
  belongs_to :location
  has_many :indicators

  validates :location, presence: true
end
