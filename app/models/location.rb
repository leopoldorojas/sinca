class Location < ActiveRecord::Base
  validates :name, presence: true
  has_many :credit_companies

  def self.types
    ['Country', 'Province', 'City', 'District']
  end
  
  def parent
  	Location.types.each { |t| return t if self.respond_to? t.underscore.to_sym }
  	nil
  end

end
