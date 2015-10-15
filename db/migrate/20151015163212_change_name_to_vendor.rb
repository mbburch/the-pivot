class ChangeNameToVendor < ActiveRecord::Migration
  def change
    remove_column :stores, :name
    add_column :stores, :title, :string
  end
end
