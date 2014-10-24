class Indicator < ActiveRecord::Base
  belongs_to :credit_company
  validates :credit_company, presence: true

  class << self
    def import(credit_company, file)
    	spreadsheet = open_spreadsheet(file)
    	header = spreadsheet.row(1)
    	row = Hash[[header, spreadsheet.row(2)].transpose].each_value { |v| v.gsub!(',','') if v.is_a? String }
    	create do |i|
    	  i.register_date = Time.now
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

end
