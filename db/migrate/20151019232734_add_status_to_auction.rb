class AddStatusToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :status, :string, :default => "open"
  end
end
