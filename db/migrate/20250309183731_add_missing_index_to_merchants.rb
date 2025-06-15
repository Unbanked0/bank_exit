class AddMissingIndexToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_index :merchants, :identifier, unique: true

    add_index :merchants, :name
    add_index :merchants, :description
    add_index :merchants, :full_address

    add_index :merchants, :category

    add_index :merchants, :bitcoin
    add_index :merchants, :lightning
    add_index :merchants, :monero
    add_index :merchants, :june
  end
end
