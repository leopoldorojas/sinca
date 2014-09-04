class Indicator < ActiveRecord::Base
  validates :credit_company, presence: true

  def self.import(credit_company, file)
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

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  private

    scope :by_date_range, -> query { where('register_date >= ? AND register_date <= ?', query.start_date, query.end_date) }

end
