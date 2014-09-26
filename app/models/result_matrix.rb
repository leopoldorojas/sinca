class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def results
    dates.map do |date|
      indicator_results = indicators.map do |indicator|
        indicator_base = Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        
        result = Result.new
        result.tap do |r|
          r.average = indicator_base.average(indicator)
          r.sum = indicator_base.sum(indicator)
          r.count = indicator_base.count(indicator)
        end
        
        { indicator: indicator, result: result }
      end

      { date: date, indicator_results: indicator_results }
    end
  end
  
end
