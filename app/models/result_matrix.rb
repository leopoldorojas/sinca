class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators

  def calculate
    matrix={}
    dates.each do |date|
      matrix[date.strftime("%Y-%m-%d")]={}
      indicators.each do |indicator|
        result = Result.new
        result.tap do |r|
          r.average = Indicator.last_register_by_credit_company(date).average(indicator)
          r.sum = Indicator.last_register_by_credit_company(date).sum(indicator)
          r.count = Indicator.last_register_by_credit_company(date).count(indicator)
        end
        matrix[date.strftime("%Y-%m-%d")][indicator]=result
      end
    end

    matrix
  end

end
