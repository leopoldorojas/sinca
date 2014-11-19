class AddShortNameToCreditCompany < ActiveRecord::Migration
  def change
    add_column :credit_companies, :short_name, :string
  end
end
