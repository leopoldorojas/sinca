class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def calculate
    matrix={}
    dates.each do |date|
      matrix[date.strftime("%Y-%m-%d")]={}

      indicators.each do |indicator|
        indicator_base = Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        
        result = Result.new
        result.tap do |r|
          r.average = indicator_base.average(indicator)
          r.sum = indicator_base.sum(indicator)
          r.count = indicator_base.count(indicator)
        end
        
        matrix[date.strftime("%Y-%m-%d")][indicator] = result
      end

    end

    matrix
  end

end
