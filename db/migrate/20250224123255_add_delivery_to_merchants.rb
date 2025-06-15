class AddDeliveryToMerchants < ActiveRecord::Migration[8.0]
  def change
    add_column :merchants, :delivery, :boolean, null: false, default: false
    add_column :merchants, :delivery_zone, :string
  end
end
