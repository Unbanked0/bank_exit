class CreateWeblinks < ActiveRecord::Migration[8.0]
  def change
    create_table :weblinks do |t|
      t.string :url
      t.string :title
      t.boolean :enabled, null: false, default: true
      t.references :weblinkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
