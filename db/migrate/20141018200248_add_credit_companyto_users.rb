class AddCreditCompanytoUsers < ActiveRecord::Migration
  def change
  	add_reference :users, :credit_company, index: true
  end
end
