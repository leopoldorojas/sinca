class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.datetime :register_date
      t.integer :credit_company
      t.string :file_name
      t.decimal :indicator_1
      t.decimal :indicator_2
      t.decimal :indicator_3
      t.integer :status

      t.timestamps
    end
  end
end
