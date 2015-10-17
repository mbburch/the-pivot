class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :item, index: true, foreign_key: true
      t.references :bid, index: true, foreign_key: true
    end
  end
end
