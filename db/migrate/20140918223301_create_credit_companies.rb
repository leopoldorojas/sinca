class CreateCreditCompanies < ActiveRecord::Migration
  def change
    create_table :credit_companies do |t|
      t.string :name
      t.string :identifier
      t.string :contact
      t.string :phone
      t.string :email
      t.string :website
      t.references :location, index: true

      t.timestamps
    end
  end
end
