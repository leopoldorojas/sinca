class CreditCompany < ActiveRecord::Base
  belongs_to :location
  has_many :indicators
  has_many :users

  validates :location, presence: true

  default_scope { order(:name) }
end
