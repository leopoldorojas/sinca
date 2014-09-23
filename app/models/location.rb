class Location < ActiveRecord::Base
  has_many :credit_companies

  validates :name, presence: true
  validates :type, presence: true

  def self.types
    ['Country', 'Province', 'City', 'District']
  end
  
  def parent
  	Location.types.each { |t| return t if self.respond_to? t.underscore.to_sym }
  	nil
  end

end
