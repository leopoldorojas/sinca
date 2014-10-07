class ChangeColumnCreditCompanyInIndicators < ActiveRecord::Migration
  def change
  	rename_column :indicators, :credit_company, :credit_company_id
  end
end
