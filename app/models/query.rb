class Query
  include ActiveModel::Model

  attr_accessor :end_date, :type, :location, :companies, :result_matrix
  validates :end_date, presence: true

  def has_results?
    result_matrix.present?
  end

  def run
    location.present? ? location.ancestors.each { |l| companies << Location.find(l).credit_companies.ids } : self.companies = companies.split(',')
    self.result_matrix = ResultMatrix.new(dates: dates, indicators: Rails.application.config.individual_indicators.keys, companies: companies).calculate
    return self
  end

  private
    
    def dates
      list_of_dates = [Time.zone.parse(end_date)]

      unless type == "all"
        date_to_include = Time.zone.parse(end_date).send("prev_#{type}".to_sym).send("end_of_#{type}")

        while date_to_include > Rails.application.config.app_start_date
          list_of_dates << date_to_include
          date_to_include = date_to_include.send("prev_#{type}".to_sym).send("end_of_#{type}")
        end
      end

      list_of_dates
    end

end
