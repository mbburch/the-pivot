class ChangeOwnerInStores < ActiveRecord::Migration
  def change
    remove_column :stores, :owner
    add_column :stores, :user_id, :integer
  end
end
