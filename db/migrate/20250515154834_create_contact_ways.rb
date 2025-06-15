class CreateContactWays < ActiveRecord::Migration[8.0]
  def change
    create_table :contact_ways do |t|
      t.integer :role
      t.string :value
      t.boolean :enabled, null: false, default: true
      t.references :contactable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
