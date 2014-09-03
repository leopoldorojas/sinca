class Query
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :results

  validates :start_date, presence: true
  validates :end_date, presence: true

  def empty?
    results.blank?
  end

end
