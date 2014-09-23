class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def calculate
    matrix={}
    dates.each do |date|
      matrix[date.strftime("%Y-%m-%d")]={}
      indicators.each do |indicator|
        result = Result.new
        result.tap do |r|
          r.average = Indicator.by_credit_company(companies).last_register_by_credit_company(date).average(indicator)
          r.sum = Indicator.by_credit_company(companies).last_register_by_credit_company(date).sum(indicator)
          r.count = Indicator.by_credit_company(companies).last_register_by_credit_company(date).count(indicator)
        end
        matrix[date.strftime("%Y-%m-%d")][indicator]=result
      end
    end

    matrix
  end

end
