class Query
  include ActiveModel::Model

  attr_accessor :end_date, :type, :location, :companies, :executive, :results
  validates :end_date, presence: true

  def run
    companies_ids = []

    if location.present?
      Location.find(location).location_and_descendants.each { |l| companies_ids.concat Location.find(l).credit_companies.ids }
    end

    if executive.present?
      executive_ids = CreditCompany.where(executive: executive).ids
      companies_ids = location.present? ? (companies_ids & executive_ids) : executive_ids
    end

    if companies.present?
      company_name_ids = companies.split(',').map{ |company_short_name| CreditCompany.where("upper(short_name) LIKE ?", "%#{company_short_name.strip.upcase}%").try(:first).try(:id) }
      companies_ids = location.present? || executive.present? ? (companies_ids & company_name_ids) : company_name_ids
    end

    companies_ids = companies_ids.compact.uniq
    companies_ids << 0 if companies_ids.empty? && (companies.present? || location.present? || executive.present?)
    self.results = ResultMatrix.new(dates: dates, indicators: Rails.application.config.individual_indicators.keys, companies: companies_ids).results
  end

  private
    
    def dates
      list_of_dates = [Time.zone.parse(end_date).end_of_day]

      unless type == "all"
        date_to_include = Time.zone.parse(end_date).send("prev_#{type}".to_sym).send("end_of_#{type}".to_sym).send(:end_of_day)

        while date_to_include > Rails.application.config.app_start_date
          list_of_dates << date_to_include
          date_to_include = date_to_include.send("prev_#{type}".to_sym).send("end_of_#{type}".to_sym).send(:end_of_day)
        end
      end

      list_of_dates
    end

end
