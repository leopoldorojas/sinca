class Query
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :results

  validates :start_date, presence: true
  validates :end_date, presence: true

  def empty?
    results.blank?
  end

  def execute
    self.results = []

    Rails.application.config.individual_indicators.each_key do |indicator_name|
      result = Result.new
      result.tap do |r|
        r.name = indicator_name
        r.average = Indicator.by_date_range(self).average(indicator_name)
        r.sum = Indicator.by_date_range(self).sum(indicator_name)
        r.count = Indicator.by_date_range(self).count(indicator_name)
      end
      results.push result
    end

    self
  end

end
