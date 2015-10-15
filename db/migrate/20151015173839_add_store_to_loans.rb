class AddStoreToLoans < ActiveRecord::Migration
  def change
    add_reference :loans, :store, index: true, foreign_key: true
  end
end
