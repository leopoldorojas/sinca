class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def results
    indicators.map do |indicator|
      date_results = dates.map do |date|
        indicator_base = Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        
        result = Result.new
        result.tap do |r|
          r.average = indicator_base.average(indicator)
          r.sum = indicator_base.sum(indicator)
          r.count = indicator_base.count(indicator)
        end
        
        { date: date, result: result }
      end

      { indicator: indicator, results: date_results }
    end
  end

end
