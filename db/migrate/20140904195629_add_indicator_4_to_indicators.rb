class AddIndicator4ToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :indicator_4, :decimal
    add_column :indicators, :indicator_5, :decimal
    add_column :indicators, :indicator_6, :decimal
    add_column :indicators, :indicator_7, :decimal
  end
end
