class AddColumnToBids < ActiveRecord::Migration
  def change
    add_column :bids, :amount, :integer
    add_reference :bids, :user, index: true, foreign_key: true
  end
end
