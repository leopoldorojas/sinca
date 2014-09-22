class Query
  include ActiveModel::Model

  attr_accessor :end_date, :type, :result_matrix
  validates :end_date, presence: true

  def has_results?
    result_matrix.present?
  end

  def execute
    self.result_matrix = ResultMatrix.new(dates: dates, indicators: Rails.application.config.individual_indicators.keys).calculate 
    return self
  end

  private
    
    def dates 
      return [end_date] if type == "all"
    end

end
