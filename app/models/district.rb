class District < Location
  belongs_to :city,	foreign_key: "parent_id"
end
