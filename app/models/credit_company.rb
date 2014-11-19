class CreditCompany < ActiveRecord::Base
  belongs_to :location
  has_many :indicators
  has_many :users

  validates :location, :name, :short_name, :identifier, :contact, :phone, :email, presence: true
  validates :short_name, :identifier, :email, uniqueness: true
  
  default_scope { order(:name) }
end