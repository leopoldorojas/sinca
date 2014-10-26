class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def results
    indicators.map do |indicator|
      date_results = dates.map do |date|
        indicator_base = Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        average = false
        rule = Rails.application.config.indicator_rules[indicator] || {}

        if rule[:operated_by] == :divided_by
          average = indicator_base.sum(rule[:dividend]) / indicator_base.sum(rule[:divisor])
        end

        if rule[:operated_by] == :percentage
          new_column = []
          indicator_base.find_each { |row| new_column << ( row.send(indicator) * row.send(rule[:entire]) / 100 ) }
          average = 100 * new_column.inject(0, :+) / indicator_base.sum(indicator)
        end

        result = Result.new
        result.tap do |r|
          r.average = average || indicator_base.average(indicator)
          r.sum = indicator_base.sum(indicator)
          r.count = indicator_base.count(indicator)
        end
        
        { date: date, result: result }
      end

      { indicator: indicator, results: date_results }
    end
  end

end
