class CreditCompany < ActiveRecord::Base
  belongs_to :location
  belongs_to :executive, class_name: "User" 
  has_many :indicators
  has_many :users

  validates :name, :short_name, :identifier, :contact, :phone, :email, :location, :executive, presence: true
  validates :short_name, :identifier, :email, uniqueness: true
  
  default_scope { order(:name) }
end