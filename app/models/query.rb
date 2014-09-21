class Query
  include ActiveModel::Model

  attr_accessor :end_date, :type, :results
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
        r.average = Indicator.last_register_by_credit_company(self).average(name)
        r.sum = Indicator.last_register_by_credit_company(self).sum(name)
        r.count = Indicator.last_register_by_credit_company(self).count(name)
      end
      results.push result
    end

    self
  end

end
