class CreateMerchants < ActiveRecord::Migration[8.0]
  def change
    create_table :merchants do |t|
      t.string :identifier
      t.string :original_identifier
      t.string :name
      t.string :slug
      t.text :description

      t.string :house_number
      t.string :street
      t.string :postcode
      t.string :city
      t.string :country
      t.string :full_address

      t.string :website
      t.string :email
      t.string :phone

      t.json :coins, null: false, default: []
      t.boolean :bitcoin, null: false, default: false
      t.boolean :lightning, null: false, default: false
      t.boolean :monero, null: false, default: false
      t.boolean :june, null: false, default: false
      t.boolean :contact_less, null: false, default: false

      t.string :icon, null: false, default: 'shop'
      t.string :category
      t.json :geometry, null: false, default: {}
      t.json :raw_feature, null: false, default: {}

      t.timestamps
    end
  end
end
