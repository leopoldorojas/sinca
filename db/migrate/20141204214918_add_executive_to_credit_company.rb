class AddExecutiveToCreditCompany < ActiveRecord::Migration
  def change
    add_reference :credit_companies, :executive, index: true
  end
end
