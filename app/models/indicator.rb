class Indicator < ActiveRecord::Base
  validates :credit_company, presence: true
end
