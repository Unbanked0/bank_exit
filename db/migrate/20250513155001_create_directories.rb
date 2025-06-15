class CreateDirectories < ActiveRecord::Migration[8.0]
  def change
    create_table :directories do |t|
      t.string :name, null: false
      t.text :description
      t.string :category, null: false, index: true
      t.boolean :spotlight, null: false, default: false
      t.boolean :enabled, null: false, default: true
      t.integer :position, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
