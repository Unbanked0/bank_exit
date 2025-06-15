class AddContinentCodeToDeliveryZone < ActiveRecord::Migration[8.0]
  def change
    add_column :delivery_zones, :continent_code, :string
    add_index :delivery_zones, :continent_code
  end
end
