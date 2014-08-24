class Indicator < ActiveRecord::Base
  validates :credit_company, presence: true

  def self.import(credit_company, file)
	  spreadsheet = open_spreadsheet(file)
	  header = spreadsheet.row(1)
	  last_row = 2 || spreadsheet.last_row
	  (2..last_row).each do |i|
	    row = Hash[[header, spreadsheet.row(i)].transpose]
	    indicator = find_by_id(row["id"]) || new
	    indicator.attributes = row.to_hash.slice(*accessible_attributes)
	    indicator.register_date = Time.now
	    indicator.credit_company = credit_company
	    indicator.file_name = file.original_filename
	    indicator.status = 2
	    indicator.indicator_1 = row["Prestatarios (Individuales)"]
	    indicator.indicator_1 = row["Sucursales"]
	    indicator.indicator_1 = row["Saldo Bruto de Cartera de Préstamos"]
	    indicator.save!
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

end
