class Indicator < ActiveRecord::Base
  validates :credit_company, presence: true

  def self.import(credit_company, file)
    create(credit_company: credit_company)
  end
end
