class Location < ActiveRecord::Base

  def self.types
    ['Country', 'Province', 'City', 'District']
  end
  
end
