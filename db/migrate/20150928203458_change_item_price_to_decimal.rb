class ChangeItemPriceToDecimal < ActiveRecord::Migration
  def change
    change_column :items, :price, :decimal
  end
end