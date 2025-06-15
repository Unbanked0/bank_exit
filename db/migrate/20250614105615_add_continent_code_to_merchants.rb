class AddContinentCodeToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :continent_code, :string
    add_index :merchants, :continent_code
  end
end
