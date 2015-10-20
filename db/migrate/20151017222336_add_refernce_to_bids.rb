class AddRefernceToBids < ActiveRecord::Migration
  def change
    add_reference :bids, :auction, index: true, foreign_key: true
  end
end
