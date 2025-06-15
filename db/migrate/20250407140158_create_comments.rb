class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :rating, null: false, default: 0
      t.string :language, null: false
      t.string :pseudonym
      t.references :commentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
