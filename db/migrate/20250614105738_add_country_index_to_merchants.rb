class AddCountryIndexToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_index :merchants, :country
  end
end
