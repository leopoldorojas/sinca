class Query
  include ActiveModel::Model

  attr_accessor :start_date, :end_date, :results

  validates :start_date, presence: true
  validates :end_date, presence: true

  def has_results?
    results.present?
  end

  def execute
    self.results = []

    Rails.application.config.individual_indicators.each do |name, human_name|
      result = Result.new
      result.tap do |r|
        r.name = name
        r.human_name = human_name
        r.average = Indicator.by_date_range(self).average(name)
        r.sum = Indicator.by_date_range(self).sum(name)
        r.count = Indicator.by_date_range(self).count(name)
      end
      results.push result
    end

    self
  end

end
