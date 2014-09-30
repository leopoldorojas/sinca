class Query
  include ActiveModel::Model

  attr_accessor :end_date, :type, :location, :companies, :results
  validates :end_date, presence: true

  def run
    if location.present?
      companies_ids = []
      Location.find(location).location_and_descendants.each { |l| companies_ids.concat Location.find(l).credit_companies.ids }
    else
      # Faltan espacios y mayusculas
      companies_ids = companies.split(',').map { |company_name| CreditCompany.where("upper(name) LIKE ?", "%#{company_name.strip.upcase}%").try(:first).try(:id) }
    end

    self.results = ResultMatrix.new(dates: dates, indicators: Rails.application.config.individual_indicators.keys, companies: companies_ids.compact.uniq).results
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
