class District < Location
  belongs_to :city,	foreign_key: "parent_id"
  validates :city, presence: true
end
