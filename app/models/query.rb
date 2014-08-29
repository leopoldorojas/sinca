class Query
  include ActiveModel::Model

  attr_accessor :start_date, :end_date

  validates :start_date, presence: true
  validates :end_date, presence: true

  def has_value?
    start_date || end_date
  end

end
