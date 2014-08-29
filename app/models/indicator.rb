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
  	  i.status = 2
  	  i.indicator_1 = row["Prestatarios (Individuales)"]
  	  i.indicator_2 = row["Sucursales"]
  	  i.indicator_3 = row["Saldo Bruto de Cartera de Préstamos"]
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
