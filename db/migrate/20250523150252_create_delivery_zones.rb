class CreateDeliveryZones < ActiveRecord::Migration[8.0]
  def change
    create_table :delivery_zones do |t|
      t.integer :mode
      t.string :value
      t.string :city_name, index: true
      t.string :department_code, index: true
      t.string :region_code, index: true
      t.string :country_code, index: true
      t.boolean :enabled, null: false, default: true
      t.references :deliverable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
