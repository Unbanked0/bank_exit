class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :label
      t.string :house_number
      t.string :street
      t.string :postcode
      t.string :city
      t.string :country
      t.string :country_code
      t.float :latitude, index: true
      t.float :longitude, index: true
      t.references :addressable, polymorphic: true, null: false

      t.timestamps
    end

    add_index :addresses, %i[latitude longitude]
  end
end
