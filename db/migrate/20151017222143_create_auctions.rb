class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :item, index: true, foreign_key: true
      t.decimal :starting_price
      t.datetime :starting_time
      t.datetime :ending_time
    end
  end
end
