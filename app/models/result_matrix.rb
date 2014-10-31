class ResultMatrix
  include ActiveModel::Model

  attr_accessor :dates, :indicators, :companies

  def results
    indicator_bases = {}
    indicators.map do |indicator|
      date_results = dates.map do |date|
        date_as_index = date.to_s.to_sym
        indicator_bases[date_as_index] ||= Indicator.by_credit_company(companies).before_of(date).last_register_by_credit_company(date)
        indicator_base = indicator_bases[date_as_index]
        average = false
        sums_cache = {}
        rule = Rails.application.config.indicator_rules[indicator] || {}

        if rule[:operated_by] == :divided_by
          sums_cache[rule[:dividend]] ||= indicator_base.sum(rule[:dividend])
          sums_cache[rule[:divisor]] ||= indicator_base.sum(rule[:divisor])
          average = sums_cache[rule[:dividend]] / sums_cache[rule[:divisor]] if sums_cache[rule[:divisor]] > 0
        end

        if rule[:operated_by] == :percentage
          new_column = []
          indicator_base.find_each { |row| new_column << ( (row.send(indicator) || 0) * (row.send(rule[:entire]) || 0) / 100 ) }
          sums_cache[rule[:entire]] ||= indicator_base.sum(rule[:entire])
          average = 100 * new_column.inject(0, :+) / sums_cache[rule[:entire]] if sums_cache[rule[:entire]] > 0
        end

        result = Result.new
        result.tap do |r|
          r.count = indicator_base.count(indicator)
          r.sum = sums_cache[indicator] || indicator_base.sum(indicator) unless average
          r.average = average || indicator_base.average(indicator) if r.count > 0
        end
        
        { date: date, result: result }
      end

      { indicator: indicator, results: date_results }
    end
  end

end
