class Indicator < ActiveRecord::Base
  belongs_to :credit_company
  validate :file_name_format, if: :should_validate_file_upload?
  validate :information_consistency, if: :should_validate_information_consistency?

  class << self
    def import(credit_company, file)
    	spreadsheet = open_spreadsheet(file)
    	header = spreadsheet.row(1)
    	row = Hash[[header, spreadsheet.row(2)].transpose].each_value { |v| v.gsub!(',','') if v.is_a? String }
    	create do |i|
    	  i.register_date = Time.zone.now
    	  i.credit_company = credit_company
    	  i.file_name = file.original_filename
    	  i.status = 1
        Rails.application.config.individual_indicators.each { |k,v| i.send("#{k}=".to_sym, row[v]) }
    	end
    end

    def open_spreadsheet(file)
      case File.extname(file.original_filename)
      when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
      when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end

    def last_date_by_credit_company upto_this_date
      select("credit_company_id, max(register_date) as last_date").group(:credit_company_id).having("max(register_date) <= ?", upto_this_date)
    end
      
    def last_register_by_credit_company upto_this_date
      where('id in (?)', last_date_by_credit_company(upto_this_date).map {|i| where(credit_company_id: i.credit_company, register_date: i.last_date).take.id})
    end

    def by_credit_company companies
      companies.empty? ? all : where('credit_company in (?)', companies)
    end

    def before_of date 
      where('register_date <= ?', date)
    end 

  end

  private

    def should_validate_file_upload?
      !file_name.is_a?(String) && file_name.present?
    end

    def should_validate_information_consistency?
      !should_validate_file_upload?
    end

    def file_name_format
      errors[:base] << I18n.t('indicator.invalid_format') unless ['.csv', '.xls', '.xlsx'].include?(File.extname(file_name.original_filename))
    end

    def information_consistency
      indicators_valid = false
      Rails.application.config.individual_indicators.each { |k,v| break if (indicators_valid = self.send(k).present? && self.send(k) != 0) }
      errors[:base] << I18n.t('indicator.invalid_file') unless indicators_valid
    end

end
